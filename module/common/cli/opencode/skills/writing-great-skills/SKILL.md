---
name: writing-great-skills
description: Skill authoring principles — invocation model, information hierarchy, leading words, pruning, failure modes, testing and evaluation. Load ONLY when writing or editing SKILL.md content. Do NOT load for skill configuration, permissions, or MCP setup — use oh-my-opencode-slim instead.
---

A skill exists to wrangle determinism out of a stochastic system. **Predictability** — the agent taking the same *process* every run, not producing the same output — is the root virtue; every principle below serves it.

This skill covers the full lifecycle: crafting sound principles, drafting the skill, testing, evaluating with the user, and iterating.

---

## Principles

### Invocation

Two choices, trading different costs:

- **Model-invoked**: agent fires autonomously *and* other skills reach it. Costs **context load** — the description sits in every turn. Write a description with rich trigger phrases ("Use when…, mentions…").
- **User-invoked**: only the user can invoke it. Zero context load, but costs **cognitive load** — the user must remember it. Set `disable-model-invocation: true`.

Pick model-invocation only when the agent must reach the skill on its own. When user-invoked skills multiply, cure with a **router skill**: one user-invoked skill that names the others.

### Information Hierarchy

Content sits on a three-rung ladder, ranked by how immediately the agent needs it:

1. **In-skill step** — ordered actions in `SKILL.md`. Each step ends on a **completion criterion**: a checkable condition that tells the agent the work is done.
2. **In-skill reference** — definitions, rules, facts consulted on demand.
3. **External reference** — pushed out of `SKILL.md` into a linked file, loaded only when needed.

Push too little down and the top bloats; push too much and you hide material the agent needs. **Progressive disclosure** is the move down the ladder.

### Leading Words

A **leading word** is a compact concept already in the model's pretraining that anchors behaviour in the fewest tokens (e.g. *tight*, *thorough*, *seam*, *red-green-refactor*). Hunt for restatements a single leading word could replace — you win twice: fewer tokens and a sharper hook for the agent.

### Pruning

Keep each meaning in a **single source of truth**. Check every line for **relevance**: does it still bear on what the skill does? Then hunt **no-ops** sentence by sentence: if removing a sentence wouldn't change behaviour, delete it.

### Failure Modes

- **Premature completion** — finishing a step before it's genuinely done. Fix: sharpen the completion criterion.
- **Duplication** — same meaning in more than one place. Costs maintenance and tokens.
- **Sediment** — stale layers from adding without pruning.
- **Sprawl** — too long even when every line is live. Cure: the ladder — disclose reference behind pointers.
- **No-op** — a line the model already obeys by default. Test: does it change behaviour versus the default?

---

## Skill Anatomy

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter (name, description required)
│   └── Markdown instructions
└── Bundled Resources (optional)
    ├── scripts/    — Executable code for deterministic/repetitive tasks
    ├── references/ — Docs loaded into context as needed
    └── assets/     — Templates, icons, fonts
```

Keep SKILL.md under ~500 lines. If approaching this limit, add hierarchy layers with clear pointers about where to go next.

### Domain organization

When a skill supports multiple domains/frameworks, organize by variant so the agent reads only the relevant reference:

```
cloud-deploy/
├── SKILL.md
└── references/
    ├── aws.md
    └── gcp.md
```

---

## Creating a Skill

### Capture Intent

Start by understanding what the skill should do. If the current conversation already contains a workflow to capture, extract answers from the conversation history. Confirm with the user before proceeding:

1. What should this skill enable the agent to do?
2. When should it trigger? (what user phrases/contexts)
3. What's the expected output format?
4. Should we set up test cases? Skills with objectively verifiable outputs (file transforms, code generation) benefit from tests. Subjective outputs (writing style) often don't.

### Interview & Research

Ask about edge cases, input/output formats, success criteria, and dependencies. Check available MCPs for research — search docs, find similar skills, look up best practices.

### Write the SKILL.md

- **name**: Skill identifier
- **description**: Primary triggering mechanism — include what it does AND when to use it. Make descriptions slightly "pushy" to counter undertriggering. Instead of "How to build a dashboard", write "Make sure to use this whenever the user mentions dashboards, data visualization, or wants to display company data."
- **compatibility**: Required tools, dependencies (optional)

### Writing Style

- Prefer the imperative form.
- Explain **why** things matter instead of heavy-handed MUSTs.
- Include examples with "Input" / "Output" patterns.
- Use theory of mind — make the skill general, not narrow to specific examples.
- Define output formats with exact templates.

---

## Testing & Evaluation

### Create Test Cases

After writing the draft, come up with 2-3 realistic test prompts — the kind of thing a real user would say. Share them: "Here are a few test cases I'd like to try. Do these look right?"

Before saving, ensure `evals/` is in `.gitignore` (add if missing). Save to `evals/evals.json`:

```json
{
  "skill_name": "example-skill",
  "evals": [
    {
      "id": 1,
      "prompt": "User's task prompt",
      "expected_output": "Description of expected result",
      "files": []
    }
  ]
}
```

### Run & Evaluate

Before organizing, ensure `*-workspace/` is in `.gitignore` (add if missing). Organize results into `<skill-name>-workspace/iteration-N/`.

**For each test case**, spawn two subagents in the same turn — one with the skill, one without (baseline). While runs are in progress, draft quantitative assertions. Good assertions are objectively verifiable with descriptive names.

When runs complete:
1. **Grade** each run against assertions.
2. **Aggregate** into a benchmark with pass rate, time, and tokens.
3. **Launch a viewer** for the user to review outputs and leave feedback.

### Iterate

Read the feedback and improve the skill. Key guidelines:

- **Generalize from feedback** — the skill must work across many prompts, not just the test cases.
- **Keep the prompt lean** — remove things that aren't pulling their weight. Read transcripts, not just outputs.
- **Explain the why** — LLMs have good theory of mind. Reframe instead of using ALL CAPS MUSTs.
- **Bundle repeated work** — if test subagents all wrote similar helper scripts, write it once and bundle it in `scripts/`.

Rerun test cases into a new iteration directory and repeat until the user is satisfied.

---

## Description Optimization

After the skill is solid, optimize its description for triggering accuracy:

1. Generate ~20 eval queries — a mix of should-trigger and should-not-trigger. Focus on realistic, substantive queries with detail.
2. Present to the user for review via an HTML template.
3. Run the optimization loop in the background. This evaluates the current description, proposes improvements based on failures, and iterates up to 5 rounds.
4. Update the SKILL.md frontmatter with the `best_description` result.

---

## Communicating with the User

Users span a wide range of technical familiarity. Judge context cues:
- "evaluation" and "benchmark" are borderline but OK for most
- "JSON" and "assertion" need stronger technical cues before using without explanation

It's OK to briefly explain terms when in doubt.
