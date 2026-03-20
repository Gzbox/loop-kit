# Changelog

All notable changes to Loop Kit will be documented in this file.

## [1.0.0] — 2026-03-20

### ⚠️ Breaking Changes (vs pre-release)
- **Done When is now required** in issue templates — ensures test-first flow has reliable acceptance criteria
- **Session cap default lowered** from 10 to 5 — prevents Agent context bloat (adjustable in AGENTS.md)
- **Plan Mode PR body changed** from `Closes #N` to `Relates to #N` — issue stays open for sub-task implementation

### 🔄 Plan Mode Lifecycle
- Complete review-revise-approve-implement state machine using GitHub native review states
- Plan-specific PR body template with reviewer instructions (Request Changes / Approve)
- Sub-task PR template with progress tracking (`Progress on #N — Sub-task M/total`)
- Only the final sub-task PR uses `Closes #N` to close the original issue
- Dedicated `docs/plans/<topic>.md` file format with Problem / Approach / Sub-tasks / Dependencies / Open Questions
- `/loop-issue` Plan Mode: user chooses which sub-task to implement (not auto-selected)
- Sub-task size check: warns when a sub-task touches >15 files or >3 feature areas

### 🛠️ Core Features
- `/loop` batch issue processing with auto-grouping by component
- `/loop-issue` single issue processing with manual sub-task selection
- `/loop-status` read-only grouped dashboard
- `/loop-init` zero-config project setup (AGENTS.md + labels + docs/plans/)
- Dynamic default branch detection (main, master, develop, or any branch name)
- Smart classification decision tree: Skip → Plan → Direct
- Test-first flow: Done When → test → fail → implement → pass
- Review-friendly PRs with Key Review Points, Acceptance Criteria, Test Evidence, What I Did NOT Test
- Group finalization: cross-reference backfill + file conflict detection
- Session history recording with branch protection fallback

### 🛡️ Safety & Reliability
- Agent never auto-merges any PR — all merging is human responsibility
- `--body-file` + `mktemp` for PR creation (prevents shell injection and concurrency issues)
- Branch protection auto-fallback for history commits
- Session cap (default 5) prevents Agent context bloat
- Pending PR limit (default 10) prevents review queue overflow
- 5-minute timeout for verification commands
- Platform-aware issue skipping (never claims false validation)
- Concurrent run prevention warning
- Session interruption recovery (orphaned branch detection)
- AGENTS.md staleness warning (>90 days old)
- AGENTS.md sync check: warns when PR changes package.json / build tools / test frameworks
- Scaffold lint tolerance: default template lint warnings are acceptable in scaffolding PRs
- Sub-task size guard: warns before implementing oversized sub-tasks (>15 files / >3 areas)
- Stale verification handling: project-transforming sub-tasks don't trigger false regression failures

### 📋 Templates & Automation
- Bug Report issue template (Done When required)
- Feature Request issue template (Done When required)
- PR template aligned with workflow format
- Auto-label GitHub Action (section-based parsing, mutually exclusive classification)
- One-command installer with backup mechanism and version pinning hint

### 📖 Documentation
- Bilingual guide (EN/中文) with complete Plan Mode lifecycle example
- Session Cap tuning guide
- Troubleshooting section (branch protection, fork workflow, wrong code pushed)
- Section-based auto-labeling explanation
