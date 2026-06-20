---
layout: cv-compact
title: Curriculum Vitae
permalink: /cv.html
config:
  social:
    linkedin: true
    github: true
    scholar: true
  contact:
    location: true
    phone: false
    email: true
  author:
    birthdate: false
    nationality: true

headline: "Forward-deployed AI engineer - turning ambiguous enterprise problems into production-grade agentic systems."
profile_summary: >-
  Customer-facing applied-AI engineer with a decade turning ambiguous, high-value enterprise problems into shipped solutions, happy to work on-site with customers.
  Build production LLM agents that reason, plan, and act across tools, APIs, and sensitive data, with eval-driven quality (accuracy, safety, latency) and privacy enforced by architecture.
  Trusted partner to C-level and engineering stakeholders across regulated industries (e.g finance, healthcare, insurance, telecom, and defense) for customers including BP, IQVIA, T-Mobile, Sky, and Zalando; led PoCs and enterprise evaluations generated more than €7M+ in ARR in the last two years.
values: "Meaningful work · Radical transparency · Curiosity and experimentation · Ownership and excellence · Positive impact"

# --- EXPERIENCE ---
experience:
  - role: Senior Sales Engineer
    company: Anomalo
    dates: Mar '24 - Current
    summary: >-
      Partner with C-level and senior data leaders at global enterprises and AI-native companies, combining data science, architecture, and business consulting.
    bullets:
      - "<strong>Translate ambiguous, high-value problems into well-framed solutions</strong> with clear success criteria and evaluation methodology, leading multi-stakeholder PoCs and enterprise evaluations across finance, healthcare, and telecom (BP, IQVIA, T-Mobile, Sky, Zalando). Over €7M in multi-year contracts."
      - "<strong>Engage executive sponsors</strong> (CDOs, CIOs, Heads of Data) to define success metrics and architect scalable, compliant, security-first solutions, navigating enterprise security, procurement, and data-governance review to surface risk early."
      - "<strong>Champion Generative AI in production</strong>, collaborating with product and R&D to shape Anomalo's new genAI-powered agentic data-quality product for unstructured data."

  - role: University Lecturer
    company: Eindhoven University of Technology
    dates: Jan '25 - Current
    summary: >-
      Teach plasma physics and HPC computational methods in the Applied Physics and Nuclear Fusion programs. Communicating complex material to expert and non-expert audiences.

  - role: Presales Solutions Architect > Global Team Lead
    company: Dataloop
    dates: Nov '22 - Mar '24
    summary: >-
      Operationalized AI data pipelines (computer vision, NLP, multimodal) from prototype to production at scale for large enterprises, while leading a global presales team.
    bullets:
      - "<strong>Owned use cases end-to-end</strong> across automotive, defense, insurance, and telco, flexing into whatever the problem demanded and generating approximately €1M in new ARR over 18 months."
      - "<strong>Set delivery patterns and architectural standards across a distributed team</strong> as global lead of the Presales Solutions Architecture function, aligning regional priorities and raising technical quality company-wide."
      - "<strong>Co-created ROI-backed AI adoption roadmaps</strong> with executive stakeholders, a clear path from pilot to production, feeding field insight back into Product and R&D."

  - role: Customer-Facing Data Scientist, Pre-Sales
    company: DataRobot
    dates: Oct '21 - Nov '22
    summary: >-
      Helped large organizations accelerate AI maturity, translating complex ML capabilities into clear business value across enterprise accounts.
    bullets:
      - "<strong>Led technical PoVs</strong> for enterprise customers in utilities, insurance, and manufacturing, connecting AI to strategic KPIs/ROI and aligning AI strategy with governance alongside IT and data-science leaders."
      - "<strong>Delivered executive-level demos and workshops</strong> on scaling AI safely across the enterprise, applying value-based selling (MEDDICC). Won the pre-sales MVP Award (2021)."

  - role: Industrial Data Science Consultant
    company: MathWorks
    dates: Jan '19 - Aug '21
    bullets:
      - "<strong>Drove over €1.5M in additional ARR</strong> by deploying server-based enterprise data-science platforms (integrated with live data streams and CI/CD) across the Benelux region; AWS- and Kubernetes-certified, specialized in IoT, parallel/cloud computing, and HPC."

  - role: Postdoctoral Monaco Fellow
    company: ITER Organization
    dates: Jan '17 - Dec '18
    summary: >-
      Published multiple first-author papers on plasma edge stability, combining analytical modeling with HPC simulation at ITER.

