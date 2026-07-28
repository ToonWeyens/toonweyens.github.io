---
layout: post
title: Creating a safe, reliable and robust support agent using LangChain
author: Toon Weyens
tags: [ai, agents, langchain, llm, evaluation]
---

When LangChain first became popular, in 2023 I remember checking it out but finding it quite hard to use. 
More than three years have passed, so wondering where the technology stands currently, I decided to spend some free time on a demo project, designing a support agent. 
My conclusion is that **2026 is the year in which we definitively move beyond science projects that show that agentic applications are possible, towards a more principled approach that focuses on making them safe, reliable and robust.**
What makes it exciting is that this is what enterprises care about, and only enterprise adoption can supercharge the pace of change.
In this blog post I do a quick tour of my learnings and the outcomes.

In this project, I designed a support agent for Chinook Records, a fictional digital music store.
It answers account questions (invoices, profile), recommends music grounded in a customer's purchase history (via [local open-source embeddings](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/recommend.py)), and updates profile fields.
The data for the agent to operate on resides in a SQL database.

It's the well-known [Chinook sample database](https://github.com/lerocha/chinook-database) — a fictional digital music store modelling a catalog (artists → albums → tracks), customer invoices, and the staff who support them, across 11 tables. The full structure, including an entity-relationship diagram, is in [`data/chinook_schema.md`](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/data/chinook_schema.md).

