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

Same as `/loop` — see [loop-job.md](loop-job.md) Pre-flight Check.

---

## Step 1: Process Open PRs

Same as `/loop` — see [loop-job.md](loop-job.md) Step 1. Clear all open PRs before starting new work.

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

Same decision flow as `/loop` — see [loop-job.md](loop-job.md) Step 3.

> **Note**: If the specified issue is labeled `skip-human-decision` or requires a platform that doesn't match, explain clearly to the user (they explicitly asked for this issue).

---

## Step 4: Verify & Submit

Same as `/loop` — see [loop-job.md](loop-job.md) Step 4.

---

## Step 5: Record History

Same as `/loop` — see [loop-job.md](loop-job.md) Step 5.
Note: record that this issue was **manually selected** (not auto-picked by priority).

```markdown
## YYYY-MM-DD HH:MM

**PRs processed**: ...
**Issue worked**: #5 (manually selected) — <description>
**PR created**: #<M>
**Notes**: User requested this specific issue via /loop-issue
```
