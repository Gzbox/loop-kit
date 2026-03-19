# AGENTS.md

Agent guidance for working on **{{PROJECT_NAME}}**.

## Project overview

{{Brief description of the project, what it does, and its current state.}}

## Current priorities

Follow this order unless the user explicitly asks otherwise:

1. Correctness and runtime reliability
2. Tests and repeatable validation
3. Product behavior and interaction quality
4. Packaging and product polish
5. Release hardening

## Source of truth for planning

When deciding what to work on next, prefer these sources in order:

1. GitHub issue labels and priority
2. `TODO.md` (if exists)
3. `docs/roadmap.md` (if exists)
4. Issue body content

Do not invent a new priority order unless the user explicitly asks.

## Build and test commands

Use these commands for verification:

```bash
{{BUILD_COMMAND}}
{{TEST_COMMAND}}
{{LINT_COMMAND (optional)}}
```

If any command is not applicable, remove it. If no test framework exists yet, note that here so the agent knows not to force TDD.

## Environment and platform constraints

{{Describe target platform, language version, package manager, and any constraints.}}

Example:
- macOS 14+ / Swift 6 / SPM
- Node.js 20+ / pnpm
- Python 3.12 / uv

## Editing rules

- Keep changes focused
- Avoid broad refactors unless clearly justified by the current issue
- Do not silently rename the product or key identifiers unless the task is specifically about naming
- Do not introduce speculative abstractions without immediate value
- Do not claim validation that did not actually happen

## Testing guidance

When you change logic, add or update tests where practical.

Highest-value test targets in this repo:
- {{List your most important testable components}}

If no test infrastructure exists, note it here. The agent should still write correct code but won't be forced into TDD.

## Documentation rules

If you materially change architecture, workflow, or validation expectations, update the relevant docs.

Most likely docs to update:
- `README.md`
- `TODO.md`
- {{Other project docs}}

Keep `TODO.md` high-level. Do not turn it into a duplicate of the issue tracker.

## Good outcomes for agent work

A strong contribution usually does one or more of:
- Improves runtime reliability
- Removes a known risk
- Adds focused tests around core behavior
- Clarifies the architecture or execution plan
- Leaves the next contributor with clearer state

## Bad outcomes to avoid

- Adding features while leaving known core problems untouched
- Claiming success without actual validation
- Adding speculative abstractions without immediate value
- Making the repo look more polished while the core is still fragile
- Scattering information across multiple docs without keeping them consistent

## Delivery checklist

Before wrapping up a change, verify:
- [ ] Change is aligned with the current priority plan
- [ ] Relevant docs are updated (if they became stale)
- [ ] No validation was overstated
- [ ] The next contributor has clearer state, not murkier state
