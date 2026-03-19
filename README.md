<div align="center">

# 🔄 Loop Kit

**Structured Issue Processing Toolkit for AI Coding Agents**

**面向 AI 编程智能体的结构化 Issue 处理工具包**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub Release](https://img.shields.io/github/v/release/Gzbox/loop-kit)](https://github.com/Gzbox/loop-kit/releases)
[![GitHub Issues](https://img.shields.io/github/issues/Gzbox/loop-kit)](https://github.com/Gzbox/loop-kit/issues)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Gzbox/loop-kit/pulls)

[English](#-overview) · [中文](#-概述) · [📖 Guide / 使用教程](docs/guide.md)

---

*Turn your GitHub Issues into a disciplined development loop.*

*将你的 GitHub Issues 变为一套有纪律的开发闭环。*

</div>

<br/>

## 📖 Overview

Loop Kit is a **reusable, language-agnostic** toolkit that transforms GitHub Issues into a structured, repeatable workflow for AI coding agents. No matter your tech stack, Loop Kit gives your agent a disciplined 5-step loop:

**Review PRs → Pick Issue → Classify → Implement → Submit PR → Record History**

## 📖 概述

Loop Kit 是一个**可复用、语言无关**的工具包，它将 GitHub Issues 转化为面向 AI 编程智能体的结构化、可重复工作流。不论你的技术栈如何，Loop Kit 都能为你的智能体提供一套有纪律的五步闭环：

**审查 PR → 选取 Issue → 分类 → 实现 → 提交 PR → 记录历史**

<br/>

## 🚀 Quick Start / 快速开始

### Minimum Setup (1 file) / 最小安装（1 个文件）

```bash
mkdir -p .agents/workflows
curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/workflows/loop-job.md \
  -o .agents/workflows/loop-job.md
```

Then type **`/loop`** in your AI coding agent to start.

在你的 AI 编程智能体中输入 **`/loop`** 即可启动。

### Full Setup / 完整安装

```bash
bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
```

<details>
<summary><b>What does this do? / 这会做什么？</b></summary>

| Step | Description | 说明 |
|:-----|:------------|:-----|
| 1 | Copy workflows (`/loop`, `/loop-status`) into `.agents/workflows/` | 安装工作流文件到 `.agents/workflows/` |
| 2 | Copy `AGENTS.template.md` to project root as `AGENTS.md` | 复制智能体行为契约模板到项目根目录 |
| 3 | Copy GitHub Issue / PR templates to `.github/` | 安装 GitHub Issue / PR 模板 |
| 4 | Create priority labels (`P0-critical` … `P3-low`) on your repo | 在仓库中创建优先级标签 |

</details>

### Installer Options / 安装器选项

```bash
REPO="https://raw.githubusercontent.com/Gzbox/loop-kit/main"
bash <(curl -sL $REPO/install.sh) --workflows-only   # Only workflows / 仅安装工作流
bash <(curl -sL $REPO/install.sh) --no-labels         # Skip label creation / 跳过标签创建
bash <(curl -sL $REPO/install.sh) --no-agents-md      # Skip AGENTS.md / 跳过 AGENTS.md
bash <(curl -sL $REPO/install.sh) --version v1.0.0    # Pin to version / 锁定版本
```

<br/>

## 🔄 The Loop / 处理闭环

```
┌──────────────────────────────────────────────┐
│                   /loop                      │
├──────────────────────────────────────────────┤
│                                              │
│  Pre-flight ──► Step 1: Process PRs          │
│                     │                        │
│                     ▼                        │
│               Step 2: Select Issue           │
│                     │                        │
│                     ▼                        │
│               Step 3: Classify & Implement   │
│                     │                        │
│                     ▼                        │
│               Step 4: Verify & Submit        │
│                     │                        │
│                     ▼                        │
│               Step 5: Record History         │
│                                              │
└──────────────────────────────────────────────┘
```

| Phase | EN | 中文 |
|:------|:---|:-----|
| **Pre-flight** | Verify `gh` auth & clean working tree | 验证 `gh` 认证和干净的工作树 |
| **Step 1** | Review & merge open PRs, fix CI failures | 审查并合并已有 PR，修复 CI 失败 |
| **Step 2** | Sort by priority (`P0` > `P1` > `P2` > `P3`), check deps, skip WIP | 按优先级排序，检查依赖，跳过进行中的 |
| **Step 3** | Classify: **Skip** (needs human) · **Plan** (design doc first) · **Direct** (clear scope, implement) | 分类：**跳过**（需人工决策）· **规划**（先出设计文档）· **直接**（范围明确，直接实现） |
| **Step 4** | Run build & tests, create PR with `Closes #N` | 运行构建和测试，创建关联 PR |
| **Step 5** | Append iteration summary to `.agents/loop-history.md` | 将本轮摘要追加到历史记录文件 |

<br/>

## 📁 Project Structure / 项目结构

```
loop-kit/
├── workflows/
│   ├── loop-job.md                # /loop — 5-step issue processing
│   ├── loop-status.md             # /loop-status — read-only dashboard
│   └── loop-multi.md              # /loop-multi — multi-repo loop
├── scripts/
│   └── setup-labels.sh            # Create GitHub labels
├── templates/
│   ├── AGENTS.template.md         # Agent behavior contract (EN)
│   ├── AGENTS.template.zh-CN.md   # Agent behavior contract (中文)
│   └── github/
│       ├── ISSUE_TEMPLATE/
│       │   ├── bug_report.yml
│       │   ├── feature_request.yml
│       │   └── config.yml
│       ├── PULL_REQUEST_TEMPLATE.md
│       └── workflows/
│           └── auto-label-issues.yml
├── docs/
│   └── guide.md                   # Usage tutorial (EN/中文)
├── install.sh                     # One-command installer
├── CONTRIBUTING.md                # Contributing guide (EN/中文)
└── README.md
```

<br/>

## ✨ Features / 特性

| | Feature / 特性 | Description / 描述 |
|:--|:--------------|:-------------------|
| 🔄 | **Structured Loop** / 结构化闭环 | Disciplined 5-step issue processing flow / 有纪律的五步 Issue 处理流程 |
| 📊 | **Dashboard** / 仪表盘 | `/loop-status` — quick read-only project overview / 快速只读项目概览 |
| 🌐 | **Multi-Repo** / 多仓库 | `/loop-multi` — process issues across repos in sequence / 按顺序跨仓库处理 Issue |
| 🏷️ | **Auto-labeling** / 自动标签 | GitHub Action applies labels from Issue form dropdowns / 从 Issue 表单下拉选项自动打标签 |
| 📝 | **History Tracking** / 历史追踪 | Each iteration logged for cross-round context / 每轮迭代记录上下文，便于后续回溯 |
| 🛡️ | **Pre-flight Checks** / 预检 | Auth + clean tree verification before start / 启动前验证认证和工作树状态 |
| 🎯 | **Smart Classification** / 智能分类 | Skip / Plan / Direct decision tree / 跳过 / 规划 / 直接实现的决策树 |
| 📋 | **PR Template** / PR 模板 | Consistent PR structure across iterations / 跨迭代的一致 PR 结构 |
| 🔧 | **Flexible** / 灵活适配 | Works with any language, any stack / 适用于任何语言、任何技术栈 |

<br/>

## 🎛️ Flexibility / 灵活性

Loop Kit adapts intelligently to your project setup:

Loop Kit 会智能适配你的项目配置：

| Scenario / 场景 | Behavior / 行为 |
|:----------------|:----------------|
| No priority labels / 无优先级标签 | Agent reads issue bodies and assesses priority / 智能体读取 Issue 正文自行评估优先级 |
| No test framework / 无测试框架 | Skips TDD, implements directly / 跳过 TDD，直接实现 |
| No `AGENTS.md` / 无 `AGENTS.md` | Uses sensible defaults / 使用合理的默认值 |
| Trivial fix / 简单修复 | Skips classification, just fixes and PRs / 跳过分类，直接修复并提 PR |
| Blocked issue / 被阻塞的 Issue | Skips it, picks the next one / 跳过当前，选取下一个 |

<br/>

## 📋 Prerequisites / 前置条件

| Requirement / 依赖 | Description / 说明 |
|:-------------------|:-------------------|
| [`gh` CLI](https://cli.github.com/) | Authenticated with repo access / 已认证且有仓库访问权限 |
| AI Coding Agent | Supports `/workflow` commands (e.g., Antigravity, Claude Code) / 支持 `/workflow` 命令的 AI 编程智能体 |

<br/>

## 📖 Documentation / 文档

For a complete step-by-step tutorial, see the **[Usage Guide](docs/guide.md)**.

完整的逐步使用教程，请参阅 **[使用指南](docs/guide.md)**。

<br/>

## 📄 License / 许可证

This project is licensed under the [MIT License](LICENSE).

本项目基于 [MIT 许可证](LICENSE) 开源。

---

<div align="center">
<sub>Built with ❤️ by <a href="https://github.com/Gzbox">Gzbox</a></sub>
</div>
