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

Loop Kit is a **reusable, language-agnostic** toolkit that transforms GitHub Issues into a structured, repeatable workflow for AI coding agents. No matter your tech stack, Loop Kit gives your agent a disciplined loop:

**Check PRs → [Auto-Group → Select Issue → Implement → Submit PR] × N → Review Checklist**

## 📖 概述

Loop Kit 是一个**可复用、语言无关**的工具包，它将 GitHub Issues 转化为面向 AI 编程智能体的结构化、可重复工作流。不论你的技术栈如何，Loop Kit 都能为你的智能体提供一套有纪律的闭环：

**检查 PR → [自动分组 → 选取 Issue → 实现 → 提交 PR] × N → Review 清单**

<br/>

## 🚀 Quick Start / 快速开始

### Install / 安装

```bash
bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
```

### First-time Setup / 首次配置

```
git add . && git commit -m 'chore: add Loop Kit' && git push
/loop-init          ← AI analyzes your project, generates AGENTS.md + labels
```

### Start Working / 开始工作

```
/loop               ← Process all issues (grouped, review-friendly PRs)
/loop-issue #5      ← Process a specific issue
/loop-status        ← Quick dashboard
```

在你的 AI 编程智能体中输入以上命令即可。

<details>
<summary><b>What does this do? / 这会做什么？</b></summary>

Downloads workflows, Issue/PR templates, and auto-label action to your project.

下载工作流、Issue/PR 模板和自动标签 Action 到你的项目中。

Labels and AGENTS.md are created by `/loop-init`, not the installer.

标签和 AGENTS.md 由 `/loop-init` 创建，安装器不处理。

</details>

<br/>

## \ud83d\udd04 The Loop / \u5904\u7406\u95ed\u73af

```
\u250c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2510
\u2502                          /loop                            \u2502
\u251c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2524
\u2502                                                               \u2502
\u2502  Pre-flight (6 steps)                                         \u2502
\u2502    detect branch \u2192 gh auth \u2192 clean tree \u2192 version             \u2502
\u2502    \u2192 read history \u2192 AGENTS.md freshness                       \u2502
\u2502                    \u2502                                            \u2502
\u2502  Step 1: Check PRs + Verify Main                              \u2502
\u2502    \u251c\u2500 Code PRs \u2192 fix CI / address review                     \u2502
\u2502    \u251c\u2500 Plan PRs \u2192 revise (CHANGES_REQUESTED)                  \u2502
\u2502    \u2502              or report (APPROVED / no review)             \u2502
\u2502    \u2514\u2500 Clean merged branches                                   \u2502
\u2502                    \u2502                                            \u2502
\u2502  Step 2: Scan & Auto-Group                                    \u2502
\u2502    filter \u2192 group by component \u2192 order by priority            \u2502
\u2502              \u250c\u2500\u2500\u2500\u2500\u2500\u253c\u2500\u2500\u2500\u2500\u2500\u2510                                  \u2502
\u2502            Group A  Group B  Standalone                        \u2502
\u2502              \u2502     \u2502     \u2502                                    \u2502
\u2502        \u250c\u2500\u2500\u2500\u2500\u2500\u25bc\u2500\u2500\u2500\u2510 \u2502     \u2502                                    \u2502
\u2502        \u2502 Step 3  \u2502\u25c4\u2518     \u2502                                    \u2502
\u2502        \u2502 Classify\u2502\u25c4\u2500\u2500\u2500\u2500\u2500\u2518                                    \u2502
\u2502        \u2514\u2500\u2500\u2500\u252c\u2500\u2500\u2500\u2500\u2518                                              \u2502
\u2502            \u251c\u2500 Skip (blocked/human/platform)                   \u2502
\u2502            \u251c\u2500 Plan Round 1 \u2192 design doc + Plan PR             \u2502
\u2502            \u251c\u2500 Plan Round 2+ \u2192 implement sub-task              \u2502
\u2502            \u2514\u2500 Direct \u2192 test-first implement                   \u2502
\u2502                    \u2502                                            \u2502
\u2502        \u250c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u25bc\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2510                                  \u2502
\u2502        \u2502 Step 4: Verify   \u2502                                  \u2502
\u2502        \u2502 & Submit PR      \u2502                                  \u2502
\u2502        \u2514\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u252c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2518                                  \u2502
\u2502                    \u2502                                            \u2502
\u2502         More issues? \u2500YES\u2192 next group (finalize prev group)   \u2502
\u2502                    \u2502                                            \u2502
\u2502             NO / cap reached                                   \u2502
\u2502                    \u25bc                                            \u2502
\u2502        Step 5: Record Session History                          \u2502
\u2502                                                               \u2502
\u2514\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2518
```

