# Loop Kit v2.0 — Complete Redesign Plan

## 核心原则

**人只 review。其他一切由 AI 做，并最大程度降低人 review 的复杂度。**

---

## 新增工作流

### [NEW] `workflows/loop-init.md`

AI 分析项目，自动生成 [AGENTS.md](file:///Users/dingzhen/Documents/basic-genomics/programming/other/loop-kit-playground/AGENTS.md) + component 标签。首次使用运行一次。

```
/loop-init
  1. 列出项目文件和目录结构
  2. 读取配置文件（任何语言/构建工具）
  3. 读取 README.md
  4. 识别：项目描述、构建命令、测试命令、代码约束、组件结构
  5. 生成 AGENTS.md（预填所有内容）
  6. 创建 component:xxx 标签
  7. 报告给用户确认
```

---

## 改造工作流

### [MODIFY] [workflows/loop-job.md](file:///Users/dingzhen/Documents/basic-genomics/programming/other/loop-kit/workflows/loop-job.md)

#### Step 1: Check PRs + Verify Main（增强）

```
1. git checkout main && git pull
2. 运行测试套件 → 失败则优先修复 main
3. 检查 open PRs
4. 读 review comments → 按反馈修改代码 → push 修复
5. 如果 pending PRs ≥ 10 → 不创建新 PR，报告后停止
6. 报告 PR 状态
```

#### Step 2: Scan & Auto-Group（改造）

```
1. 列出所有 open issues
2. ≤ 2 个 → 跳过分组，直接按优先级处理
3. > 2 个 → 自动分组：
   - 已有 component:xxx 标签 → 按标签分组
   - 无标签 → AI 从标题/body 推断关联性
   - 无法归组 → standalone
4. 每组最多 5 个（超过拆子组）
5. 组间按优先级排序
6. 处理顺序：同组连续
```

#### Step 4: PR 优化（改造）

PR body 模板增加：
- `Group: xxx (1/3)` — 组编号和位置
- `Merge after: PR #X` — 合并顺序
- `Key Review Points` — 人重点看哪几行
- `After This Group Is Merged` — 组的最后一个 PR 含测试指引

PR 标签：AI 自动创建 `component:xxx`（如不存在）并打标签。

同组 PR 改同文件 → 标注 `⚠️ May conflict with PR #X — merge #X first`

Session cap: 最多创建 ~10 个 PR 后停止。

#### Step 5: Session Summary（改造）

从"AI 做了什么"变成"人的 review 清单"：
```
### 📋 Your Review Queue
#### Group: auth (3 PRs, P0)
PRs: #10, #11, #12  |  Merge order: #10 → #11 → #12
After merge, test: login, token refresh, session
```

### [MODIFY] [workflows/loop-issue.md](file:///Users/dingzhen/Documents/basic-genomics/programming/other/loop-kit/workflows/loop-issue.md)

PR body 加关联提示：`Related: #2, #8 (same component)`

### [MODIFY] [workflows/loop-status.md](file:///Users/dingzhen/Documents/basic-genomics/programming/other/loop-kit/workflows/loop-status.md)

按组展示 PR：
```
Group: auth (3 PRs)
  #10 ✅ ready  #11 ✅ ready  #12 ✅ ready
  → Merge: #10 → #11 → #12
```

---

## 删除文件

### [DELETE] [templates/AGENTS.template.md](file:///Users/dingzhen/Documents/basic-genomics/programming/other/loop-kit/templates/AGENTS.template.md)
### [DELETE] [templates/AGENTS.template.zh-CN.md](file:///Users/dingzhen/Documents/basic-genomics/programming/other/loop-kit/templates/AGENTS.template.zh-CN.md)

由 `/loop-init` 替代。Loop Kit 用户必然有 AI agent。

---

## 修改配置/文档

### [MODIFY] [install.sh](file:///Users/dingzhen/Documents/basic-genomics/programming/other/loop-kit/install.sh)
- 删除 AGENTS.md 下载和 `--no-agents-md` 参数
- 添加 `loop-init.md` 到 workflow downloads
- 更新交互提示和 "Next steps"

### [MODIFY] [README.md](file:///Users/dingzhen/Documents/basic-genomics/programming/other/loop-kit/README.md)
- 流程图加入分组 loop-back 和组展示
- Features 表加 Auto-grouping、Review optimization、/loop-init
- Quick Start 改为 install → /loop-init → /loop
- 项目结构删除 AGENTS.template，加 loop-init.md

### [MODIFY] [docs/guide.md](file:///Users/dingzhen/Documents/basic-genomics/programming/other/loop-kit/docs/guide.md)
- Section 3 "Post-Install" → "运行 /loop-init"
- Section 4 更新 /loop 示例（分组 + review 清单）
- 新增 Section: Using /loop-init

---

## 边界情况

| 场景 | 处理 |
|:-----|:-----|
| ≤ 2 个 Issue | 跳过分组 |
| 组内 > 5 个 | 拆子组 |
| 同组 PR 改同文件 | 标注冲突 + merge order |
| Pending PRs ≥ 10 | 不创建新 PR |
| main 测试挂了 | 优先修复 |
| component 标签不存在 | AI 自动创建 |
| AI 分组不准 | 不阻塞，人下次手动打标签 |
| Review requested changes | Step 1 读 comments 并修复 |
| Stale PR（长时间无 review） | rebase 到最新 main |
| AGENTS.md 已存在 | /loop-init 读取并增强，不覆盖 |
| 首次运行无历史 | 正常创建 loop-history.md |

---

## 验证计划

```bash
# 确认无 AGENTS.template 残留引用
grep -ri "AGENTS.template" workflows/ docs/ README.md install.sh
# 确认无旧的 "one issue per iteration" 文本
grep -ri "one issue per iteration" workflows/ docs/ README.md
# 确认所有工作流交叉引用正确
grep -r "loop-init\|loop-job\|loop-issue\|loop-status" workflows/
# 测试 install.sh
```
