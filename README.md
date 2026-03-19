# 🔄 Loop Kit

A reusable, language-agnostic toolkit for structured issue processing with AI coding agents.

Turn your GitHub Issues into a disciplined development loop: **Review PRs → Pick Issue → Classify → Implement → Submit PR → Record History**.

## Quick Start

### Minimum Setup (1 file)

```bash
mkdir -p .agents/workflows
curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/workflows/loop-job.md \
  -o .agents/workflows/loop-job.md
```

Then in your AI coding agent, type **`/loop`** to start.

### Full Setup

```bash
bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
```

This will:
1. Copy workflows (`/loop` and `/loop-status`) into `.agents/workflows/`
2. Copy `AGENTS.template.md` to your project root as `AGENTS.md`
3. Copy GitHub Issue/PR templates to `.github/`
4. Create priority labels on your repo (`P0-critical` through `P3-low`)

## What's Inside

```
loop-kit/
├── workflows/
│   ├── loop-job.md              ← /loop — 5-step issue processing
│   └── loop-status.md           ← /loop-status — read-only dashboard
├── scripts/
│   └── setup-labels.sh          ← Create GitHub labels
├── templates/
│   ├── AGENTS.template.md       ← Agent behavior contract
│   └── github/
│       ├── ISSUE_TEMPLATE/
│       │   ├── bug_report.yml
│       │   ├── feature_request.yml
│       │   └── config.yml
│       ├── PULL_REQUEST_TEMPLATE.md
│       └── workflows/
│           └── auto-label-issues.yml
├── install.sh                    ← One-command installer
└── README.md
```

## The Loop (5 Steps)

```
┌─────────────────────────────────────────┐
│  /loop                                  │
├─────────────────────────────────────────┤
│                                         │
│  Pre-flight ──→ Step 1: Process PRs     │
│                    │                    │
│                    ▼                    │
│              Step 2: Select Issue       │
│                    │                    │
│                    ▼                    │
│              Step 3: Classify &         │
│                      Implement          │
│                    │                    │
│                    ▼                    │
│              Step 4: Verify & Submit    │
│                    │                    │
│                    ▼                    │
│              Step 5: Record History     │
│                                         │
└─────────────────────────────────────────┘
```

### Pre-flight
Verify `gh` auth, ensure clean working tree.

### Step 1: Process Open PRs
Review and merge existing PRs. Fix CI failures. Clear the queue.

### Step 2: Select Next Issue
Sort by priority (`P0` > `P1` > `P2` > `P3`). Check dependencies. Skip already-WIP issues.

### Step 3: Classify & Implement
- **Skip**: needs human decision
- **Plan Mode**: architecture/design → produce `docs/plans/<topic>.md` first
- **Direct**: clear scope → implement with TDD (or direct if no test infra)

### Step 4: Verify & Submit
Run build/test, create PR with `Closes #N`.

### Step 5: Record History
Append iteration summary to `.agents/loop-history.md` for next-round context.

## Features

| Feature | Description |
|---------|-------------|
| 🔄 Structured loop | 5-step disciplined flow |
| 📊 Dashboard | `/loop-status` — quick read-only overview |
| 🏷️ Auto-labeling | GitHub Action applies labels from Issue form dropdowns |
| 📝 History tracking | Each iteration logged for cross-round context |
| 🛡️ Pre-flight checks | Auth + clean tree verification |
| 🎯 Smart classification | Skip / Plan / Direct decision tree |
| 📋 PR template | Consistent PR structure |
| 🔧 Flexible | Works with any language, any stack, with or without tests |

## Flexibility

The toolkit adapts to your project:

- **No priority labels?** Agent reads issue bodies and assesses priority
- **No test framework?** Skips TDD, implements directly
- **No `AGENTS.md`?** Uses sensible defaults
- **Trivial fix?** Skips classification, just fixes and PRs
- **Blocked issue?** Skips it, picks the next one

## Requirements

- [`gh` CLI](https://cli.github.com/) authenticated with repo access
- An AI coding agent that supports `/workflow` commands (e.g., Antigravity, Claude Code)

## License

MIT