| Phase | EN | \u4e2d\u6587 |
|:------|:---|:-----|
| **Pre-flight** | Detect branch, verify `gh` auth, clean tree, read history, check AGENTS.md age | \u68c0\u6d4b\u5206\u652f\u3001\u9a8c\u8bc1\u8ba4\u8bc1\u3001\u5e72\u51c0\u5de5\u4f5c\u6811\u3001\u8bfb\u53d6\u5386\u53f2\u3001\u68c0\u67e5 AGENTS.md \u65f6\u6548 |
| **Step 1** | Check PRs (code + plan), verify main health, clean merged branches | \u68c0\u67e5 PR\uff08\u4ee3\u7801 + \u8bbe\u8ba1\uff09\u3001\u9a8c\u8bc1\u4e3b\u5e72\u5065\u5eb7\u3001\u6e05\u7406\u5df2\u5408\u5e76\u5206\u652f |
| **Step 2** | Scan issues, filter (deps/skip/PR), auto-group, order by priority | \u626b\u63cf Issue\u3001\u8fc7\u6ee4\u3001\u81ea\u52a8\u5206\u7ec4\u3001\u6309\u4f18\u5148\u7ea7\u6392\u5e8f |
| **Step 3** | Classify: **Skip** \u00b7 **Plan Round 1** (design doc) \u00b7 **Plan Round 2+** (sub-task) \u00b7 **Direct** (test-first) | \u5206\u7c7b\uff1a\u8df3\u8fc7 / \u89c4\u5212\u7b2c1\u8f6e / \u89c4\u5212\u7b2c2+\u8f6e / \u76f4\u63a5\u5b9e\u73b0 |
| **Step 4** | Verify (build/test/lint), submit PR (3 templates), group finalize, loop back | \u9a8c\u8bc1\u3001\u63d0\u4ea4 PR\uff083\u5957\u6a21\u677f\uff09\u3001\u5206\u7ec4\u6536\u5c3e\u3001\u5faa\u73af |
| **Step 5** | Record session history + human review queue | \u8bb0\u5f55\u4f1a\u8bdd\u5386\u53f2 + \u4eba\u7684\u5ba1\u67e5\u961f\u5217 |

<br/>

## 📁 Project Structure / 项目结构

```
loop-kit/
├── workflows/
│   ├── loop.md                # /loop — batch issue processing with grouping
│   ├── loop-issue.md              # /loop-issue — process a specific issue
│   ├── loop-status.md             # /loop-status — grouped dashboard
│   └── loop-init.md               # /loop-init — auto-generate AGENTS.md + labels
├── templates/
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
└── README.md
```

<br/>

## ✨ Features / 特性

| | Feature / 特性 | Description / 描述 |
|:--|:--------------|:-------------------|
| 🔄 | **Auto-Group & Batch** / 自动分组批处理 | Groups related issues by component, processes all in one session / 自动分组相关 Issue，一次批量处理 |
| 🎯 | **Review-Friendly PRs** / 易读 PR | Key review points, group info, merge order in every PR / 每个 PR 含重点行、分组信息、合并顺序 |
| 📋 | **Review Checklist** / 审查清单 | Session summary = human's grouped to-do list / 会话摘要 = 人的分组待办清单 |
| 🔁 | **Feedback Loop** / 反馈闭环 | Reads review comments, fixes code, pushes updates / 读 review 评论，修代码，推送更新 |
| 🏥 | **Main Health** / 主干守护 | Verifies tests pass on main before starting new work / 开始新工作前验证主干健康 |
| 🚀 | **Zero-Config Init** / 零配置初始化 | `/loop-init` auto-generates AGENTS.md + labels / `/loop-init` 自动生成 AGENTS.md + 标签 |
| 📊 | **Grouped Dashboard** / 分组仪表盘 | `/loop-status` shows PRs grouped by component / 按组件分组展示 PR |
| 🧠 | **Smart Classification** / 智能分类 | Skip / Plan / Direct decision tree / 跳过 / 规划 / 直接实现的决策树 |
| 🖥️ | **Platform Aware** / 平台感知 | Skips issues requiring unavailable platforms / 跳过需要不可用平台的 Issue |
| 🔗 | **Dependency Tracking** / 依赖追踪 | Structured `Depends On` field — auto-skips blocked issues / 结构化依赖声明 — 自动跳过被阻塞的 Issue |
| 🔧 | **Flexible** / 灵活适配 | Works with any language, any stack / 适用于任何语言、任何技术栈 |
| 🔄 | **Plan Review Lifecycle** / 方案审核生命周期 | Plan PR review-revise-approve cycle with GitHub native review states / 使用 GitHub 原生审核状态的方案审核循环 |
| 🔀 | **Dynamic Branch Detection** / 动态分支检测 | Works with any default branch name (main, master, develop...) / 支持任何默认分支名 |

<br/>

## 🎛️ Flexibility / 灵活性

Loop Kit adapts intelligently to your project setup:

Loop Kit 会智能适配你的项目配置：

| Scenario / 场景 | Behavior / 行为 |
|:----------------|:----------------|
| No priority labels / 无优先级标签 | Agent reads issue bodies and assesses priority / 智能体读取 Issue 正文自行评估优先级 |
| No test framework / 无测试框架 | Implements directly, notes gaps in PR / 直接实现，在 PR 中声明未测试项 |
| No `AGENTS.md` / 无 `AGENTS.md` | Uses sensible defaults / 使用合理的默认值 |
| Trivial fix / 简单修复 | Skips classification, just fixes and PRs / 跳过分类，直接修复并提 PR |
| Blocked issue / 被阻塞的 Issue | Skips it, picks the next one / 跳过当前，选取下一个 |
| Platform mismatch / 平台不匹配 | Skips issues requiring unavailable platform / 跳过需要不可用平台的 Issue |
| Branch protection / 分支保护 | Auto-fallback to chore branch for history commits / 自动回退到 chore 分支提交历史记录 |
| Fork workflow / Fork 工作流 | Use `--repo` flag to target upstream for PRs / 使用 `--repo` 参数将 PR 指向上游 |

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
