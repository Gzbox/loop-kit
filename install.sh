#!/usr/bin/env bash
# Loop Kit Installer
# Usage: bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
#
# Options:
#   --version <tag>      Install a specific version (e.g., v1.0.0). Default: main
#   --help               Show this help
set -euo pipefail

LOOP_KIT_VERSION="${LOOP_KIT_VERSION:-main}"
REPO_RAW="https://raw.githubusercontent.com/Gzbox/loop-kit"

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      if [[ -z "${2:-}" ]]; then
        echo "Error: --version requires a tag name (e.g., v1.0.0)"
        echo "错误：--version 需要一个标签名（如 v1.0.0）"
        exit 1
      fi
      LOOP_KIT_VERSION="$2"
      shift 2
      ;;
    --help)
      echo "Loop Kit Installer / Loop Kit 安装器"
      echo "Usage / 用法: bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)"
      echo ""
      echo "Options / 选项:"
      echo "  --version <tag>  Install a specific version / 安装指定版本 (e.g., v1.0.0). Default: main"
      echo "  --help           Show this help / 显示帮助信息"
      exit 0
      ;;
    *)
      echo "Unknown option / 未知选项: $1 (use --help / 使用 --help)"
      exit 1
      ;;
  esac
done

REPO_RAW="${REPO_RAW}/${LOOP_KIT_VERSION}"

echo ""
echo "🔄 Loop Kit Installer / Loop Kit 安装器 (${LOOP_KIT_VERSION})"
echo ""

# Download function
download() {
  local url="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if command -v curl &>/dev/null; then
    curl -sfL "$url" -o "$dest"
  elif command -v wget &>/dev/null; then
    wget -q "$url" -O "$dest"
  else
    echo "❌ Neither curl nor wget found / 未找到 curl 或 wget"
    exit 1
  fi
}

# 1. Workflows / 工作流
echo "📥 Workflows / 工作流..."
download "$REPO_RAW/workflows/loop-job.md" ".agents/workflows/loop-job.md"
download "$REPO_RAW/workflows/loop-issue.md" ".agents/workflows/loop-issue.md"
download "$REPO_RAW/workflows/loop-status.md" ".agents/workflows/loop-status.md"
download "$REPO_RAW/workflows/loop-init.md" ".agents/workflows/loop-init.md"
echo "   ✅ .agents/workflows/ (loop-job, loop-issue, loop-status, loop-init)"

# 2. Issue/PR templates + auto-label action / Issue/PR 模板 + 自动标签 Action
echo "📥 Templates / 模板..."
download "$REPO_RAW/templates/github/ISSUE_TEMPLATE/bug_report.yml" ".github/ISSUE_TEMPLATE/bug_report.yml"
download "$REPO_RAW/templates/github/ISSUE_TEMPLATE/feature_request.yml" ".github/ISSUE_TEMPLATE/feature_request.yml"
download "$REPO_RAW/templates/github/ISSUE_TEMPLATE/config.yml" ".github/ISSUE_TEMPLATE/config.yml"
download "$REPO_RAW/templates/github/PULL_REQUEST_TEMPLATE.md" ".github/PULL_REQUEST_TEMPLATE.md"
download "$REPO_RAW/templates/github/workflows/auto-label-issues.yml" ".github/workflows/auto-label-issues.yml"
echo "   ✅ .github/ (issue templates, PR template, auto-label action / Issue 模板、PR 模板、自动标签 Action)"

# 3. Version file / 版本文件
echo "$LOOP_KIT_VERSION" > .agents/.loop-kit-version
echo "   ✅ .agents/.loop-kit-version ($LOOP_KIT_VERSION)"

echo ""
echo "🎉 Loop Kit installed! / Loop Kit 安装完成！"
echo ""
echo "⚠️  Remember: commit and push to activate templates & actions on GitHub"
echo "⚠️  提示：需要 commit 并 push 后，模板和 Action 才会在 GitHub 上生效"
echo ""
echo "Next / 下一步:"
echo "  1. git add . && git commit -m 'chore: add Loop Kit' && git push"
echo "  2. /loop-init  — AI analyzes your project, generates AGENTS.md + labels / AI 分析项目，生成 AGENTS.md + 标签"
echo "  3. /loop       — start processing issues / 开始处理 Issue"
