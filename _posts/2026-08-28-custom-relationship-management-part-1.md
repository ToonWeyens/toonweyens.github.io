---
layout: post
title: Custom(er) Relationship Management, part 1
author: Toon Weyens
tags: [sales, crm, ai, build-vs-buy]
published: true
---

*Always be building. This is part 1 of a series of three about sales tools that you build and do not buy.*

In the gold rush, the sellers of shovels made safer profits than the gold miners.
Sales kept the language of that time:
The word *prospecting* comes from the search for gold.
The shovel business also continues today:
A full industry sells tools to people who sell.
This industry has CRM licenses, implementation partners, admin certificates, and connector marketplaces.
I have worked in such a role as technical expert for years, working with prospective and existive customers, serving as their technical point of contact and helping them achieve their goals.

However, I am also an inveterate tool builder.
So earlier this year, I did the opposite of what a salesperson usually does.
I refused to buy the shovel.
I made my own shovel.
I built a complete prospecting engine.
The engine is a web application with sign-in, a production database, hosting, automatic backups, and monitoring.
It currently connects directly to Slack and to my document tools.

I paid no license.
I spoke with no vendor.
I attended no configuration workshops.
The costs are a small European VPS, a few euros each month, and an AI subscription (Claude) that I already pay.

Half of my experience is commercial: prospecting, pipeline, proposals, and sales operations.
The other half is technical: computational physics and enterprise AI architecture.
This series shows what occurs when the two halves want the same tool.

## The demo that fits nobody

Each CRM demo shows a different company's sales process with your logo on it.
The demo is attractive.
The workflow is almost yours.
The word "almost" is the expensive part.

You buy the licenses.
Then you pay an implementation partner to adjust the tool to your process.
Then you appoint an admin to maintain those adjustments.
Two years later, the team does its real work in spreadsheets and puts a summary in the CRM on Friday afternoons.
If you have ever worked with a sales team, you know a version of this story.

The vendors do not cheat you.
Their product must be an average of thousands of sales processes.
Thus it can match your process only partly.
Configuration makes the difference smaller.
The difference never becomes zero, because "configurable" means that you can select only from their options.

## The important number is 100%

I will not claim a savings multiplier.
My claim is about fit.
The fit is 100%, because the tool is exactly what I want.

When you buy, you select from options.
When you build, you make decisions.
Each field on each screen exists because I decided to put it there.
A prospect in my engine is not "an Account with custom fields".
It has only the states that occur in my real process.
Its grades are my grades.

Its deadlines send alerts to Slack, where I already look.
Nothing else is on the screen.
The tool contains my sales process and zero other ideas.

This table shows the exchange.

| You lose | You get |
|---|---|
| Per-seat licenses and the renewal calendar | A VPS bill of a few euros each month |
| The implementation partner | An AI subscription |
| Configuration workshops | A specification of what you want |
| Connector fees for each integration | One afternoon for each integration |
| Feature requests on the vendor's roadmap | New features on the day that you want them |
| A difference that never becomes zero | 100% fit |

Note that the second column contains obligations, not only savings.
Backups, monitoring, sign-in, and an audit trail become your tasks.

In part 2 shows how I do these tasks at production quality without a team.
The short answer is that these tasks cost discipline, not extra people.

In part 3 I'll show that the data schema is at the heart of everything, making this possible.


## The condition

This works only if you know exactly what you want.
The cause of the success is not the AI, and not a developer.
The cause is domain knowledge.
I specified this engine precisely because I participated in some sales process or another for years.
I know what makes a prospect qualified.
I know the purpose of each deadline.

I know what a salesperson must have before a talk with a decision maker.
An expert with an unclear wish list gets an unclear tool.
The quality of the AI does not change that.
To know what you want is less common than to know how to write code.

You do this specification work also when you buy.
Each buyer of a CRM produces requirement documents, score matrices, and workshop notes.
When you build, the same text goes to an AI agent.
The agent supplies the result in minutes.
A partner only schedules the next meeting.

## You own the data

The data is mine, in a plain Postgres database.
One command exports all of it.
The team can grow without per-seat costs.
I have no lock-in and no renewal date.
When my process changes, the tool changes in the same afternoon.

## When to buy

A purchase is better in these conditions:

- You need hundreds of seats, have no time to set up single sign-on across departments, and want to work with approved vendors with a service-level agreement (SLA).
- Compliance rules say that you must have a certified third party.
- Your sales process is standard, so the difference is small and a license is the cheap option.
- No person in the company can say exactly what the tool must do.

The last condition is the most important.
A license also does not solve that problem.

## The part that nobody believes

One fact remains, and engineers do not believe it easily.
I built all of this, and I did not read even one line of the code.
I did not open even one file.
Part 2 tells you how that is possible.
It also tells you why this is a story about management, not about programming.

*Part 2 comes next. It tells how I built the engine and did not read the code.*