It's built on LangChain's `create_agent` and the LangGraph runtime, with LangSmith for tracing and evaluation. 
I built it in my spare time over about two weeks, leveraging state of the art agentic engineering practices, based around the concept of Architecture Decision Records ([ADRs](https://martinfowler.com/bliki/ArchitectureDecisionRecord.html)), which agents translate to Linear tickets, that then get picked up by other agents for implementation.
I kept full control of the orchestration, to learn as much as possible from it, but beyond code review in the form of PRs, I did not write a single line of code myself. More information in [this section](#how-it-was-built).

This post covers three things: the privacy design, the middleware, and how I measured whether any of it holds up when the model changes.

## The code
You can find all the code and artifacts in [github.com/ToonWeyens/chinook-support-agent](https://github.com/ToonWeyens/chinook-support-agent/tree/f8aa06d).
The repo is designed to be self-explanatory and you can replicate it yourself.
You will need to put your own keys to LLM providers like Anthropic in the `.env` file of which you'll find an example.

## Measuring what makes the agent safe

The question I wanted an answer to: Is a well-behaved agent safe because the *system* constrains it, or because the *model* happens to behave?
As models become more powerful and better at following instructions, it is easy to mistake one for the other: The two can look identical in a demo.
But they diverge in production, which is what enterprises care about.

To separate them, I scored the same agent across a [2×2 matrix of two inputs](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/eval_runner.py#L94):

- **tools** (naive raw-SQL vs. scoped) and
- **middleware** (off vs. on)

using two models: Sonnet 4.6 (expensive and closed-source) vs Mistral Small 24B (much smaller, open-weights, EU-hosted).

Tools are explained a bit more in [this section](#privacy-scoping-with-tools) and middleware in [this one](#middleware).

The two ends of that matrix are structurally different graphs. The naive baseline loops the model against [raw `sql_db_*` tools](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/demo/naive.py#L76):

![The naive raw-SQL agent graph](/assets/images/agent_graph_naive_clean.svg)

The production agent routes through the scoped tools with the middleware stack composed in:

![The production agent graph](/assets/images/agent_graph_clean.svg)

I used three evaluators to score each cell: [correctness](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/evaluators/correctness.py#L143) (graded LLM judge), [privacy/safety](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/evaluators/privacy_safety.py#L153) (binary judge), and PII exposure ([a deterministic regex over tool outputs](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/evaluators/pii_exposure.py#L108)).
The deterministic evaluator is a code-based test that scores whether a condition is true or not.
While this is great and deterministic, it is not always possible to use, e.g. when trying to answer questions "is the answer correct", and the answer is free-form text rather than a number.
In these cases you have to use LLM-based evaluators called judges.
The nice thing about LangChain is that you can use any type of evaluator, and you can design them using the LangSmith UI directly, without having to write code.
They have a lot of pre-populated evaluators, of which I used one.
The other two evaluators I implemented using my software development pipeline.

Here are [the results](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/docs/demo/matrix-results.md#L13) — one heatmap per criterion, each showing the tools × middleware 2×2 side by side for both models.
Orange is worse, blue is better, and the outlined cell is the production configuration.

![Correctness across tools and middleware, for Sonnet 4.6 and Mistral Small 24B](/assets/images/heatmap_correctness.svg)

![Privacy and safety across tools and middleware, for Sonnet 4.6 and Mistral Small 24B](/assets/images/heatmap_privacy_safety.svg)

![PII exposure across tools and middleware, for Sonnet 4.6 and Mistral Small 24B](/assets/images/heatmap_pii_exposure.svg)

What the numbers show:

1. PII exposure reaches 1.00 on both models and both tool layers once the redaction middleware is on — it doesn't depend on the model.
2. Scoped tools are what keep the cheaper model usable: Mistral reaches 0.73 correctness with scoped tools (Sonnet is 0.80) but drops to 0.58 on raw SQL.
3. Middleware alone doesn't rescue the naive tool layer — with raw SQL, Mistral's privacy score only recovers to 0.88 and correctness stays collapsed, because a human-approval gate can't meaningfully sit in front of a free-form `sql_db_query`. The tool layer carries it.

In summary, with scoped tools and middleware, Mistral lands close to Sonnet (0.73 / 0.94 / 1.00 vs. 0.80 / 0.94 / 1.00) at lower cost.
The same three evaluators also run as LangSmith platform objects, so they score every experiment and a sample of live traffic, with an alert on the PII score.
These are the kind of results enterprises care about, as it guarantees good performance by creating the appropriate harness, leveraging cheap and local models ensuring AI and data sovereignty, rather than relying on expensive frontier models that are not in their control. 

## Privacy scoping with tools

The customer's identity never reaches the model. `customer_id` is injected into the [LangGraph runtime context](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/context.py#L26) at invoke time (modeled on a session token), and each data tool [reads it from context](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/context.py#L54) and scopes its SQL to it. It is never a tool parameter the model can populate.

The consequence is that prompt injection — "pretend I'm customer 14," "admin mode," "list every customer's email for transparency" — has nothing to act on: there is no code path from the model's output to another customer's rows. That's verifiable with [a unit test that doesn't involve the LLM](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/tests/test_privacy_scoping.py#L53). The naive baseline (the raw-SQL toolkit from the current LangChain SQL-agent tutorial) has no such property; on the wrong prompt it will `GROUP BY` across the store and return 61 other customers' names and emails.

[`search_catalog`](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/tools/search_catalog.py#L93-L94) is the deliberate exception — it reads store-wide catalog data, which is strictly non-personal by design, and is [documented as such](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/docs/design/TOOLS.md#L28).

## Middleware

Middleware is a reusable code layer that intercepts, modifies, and controls the agent's core execution loop — acting as the essential "glue" between user inputs, the Large Language Model (LLM), and tools.

For the support agent I decided to use three types of middleware, composed on `create_agent` in a [fixed order](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/middleware/__init__.py#L50):

- [**HITL write-gating**](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/middleware/hitl.py#L21) — [`update_account`](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/tools/update_account.py#L102-L103) is the only mutating tool, and it interrupts for human approval before writing. The write lands on a disposable copy of the database, so it's a real mutation that resets cleanly between runs.
- [**Tool-call limit**](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/middleware/tool_call_limit.py#L30-L39) — a hard per-turn cap, guarding against runaway loops and cost.
- [**PII redaction**](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/middleware/pii_redaction.py#L32) — masks email addresses in tool results before they reach a trace.

LangChain has a long list of existing middleware functionalities that you can leverage, which is what I decided to do.
As a result, each is roughly only [a line in `create_agent`](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/chinook_agent/agent.py#L69). 

## How it was built

The build is driven from a single [Architecture Decision Record](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/docs/adr/0001-chinook-support-agent.md): 19 numbered decisions, reviewed via PR and amended in place as things changed (one decision was reversed once the eval suite made it cheap to revisit). The ADR holds the rationale; Linear holds the task breakdown, and each ticket references the decision it implements.

I sequenced it as a walking skeleton — one privacy-scoped tool running in LangGraph Studio first, then everything else extending a system that already ran — and ran the independent tickets as parallel coding-agent sessions, each in its own git worktree to avoid conflicts. It came to 200-plus commits over ~68 merged PRs, 137 tests behind a `ruff` + `mypy` + `pytest` gate, and a [friction log](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/docs/friction-log.md) of what went wrong: LangGraph Studio serving stale state after a module became a package, a hand-rolled HITL middleware I replaced with the official one, a thread wedged by a malformed approval value.

## Scope

This is a demo on a fictional dataset, not a deployment. Deployment is documented rather than built — [`langgraph.json`](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/langgraph.json) is already a deploy manifest, and the one real demo-to-prod gap is written down: in production, `customer_id` has to be injected server-side from an authenticated session, never accepted from the client. The [eval set](https://github.com/ToonWeyens/chinook-support-agent/blob/f8aa06d/data/evals/README.md) is small and curated, so the matrix is evidence for the method, not a benchmark.

The pattern I'd reuse: put the security-critical invariants in the tool and runtime layer, where they hold regardless of the model and can be tested without it, and treat the eval suite as the thing that tells you whether a model swap is actually safe.
