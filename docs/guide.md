# Loop Kit Usage Guide / 使用教程

> A complete, step-by-step guide to using Loop Kit in your projects.
>
> 完整的逐步教程，教你如何在项目中使用 Loop Kit。

---

## Table of Contents / 目录

- [1. Prerequisites / 前置条件](#1-prerequisites--前置条件)
- [2. Installation / 安装](#2-installation--安装)
- [3. First-Time Setup / 首次配置](#3-first-time-setup--首次配置)
- [4. Using /loop / 使用 /loop](#4-using-loop--使用-loop)
- [5. Using /loop-issue / 使用 /loop-issue](#5-using-loop-issue--使用-loop-issue)
- [6. Using /loop-status / 使用 /loop-status](#6-using-loop-status--使用-loop-status)
- [7. Customization / 自定义配置](#7-customization--自定义配置)
- [8. How Auto-Labeling Works / 自动标签的工作原理](#8-how-auto-labeling-works--自动标签的工作原理)
- [9. Iteration History / 迭代历史](#9-iteration-history--迭代历史)
- [10. Troubleshooting / 常见问题](#10-troubleshooting--常见问题)
- [11. Best Practices / 最佳实践](#11-best-practices--最佳实践)

---

## 1. Prerequisites / 前置条件

### Required / 必需

| Tool | Purpose | Installation |
|:-----|:--------|:-------------|
| [GitHub CLI (`gh`)](https://cli.github.com/) | Interact with GitHub Issues, PRs, Labels | `brew install gh` (macOS) / [Other OS](https://github.com/cli/cli#installation) |
| AI Coding Agent | Execute the `/loop` workflow | [Antigravity](https://antigravity.dev), [Claude Code](https://claude.ai/code), etc. |

### Verify Installation / 验证安装

```bash
# Check gh CLI is installed / 检查 gh CLI 是否安装
gh --version
# Expected: gh version 2.x.x

# Check authentication / 检查认证状态
gh auth status
# Expected: ✓ Logged in to github.com as <your-username>
```

If not authenticated, run: / 如果未认证，运行：

```bash
gh auth login
```

Follow the prompts to authenticate via browser or token.

按提示通过浏览器或 Token 完成认证。

---

## 2. Installation / 安装

### Option A: Full Install (Recommended) / 完整安装（推荐）

Navigate to your project root and run: / 进入项目根目录后运行：

```bash
bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
```

You'll see output like: / 你会看到类似输出：

```
🔄 Loop Kit Installer (main)

📥 Workflows...
   ✅ .agents/workflows/ (loop-job, loop-issue, loop-status, loop-init)
📥 Templates...
   ✅ .github/ (issue templates, PR template, auto-label action)
   ✅ .agents/.loop-kit-version (main)

🎉 Loop Kit installed!

Next:
  1. /loop-init  — AI analyzes your project, generates AGENTS.md + labels
  2. /loop       — start processing issues
```

### Version Pinning / 版本锁定

Pin to a specific release for reproducibility: / 锁定到指定版本以确保可复现：

```bash
bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh) --version v2.0.0
```

### Installer Options / 安装器选项

| Flag | Effect | 说明 |
|:-----|:-------|:-----|
| *(none)* | Install everything | 安装全部 |
| `--version <tag>` | Install a specific version | 安装指定版本 |
| `--help` | Show usage help | 显示帮助信息 |

---

## 3. First-Time Setup / 首次配置

### Run /loop-init / 运行 /loop-init

After installation, type `/loop-init` in your AI agent. The AI will:

安装后，在你的 AI 智能体中输入 `/loop-init`。AI 会：

1. Analyze your project structure, config files, and README / 分析项目结构、配置文件和 README
2. Auto-generate `AGENTS.md` with build/test commands / 自动生成含构建/测试命令的 `AGENTS.md`
3. Create labels (priority, classification, component, platform) / 创建标签（优先级、分类、组件、平台）
4. Report results for your review / 报告结果供你审查

> **💡 Tip / 提示**: Review the generated `AGENTS.md` and adjust if needed. The AI does its best but you know your project better.
>
> 查看生成的 `AGENTS.md` 并按需调整。AI 会尽力而为，但你更了解你的项目。

### Create GitHub Issues / 创建 GitHub Issues

Go to your repo's Issues tab. You'll see:

进入仓库的 Issues 页面。你会看到：

- **Bug Report** — for reporting bugs (auto-labeled `bug`)
- **Feature Request** — for suggesting features (auto-labeled `enhancement`)

Create a few issues to give `/loop` something to work on:

创建几个 Issue 以便 `/loop` 有任务可以处理：

**Example Bug Report: / 示例 Bug Report：**
```
Title: App crashes when clicking submit button
Priority: P1-high — core functionality broken
Description:
  What happened: The app crashes with a TypeError
  Expected behavior: Form should submit successfully
  Steps to reproduce: 1. Open form  2. Click submit
Done When: No crash on submit, form data saved correctly
```

**Example Feature Request: / 示例 Feature Request：**
```
Title: Add dark mode support
Priority: P2-medium — quality of life improvement
Implementation Approach: Plan needed — requires design/architecture discussion first
Description:
  What: Dark mode theme toggle
  Why: Users have requested it for late-night usage
Done When: User can toggle between light and dark themes
```

### Commit Installed Files / 提交安装文件

```bash
git add .agents/ .github/
git commit -m "chore: install Loop Kit"
git push
```

> **Note**: `AGENTS.md` is committed separately by `/loop-init` in the step above.

---

## 4. Using /loop / 使用 /loop

### Starting a Loop / 启动一次循环

In your AI coding agent, simply type:

在你的 AI 编程智能体中，直接输入：

```
/loop
```

The agent will execute the full workflow automatically, processing **all actionable issues** grouped by component.

智能体会自动执行完整工作流，按组件分组处理**所有可操作的 Issue**。

### What Happens in Each Step / 每步做了什么

#### Pre-flight / 预检

The agent verifies: / 智能体验证以下内容：

1. `gh auth status` — Is GitHub CLI authenticated? / GitHub CLI 是否已认证？
2. `git status --porcelain` — Is the working tree clean? / 工作树是否干净？
3. Version check — Is Loop Kit up to date? (informational only) / 版本检查 — Loop Kit 是否为最新？（仅提示）

If auth or working tree check fails, the agent stops and reports to you. The version check only prints a notice if an update is available.

如果认证或工作树检查失败，智能体会停止并报告。版本检查仅在有更新时显示提示。

#### Step 1: Check PRs + Verify Main / 检查 PR + 验证主干

```
Agent: "Pulling latest main and running tests..."
  → npm test ✅ (all passing)
Agent: "Found 2 open PRs. Let me check them..."
  → #15: CI ✅, has review comment → fixing per feedback, pushing
  → #18: CI failing → fixing test, pushing fix
  → #20: No review yet → skipping (awaiting review)
Agent: "PR status reported. Moving to issue scanning."
```

The agent: / 智能体会：
- **Verifies main health** — runs tests, fixes if broken / 验证主干健康
- **Addresses review feedback** — reads comments, fixes code, pushes / 处理 review 反馈
- Fixes CI failures / 修复 CI 失败
- **Reports status, does NOT merge** / **报告状态，不合并（人来合并）**

#### Step 2: Scan & Auto-Group / 扫描并自动分组

```
Agent: "Scanning 8 open issues..."
  → #1, #3, #7 all relate to auth module → Group: auth
  → #2, #5 both about dashboard → Group: dashboard
  → #10 standalone → Standalone
Agent: "3 groups identified. Starting with Group: auth (P0)"
```

Grouping rules: / 分组规则：
1. Uses `component:xxx` labels if present / 如有 `component:xxx` 标签则直接用
2. Otherwise AI infers from titles/bodies / 否则 AI 从标题/内容推断
3. Max 5 per group, ≤2 issues skips grouping / 每组最多 5 个，≤2 个跳过分组

#### Step 3: Classify & Implement / 分类并实现

The agent reads the issue body and decides the approach:

智能体阅读 Issue 内容并决定处理方式：

| Decision / 决策 | When / 条件 | Action / 动作 |
|:----------------|:-----------|:-------------|
| **Skip** | Labeled `skip-human-decision` | Report to user, pick another / 报告给用户，选下一个 |
| **Skip (blocked)** | Labeled `has-dependencies`, dependency still open | Skip, report: "Blocked by #N" / 跳过，报告："被 #N 阻塞" |
| **Skip (platform)** | Labeled `depends-<platform>`, current env doesn't match | Skip with comment, never claim false validation / 跳过并注释，绝不声称虚假验证 |
| **Plan Mode** | Labeled `plan-needed` or involves architecture | Produce `docs/plans/<topic>.md` first / 先出设计文档 |
| **Direct** | Clear scope and acceptance criteria | Implement immediately / 立即实现 |

**Direct Implementation example: / 直接实现示例：**

```
Agent: "Issue #12 is clear scope → Direct Implementation"
  → git checkout -b issue-12-fix-login-timeout
  → Writing failing test... ✅ (fails for the right reason)
  → Implementing fix... ✅
  → Test passes ✅
  → npm run build ✅
```

**Plan Mode example: / 规划模式示例：**

```
Agent: "Issue #20 needs architecture → Plan Mode (Round 1)"
  → git checkout -b plan-20-auth-redesign
  → Analyzing codebase...
  → Producing docs/plans/auth-redesign.md:
      - Problem statement
      - Proposed changes with file list
      - Sub-tasks: [1] Refactor AuthContext [2] Add OAuth provider [3] Update tests
  → Committing plan (no code changes yet)
  → Creating PR for review
```

Next `/loop` invocation, the plan's first sub-task will be implemented (Round 2+).

下一次 `/loop` 调用时，计划的第一个子任务将被实现（Round 2+）。

#### Step 4: Verify & Submit / 验证并提交

```
Agent: "Running verification..."
  → npm run build ✅
  → npm test ✅ (14 passing)
Agent: "Creating review-friendly PR..."
  → PR #22 created with:
    • Group: auth (1/3 — see also PR #23, #24)
    • Key Review Points: login.ts:45-52
    • Merge after: — (first in group)
Agent: "Checking for more issues in group auth..."
  → #3 remaining → looping back to Step 2
```

Each PR includes: / 每个 PR 包含：
- **Group info** — `Group: auth (1/3)` / 分组信息
- **Key Review Points** — which lines to focus on / 重点看哪几行
- **Merge order** — `Merge after: PR #X` / 合并顺序
- **Testing guidance** — what to test after merging the group / 合并后测什么

#### Step 5: Review Checklist / Review 清单

After all issues are processed, the agent outputs a **human review checklist**:

所有 Issue 处理完毕后，智能体输出**人的 review 清单**：

```markdown
## 2026-03-19 14:30 — Session Summary

### 📋 Your Review Queue

#### Group: auth (3 PRs, P0)
Issues: #1, #3, #7
PRs: #22, #23, #24
Merge order: #22 → #23 → #24
After merge, test: login flow, token refresh, session expiry

#### Group: dashboard (2 PRs, P1)
Issues: #2, #5
PRs: #25, #26
Merge order: any
After merge, test: chart rendering, filter functionality

### ⏭️ Skipped
- #9 (depends on #7)
```

This gives you a clear, grouped to-do list for review.

这给你一个清晰的、分组的 review 待办清单。

---

## 5. Using /loop-issue / 使用 /loop-issue

To process a **specific** issue instead of letting the agent auto-select:

要处理一个**指定的** Issue 而非让智能体自动选取：

```
/loop-issue #5
/loop-issue 5
```

### How It Differs from /loop / 与 /loop 的区别

| | `/loop` | `/loop-issue #N` |
|:--|:--------|:------------------|
| Step 1 (PRs) | Same / 相同 | Same / 相同 |
| Step 2 (Select) | Auto-select by priority / 按优先级自动选取 | **Skip — go directly to #N** / **跳过 — 直接处理 #N** |
| Step 3-5 | Same / 相同 | Same / 相同 |
| History note | Auto-selected | "manually selected" |

### When to Use / 何时使用

- You know exactly which issue you want fixed / 你明确知道想修哪个 Issue
- You want to override the priority order / 你想覆盖优先级顺序
- The issue is blocked by priority rules but you want it done now / Issue 被优先级规则阻塞但你现在就想做

### Safety Checks / 安全检查

The agent still validates before starting: / 智能体在开始前仍会验证：

- Is the issue open? / Issue 是否打开？
- Does it already have a PR? / 是否已有 PR？
- Is it blocked by dependencies? (`has-dependencies` label → check referenced issues) / 是否被依赖阻塞？

If any check fails, the agent reports and stops. / 任何检查失败，智能体会报告并停止。

---

## 6. Using /loop-status / 使用 /loop-status

Type `/loop-status` for a quick, read-only overview of your project:

输入 `/loop-status` 可快速查看项目的只读概览：

```
/loop-status
```

**Example output: / 示例输出：**

```
=== PRs Awaiting Your Review ===

Group: auth (3 PRs)
  #22 Fix login crash         CI ✅  ready for review
  #23 Token refresh fix       CI ✅  ready for review
  #24 Session expiry          CI ✅  ready for review
  → Review together, merge: #22 → #23 → #24

Group: dashboard (2 PRs)
  #25 Chart rendering fix     CI ✅  ready for review
  #26 Filter fix              CI ⏳  running
  → Wait for #26 CI, then review together

=== Open Issues ===
P0-critical: (none)
P1-high: #7, #25
P2-medium: #20
P3-low: #30
Unlabeled: #31

=== Last Session ===
(shows recent loop-history.md entries)
```

The agent then provides a recommended next action:

然后智能体会给出推荐的下一步操作：

```
Suggested: Review auth group PRs (#22-#24), then run /loop
```

---

## 7. Customization / 自定义配置

### Custom Labels / 自定义标签

Labels are created automatically by `/loop-init` based on your project structure — including priority, classification, component, and platform labels (e.g., `depends-macos`). To update labels after project changes, re-run `/loop-init`.

标签由 `/loop-init` 根据你的项目结构自动创建 —— 包括优先级、分类、组件和平台标签（如 `depends-macos`）。项目变动后如需更新标签，重新运行 `/loop-init` 即可。

### Custom Issue Templates / 自定义 Issue 模板

The installed templates in `.github/ISSUE_TEMPLATE/` can be customized:

可以自定义安装到 `.github/ISSUE_TEMPLATE/` 的模板：

```yaml
# .github/ISSUE_TEMPLATE/bug_report.yml
name: Bug Report
description: Report a bug
labels: ["bug", "needs-triage"]     # ← add your own labels / 添加自定义标签
body:
  - type: dropdown
    id: priority
    attributes:
      label: Priority
      options:
        - P0-critical — blocks all progress
        - P1-high — core functionality broken
        - P2-medium — quality issue
        - P3-low — minor / cosmetic
        # ← add more levels if needed / 按需添加更多级别
```

### Adjusting the Workflow / 调整工作流

The workflow files in `.agents/workflows/` are plain Markdown — you can edit them:

`.agents/workflows/` 中的工作流文件是纯 Markdown —— 你可以直接编辑：

| Customization / 自定义项 | File / 文件 | How / 方法 |
|:------------------------|:-----------|:----------|
| Change merge strategy | `loop-job.md` Step 1 | Step 1 only checks PRs; merge strategy is your choice when merging |
| Skip PR processing | `loop-job.md` | Remove Step 1 entirely |
| Add custom verification | `loop-job.md` Step 4 | Add your own commands after build/test |
| Change branch naming | `loop-job.md` Step 3 | Modify the `git checkout -b` pattern |
| Add more dashboard sections | `loop-status.md` | Add new `gh` query steps |

---

## 8. How Auto-Labeling Works / 自动标签的工作原理

When installed, an **auto-label GitHub Action** runs on every new issue:

安装后，每当创建新 Issue 时会运行一个**自动标签 GitHub Action**：

```
New Issue Created
       │
       ▼
Parse Issue Body
       │
       ├─ Contains "P0-critical"? → Add label: P0-critical
       ├─ Contains "P1-high"?     → Add label: P1-high
       ├─ Contains "P2-medium"?   → Add label: P2-medium
       ├─ Contains "P3-low"?      → Add label: P3-low
       ├─ Contains "Plan needed"? → Add label: plan-needed
       ├─ Contains "Human decision"? → Add label: skip-human-decision
       └─ "Depends On" has #N refs? → Add label: has-dependencies
```

**This means**: When users fill in the Issue Form dropdown (e.g., selecting "P1-high" for priority), the corresponding label is applied automatically. No manual labeling needed!

**这意味着**：当用户在 Issue 表单下拉菜单中选择优先级（如选择 "P1-high"）时，对应标签会自动添加。无需手动打标签！

The Action file is at `.github/workflows/auto-label-issues.yml`.

---

## 9. Iteration History / 迭代历史

### What Gets Recorded / 记录了什么

After each `/loop` run, a summary is appended to `.agents/loop-history.md`:

每次 `/loop` 运行后，会在 `.agents/loop-history.md` 追加一条摘要：

```markdown
# Loop History

## 2026-03-19 14:30 — Session Summary

### 📋 Your Review Queue

#### Group: auth (3 PRs, P0)
Issues: #1, #3, #7
PRs: #22, #23, #24
Merge order: #22 → #23 → #24
After merge, test: login flow, token refresh, session expiry

#### Standalone
PR: #25 — added input validation (P2)

### ⏭️ Skipped
- #14 (needs human decision)

### 📊 Stats
PRs created: 4 | Issues processed: 4 | Skipped: 1

## 2026-03-19 10:00 — Session Summary

### 📋 Your Review Queue
PR: #15 — fixed database connection crash (P0)

### ⏭️ Skipped
- #14 (needs human decision)
```

### Why It Matters / 为什么重要

- The agent reads this file at the start of each `/loop` / 智能体在每次 `/loop` 开始时读取此文件
- Prevents duplicate work across sessions / 防止跨会话的重复工作
- Provides context about prior decisions / 提供关于先前决策的上下文
- Helps track overall velocity / 帮助追踪整体进度

### Should You Commit It? / 是否应该提交？

**Yes** — committing `.agents/loop-history.md` is recommended. It becomes a persistent audit trail that carries across agent sessions.

**是的** —— 建议提交 `.agents/loop-history.md`。它会成为跨智能体会话持久化的审计记录。

---

## 10. Troubleshooting / 常见问题

### "gh CLI not authenticated" / "gh CLI 未认证"

```bash
# Solution / 解决方案
gh auth login
# Select GitHub.com → HTTPS → Login with browser
```

### "Working tree is dirty" / "工作树不干净"

```bash
# Option 1: Stash changes / 方案 1：暂存更改
git stash

# Option 2: Commit changes / 方案 2：提交更改
git add -A && git commit -m "wip: save progress"
```

### "No actionable issues" / "没有可处理的 Issue"

This means all open issues are either: / 这意味着所有打开的 Issue 要么：
- Already have open PRs / 已有 PR
- Blocked by dependencies / 被依赖阻塞
- Labeled `skip-human-decision` / 被标记为需要人工决策

**Solution**: Create new issues, close blocking issues, or remove the `skip-human-decision` label.

**解决方案**：创建新 Issue、关闭阻塞 Issue、或移除 `skip-human-decision` 标签。

### "gh pr create fails" / "gh pr create 失败"

The agent will automatically try `gh pr create --fill` as a fallback. If it still fails:

智能体会自动尝试 `gh pr create --fill` 作为降级方案。如果仍然失败：

```bash
# Check repo permissions / 检查仓库权限
gh repo view --json permissions

# Manually create PR / 手动创建 PR
gh pr create --title "Your title" --body "Closes #N"
```

### Agent doesn't recognize /loop / 智能体不识别 /loop

Make sure the workflow file is in the correct location:

确保工作流文件在正确的位置：

```bash
# Must exist at one of: / 必须存在于以下位置之一：
.agents/workflows/loop-job.md
.agent/workflows/loop-job.md
_agents/workflows/loop-job.md
_agent/workflows/loop-job.md
```

The file name `loop-job.md` maps to the `/loop` command (strips the `-job` suffix).

文件名 `loop-job.md` 映射到 `/loop` 命令（去掉 `-job` 后缀）。

---

## 11. Best Practices / 最佳实践

### Issue Quality / Issue 质量

| Practice / 做法 | Why / 原因 |
|:----------------|:----------|
| Write clear acceptance criteria in "Done When" / 在 "Done When" 中写清验收标准 | Agent knows exactly when to stop / 智能体知道何时该停止 |
| Use priority labels consistently / 一致地使用优先级标签 | Ensures correct processing order / 确保正确的处理顺序 |
| Break large features into small issues / 大功能拆成小 Issue | One issue = one PR, keeps changes reviewable / 一个 Issue = 一个 PR，保持可审查性 |
| Use the "Depends On" field for dependencies / 使用 "Depends On" 字段声明依赖 | Agent reliably skips blocked issues / 智能体可靠地跳过被阻塞的 Issue |

### AGENTS.md / 智能体契约

| Practice / 做法 | Why / 原因 |
|:----------------|:----------|
| List ALL build/test commands / 列出所有构建测试命令 | Agent can verify its own work / 智能体能验证自己的工作 |
| Document platform constraints / 记录平台约束 | Prevents impossible validation claims / 防止声称无法进行的验证 |
| Keep it updated / 保持更新 | Stale docs lead to wrong agent behavior / 过时文档导致智能体行为错误 |

### Workflow Cadence / 工作流节奏

| Pattern / 模式 | Recommendation / 建议 |
|:---------------|:---------------------|
| Daily check-in / 每日签到 | Run `/loop-status` in the morning to see what's pending / 早上运行 `/loop-status` 查看待办 |
| Focused session / 专注处理 | Run `/loop` — it processes all actionable issues in one session / 运行 `/loop` —— 一次处理所有可操作的 Issue |
| Review PRs regularly / 定期审查 PR | The agent creates PRs, you review and merge / 智能体创建 PR，你审查并合并 |

---

<div align="center">
<sub>Part of <a href="https://github.com/Gzbox/loop-kit">Loop Kit</a> — Structured Issue Processing for AI Coding Agents</sub>
</div>
