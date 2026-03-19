---
description: First-time project setup — AI analyzes your project and generates AGENTS.md + labels
---

# Loop Init

One-time setup workflow. The AI analyzes your project and auto-generates everything needed for `/loop` to work.

> Run this once after installing Loop Kit. Re-run anytime to refresh after major project changes.

## What This Does

1. Analyzes your project structure, config files, and README
2. Generates a comprehensive `AGENTS.md` tailored to your project
3. Creates priority and component labels on GitHub
4. Verifies `gh` CLI authentication

---

## Step 1: Verify Prerequisites

// turbo
1. Check gh authentication:
   ```bash
   gh auth status
   ```
   If not authenticated, stop and instruct user to run `gh auth login`.

// turbo
2. List project files to understand the structure:
   ```bash
   ls -la
   ```

---

## Step 2: Analyze Project

1. **Read config files** — look for ANY of these (not limited to this list):
   - `package.json`, `go.mod`, `Cargo.toml`, `pom.xml`, `build.gradle`,
     `requirements.txt`, `setup.py`, `pyproject.toml`, `Makefile`,
     `CMakeLists.txt`, `Gemfile`, `composer.json`, `pubspec.yaml`,
     `*.csproj`, `Package.swift`, or any other build/project file.
   - Extract: build commands, test commands, lint commands, language, framework.

2. **Read README.md** (if exists) — extract project description and purpose.

3. **Scan directory structure** — identify components/modules:
   ```bash
   find . -maxdepth 2 -type d -not -path '*/\.*' -not -path '*/node_modules/*' -not -path '*/vendor/*' | head -30
   ```
   Look for meaningful directories like `src/auth/`, `lib/api/`, `pages/dashboard/`, etc.

4. **Read code constraints** — check for:
   - `.eslintrc*`, `tsconfig.json`, `.prettierrc`, `rustfmt.toml`, `.editorconfig`
   - CI config: `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`
   - Extract any relevant rules or constraints.

---

## Step 3: Generate AGENTS.md

If `AGENTS.md` already exists, read it first. Preserve any user customizations and enhance with detected information.

If `AGENTS.md` does not exist, create it with the following structure:

```markdown
# AGENTS.md

## Project Overview
[AI-generated description from README and config files]

## Tech Stack
- Language: [detected]
- Framework: [detected]
- Build tool: [detected]

## Build & Test Commands
[Extracted from config files — these are what /loop uses in Step 4]

| Command | Purpose |
|:--------|:--------|
| `[detected build command]` | Build the project |
| `[detected test command]` | Run tests |
| `[detected lint command]` | Lint/format check |

## Components
[Detected from directory structure — used by /loop for issue grouping]

| Component | Path | Description |
|:----------|:-----|:------------|
| [name] | [path] | [AI-inferred purpose] |

## Constraints
[Extracted from linter configs, tsconfig, etc.]

## Priorities
- Focus: [inferred from README/config]
- Source of truth: GitHub Issues
- Priority order: P0-critical > P1-high > P2-medium > P3-low

## Rules
- Run full test suite before committing
- Do not modify generated files
- Follow existing code style
```

Commit the generated `AGENTS.md`:
```bash
git add AGENTS.md && git commit -m "chore: generate AGENTS.md via /loop-init"
```

---

## Step 4: Create Labels

// turbo
1. Create priority labels:
   ```bash
   gh label create "P0-critical" --color "B60205" --description "Critical: blocks all progress" --force
   gh label create "P1-high"     --color "D93F0B" --description "High priority: core functionality" --force
   gh label create "P2-medium"   --color "FBCA04" --description "Medium priority: quality improvements" --force
   gh label create "P3-low"      --color "0E8A16" --description "Low priority: polish and nice-to-have" --force
   ```

// turbo
2. Create classification labels:
   ```bash
   gh label create "plan-needed"         --color "5319E7" --description "Requires design plan before implementation" --force
   gh label create "skip-human-decision" --color "D4C5F9" --description "Needs human decision — do not auto-implement" --force
   ```

3. Create component labels based on detected components:
   ```bash
   # For each detected component:
   gh label create "component:<name>" --color "1d76db" --description "<component description>" --force
   ```

---

## Step 5: Report to User

Present a summary of what was configured:

```
🎉 Loop Kit initialized!

📝 AGENTS.md generated:
   - Project: [name]
   - Build: [command]
   - Test: [command]
   - Components: [list]

🏷️ Labels created:
   - Priority: P0-critical, P1-high, P2-medium, P3-low
   - Classification: plan-needed, skip-human-decision
   - Components: component:auth, component:dashboard, ...

Next: Create some Issues, then type /loop to start processing.
Please review AGENTS.md and adjust if needed.
```
