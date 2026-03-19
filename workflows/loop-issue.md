---
description: Process a specific issue by number — same discipline as /loop but skips auto-selection
---

# Loop Issue Workflow

Process a **specific** GitHub issue by number. Follows the same 5-step discipline as `/loop`, but skips auto-selection (Step 2) and goes directly to the specified issue.

## Usage

```
/loop-issue #5
/loop-issue 5
```

## Pre-flight Check

// turbo
1. Verify gh authentication:
   ```bash
   gh auth status
   ```

// turbo
2. Ensure clean working tree:
   ```bash
   git status --porcelain
   ```

---

## Step 1: Process Open PRs

Same as `/loop` — clear all open PRs before starting new work.

// turbo
1. Check open PRs:
   ```bash
   gh pr list --state open --json number,title,labels,reviewDecision
   ```

2. For each PR: check CI, fix failures, rebase conflicts, review code.

3. Merge ready PRs:
   ```bash
   gh pr merge <N> --squash --delete-branch
   ```

4. Clear all PRs before proceeding.

---

## Step 2: Load Specified Issue

// turbo
1. Sync to latest main:
   ```bash
   git checkout main && git pull
   ```

// turbo
2. Read the specified issue:
   ```bash
   gh issue view <N> --json number,title,labels,body,state
   ```

3. Verify the issue is actionable:
   - **Closed?** → Report to user and stop
   - **Already has an open PR?** → Report and stop
   - **Blocked on another issue?** → Report the dependency and stop

---

## Step 3: Classify & Implement

Same decision flow as `/loop`:

```
Issue loaded
  │
  ├─ Labeled "skip-human-decision"?
  │  └─ YES → Report to user why this needs human input. Stop.
  │
  ├─ Requires a specific platform?
  │  └─ Current env doesn't match → Report and stop.
  │     (User explicitly asked for this issue, so explain clearly.)
  │
  ├─ Labeled "plan-needed" OR involves architecture?
  │  ├─ Plan exists? → Round 2+ (implement next sub-task)
  │  └─ No plan? → Round 1 (produce design doc)
  │
  └─ Otherwise → Direct Implementation (TDD if applicable)
```

Follow the same implementation steps as `/loop` (branching, TDD, verification).

---

## Step 4: Verify & Submit

Same as `/loop` — run verification, push, create PR with `Closes #<N>`.

---

## Step 5: Record History

Same as `/loop` — append to `.agents/loop-history.md`.
Note: record that this issue was **manually selected** (not auto-picked by priority).

```markdown
## YYYY-MM-DD HH:MM

**PRs processed**: ...
**Issue worked**: #5 (manually selected) — <description>
**PR created**: #<M>
**Notes**: User requested this specific issue via /loop-issue
```