# --- EDUCATION ---
education:
  - degree: Ph.D. in Plasma Physics
    uni: Universidad Carlos III de Madrid · TU/e · ITER
    dates: 2012 - 2016
    summary: >-
      Plasma stability and 3-D effects in magnetic-confinement fusion; first-author publications and a dedicated HPC numerical code (PB3D). EPS Ph.D. Research Award; expert in modern Fortran and high-performance parallel computing.

  - degree: M.Sc. Nuclear Fusion Science & Technology
    uni: Ghent University · UC3M · Université de Lorraine
    dates: 2010 - 2012
    summary: >-
      Erasmus Mundus joint master's across three European universities (top 5% of class).

  - degree: M.Sc. Energy Engineering
    uni: University of Leuven · TU Berlin
    dates: 2008 - 2010

# --- PROFESSIONAL DEVELOPMENT ---
certifications:
  - name: Agentic AI
    issuer: Andrew Ng (DeepLearning.AI)
    dates: 2025
    summary: >-
      Agentic systems: tool use, planning agents (ReAct and plan-and-execute), and multi-agent coordination, with robust evaluation and reflection patterns (<a href="https://learn.deeplearning.ai/certificates/20e9e975-a086-486e-a49b-8c362f70b3b6?usp=sharing">cert</a>).

  - name: Fine-tuning & RL for LLMs
    issuer: AMD (DeepLearning.AI)
    dates: 2025
    summary: >-
      Post-training of LLMs: SFT and RLHF alignment, PPO/GRPO, reward-hacking evaluation, and efficiency methods such as LoRA (<a href="https://learn.deeplearning.ai/certificates/1285f616-ed75-4045-af2e-735c42188bf1?usp=sharing">cert</a>).

  - name: Mastering LLMs for Developers
    issuer: Dan Becker, Hamel Husain (Maven)
    dates: 2024
    summary: >-
      Production LLM development: fine-tuning open-source models, instrumentation with LangSmith, iterative RAG, and deployment with Gradio, Modal, and Hugging Face (<a href="https://maven.com/certificate/qlKgeXcL">cert</a>).

  - name: Autumn HPC School 2025
    issuer: Supercomputing center at the TU/e
    dates: 2025
    summary: >-
      GPU computing and accelerating Python workloads, with a focus on deep-learning and LLM workloads (<a href="https://supercomputing.tue.nl/blog/2025/autumn-hpc-school/">website</a>).

# --- SELECTED PROJECTS ---
projects:
  - name: "Production-Grade LLM Support Agent (LangChain · LangGraph · LangSmith)"
    dates: 2026
    description: |
      End-to-end, production-grade LLM customer-support agent (fictional music store) on the LangGraph runtime, instrumented with LangSmith and engineered spec-first (Architecture Decision Record, scoped tickets, tests, CI). Source on request.
      <ul>
        <li><strong>Agentic architecture</strong>: LangChain on LangGraph in a ReAct-style reason-and-act loop, with a five-tool surface (account and recommendation domains) including one approval-gated write tool.</li>
        <li><strong>Security &amp; privacy as architecture, not prompt</strong>: every tool SQL-scoped to the caller's runtime identity (never a model-fillable argument) so the model cannot leak another customer's data; plus HITL write-gating, PII redaction, and tool-call limits, verified by a jailbreak red-team. Reliable, observable, auditable.</li>
        <li><strong>Eval-driven &amp; sovereignty-ready</strong>: a LangSmith dataset with graded correctness/groundedness and binary privacy/safety evaluators, plus side-by-side config scoring (accuracy, safety, latency); provider-agnostic (single swappable model string), local offline OSS embeddings, EU data residency.</li>
      </ul>

  - name: Decentralized Stablecoin Risk Architecture
    dates: 2026
    description: |
      Interim technical lead on a pilot to determine the optimal storage architecture for the risk engine behind a major decentralized stablecoin's next-generation, autonomous (agentic) on-chain capital framework. Framed storage and data-modeling options against access patterns, performance, and verifiability; bridged external stakeholders and internal engineers in ambiguity and drove the pilot to a successful outcome.

  - name: "PB3D - Peeling-Ballooning in 3-D"
    dates: 2013 - Current
    description: |
      Developed and maintain a modern high-performance, parallel Fortran code for peeling-ballooning stability in 3-D magnetic-confinement fusion devices (<a href="https://github.com/ToonWeyens/PB3D">GitHub</a>): clean, performant, well-tested production code and long-term ownership of a real open-source project.

  - name: Kraemer
    dates: 2018
    description: |
      Co-created an automated trading framework in Python for high-frequency arbitrage across exchanges, integrating mathematical modeling, deep learning, and financial data engineering with a focus on latency-sensitive order execution.

