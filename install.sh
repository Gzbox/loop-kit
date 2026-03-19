#!/usr/bin/env bash
# Loop Kit Installer
# Usage: bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
#
# Options:
#   --version <tag>      Install a specific version (e.g., v2.0.0). Default: main
#   --help               Show this help
set -euo pipefail

LOOP_KIT_VERSION="${LOOP_KIT_VERSION:-main}"
REPO_RAW="https://raw.githubusercontent.com/Gzbox/loop-kit"

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      if [[ -z "${2:-}" ]]; then
        echo "Error: --version requires a tag name (e.g., v2.0.0)"
        exit 1
      fi
      LOOP_KIT_VERSION="$2"
      shift 2
      ;;
    --help)
      echo "Loop Kit Installer"
      echo "Usage: bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)"
      echo ""
      echo "Options:"
      echo "  --version <tag>  Install a specific version (e.g., v2.0.0). Default: main"
      echo "  --help           Show this help"
      exit 0
      ;;
    *)
      echo "Unknown option: $1 (use --help)"
      exit 1
      ;;
  esac
done

REPO_RAW="${REPO_RAW}/${LOOP_KIT_VERSION}"

echo ""
echo "🔄 Loop Kit Installer (${LOOP_KIT_VERSION})"
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
    echo "❌ Neither curl nor wget found"
    exit 1
  fi
}

# 1. Workflows
echo "📥 Workflows..."
download "$REPO_RAW/workflows/loop-job.md" ".agents/workflows/loop-job.md"
download "$REPO_RAW/workflows/loop-issue.md" ".agents/workflows/loop-issue.md"
download "$REPO_RAW/workflows/loop-status.md" ".agents/workflows/loop-status.md"
download "$REPO_RAW/workflows/loop-init.md" ".agents/workflows/loop-init.md"
echo "   ✅ .agents/workflows/ (loop-job, loop-issue, loop-status, loop-init)"

# 2. Issue/PR templates + auto-label action
echo "📥 Templates..."
download "$REPO_RAW/templates/github/ISSUE_TEMPLATE/bug_report.yml" ".github/ISSUE_TEMPLATE/bug_report.yml"
download "$REPO_RAW/templates/github/ISSUE_TEMPLATE/feature_request.yml" ".github/ISSUE_TEMPLATE/feature_request.yml"
download "$REPO_RAW/templates/github/ISSUE_TEMPLATE/config.yml" ".github/ISSUE_TEMPLATE/config.yml"
download "$REPO_RAW/templates/github/PULL_REQUEST_TEMPLATE.md" ".github/PULL_REQUEST_TEMPLATE.md"
download "$REPO_RAW/templates/github/workflows/auto-label-issues.yml" ".github/workflows/auto-label-issues.yml"
echo "   ✅ .github/ (issue templates, PR template, auto-label action)"

# 3. Version file
echo "$LOOP_KIT_VERSION" > .agents/.loop-kit-version

echo ""
echo "🎉 Loop Kit installed!"
echo ""
echo "Next:"
echo "  1. /loop-init  — AI analyzes your project, generates AGENTS.md + labels"
echo "  2. /loop       — start processing issues"
