---
name: create-rule
description: This skill should be used when the user wants to "add a rule", "create a rule", "write a guideline rule", or asks to document a coding convention in the guidelines repo.
version: 0.1.0
---

# Create Rule

Add a new rule to `rules/` following the contributing constraints.

## Constraint

Each rule: max 2 lines of body text (per CONTRIBUTING.md).

## Format

```md
# Rule Title

One or two sentences. Direct statement of what to do or not do.
```

## Process

1. Read CONTRIBUTING.md to confirm current constraints.
2. Determine filename from rule topic (kebab-case, `.md`).
3. Write `rules/<filename>.md` with title + ≤2 line body.
4. Do not add examples, rationale sections, or code blocks unless the 2-line limit is not exceeded.