# --- SKILLS ---
skills:
  - category: AI Engineering
    bullets:
      - "<strong>Agentic AI and LLMs</strong>: production tool-calling agents with orchestration frameworks (LangChain, LangGraph) that plan and act across tools, APIs, and data sources. ReAct and plan-and-execute patterns, middleware (human-in-the-loop, PII redaction), memory/context management, MCP, structured output."
      - "<strong>RAG &amp; retrieval</strong>: embeddings / vector retrieval (RAG) with local offline OSS embedding models; provider-agnostic, model-swappable design across frontier and open-weight models."
      - "<strong>LLMOps &amp; evaluation</strong>: tracing, datasets, and LLM-as-judge evaluation/monitoring with LangSmith; evaluation frameworks for accuracy, safety, and latency, well beyond trial and error."
      - "<strong>Security-first &amp; sovereign deployment</strong>: privacy enforced by architecture, compliance, auditability, and self-hosted open-weight models. An on-prem / private-cloud posture for data residency and cost control."
      - "<strong>ML foundations</strong>: Deep Learning (PyTorch), classical ML (scikit-learn), Bayesian modeling (PyMC3, GPy, GPyOpt); Transformers, CNNs, RNNs, VAEs, sequence models; post-training (SFT, RLHF, LoRA)."

  - category: Programming
    bullets:
      - "<strong>Python (production)</strong>: clean, testable, observable code. Packaging and tooling (uv), data/ML (numpy, pandas, PyTorch), with ruff + type-check gates and CI."
      - "<strong>AI-assisted &amp; agentic engineering</strong>: ship projects end-to-end with spec-driven workflows (Architecture Decision Records, scoped tickets, agentic automation, testing, human PR review)."
      - "<strong>Frontend &amp; APIs</strong>: REST and FastAPI; UIs with Streamlit and Gradio; JavaScript / TypeScript (working knowledge). Flex into any technical area, including frontend, when the problem calls for it."
      - "<strong>Other languages &amp; HPC</strong>: Fortran (HPC, PB3D), C++, MATLAB, SQL, Bash, YAML; MPI, OpenMP, SLURM/PBS, PETSc/SLEPc, CUDA concepts; numerical algorithm design."

  - category: Cloud & Infrastructure
    bullets:
      - "<strong>Cloud, containers &amp; CI/CD</strong>: AWS (Certified Solutions Architect), Azure; Docker, Kubernetes (CKAD certified); GitHub Actions, git; IaC exposure (Terraform, Ansible); observability with LangSmith, Sentry, Prometheus/Grafana."
      - "<strong>Data &amp; lakehouse</strong>: Spark and Delta Lake; ETL/ELT with Airflow across Databricks and Snowflake; on a foundation of deep distributed-compute (HPC) experience."

  - category: Customer & Communication
    bullets:
      - "<strong><a href=\"https://meddicc.com/meddic/\">MEDDPICC / MEDDIC</a> &amp; Insight Selling</strong>: enterprise sales qualification and storytelling-based consultative methodology for value-based selling."
      - "<strong>Executive communication</strong>: lead technical discussions and advise VP / C-level audiences, technical and non-technical; experienced working on-site with enterprise customers."

  - category: Languages
    text: "English (fluent) · Dutch (fluent) · Spanish (fluent) · Portuguese (fluent) · French (advanced) · German (intermediate) · Italian (basic)"
---
