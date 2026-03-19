#!/usr/bin/env bash
# Loop Kit Installer
# Usage: bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
#
# Options:
#   --workflows-only   Only install workflow files (minimal)
#   --no-labels        Skip GitHub label creation
#   --no-agents-md     Skip AGENTS.md creation
#   --help             Show this help
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/Gzbox/loop-kit/main"
INSTALL_WORKFLOWS=true
INSTALL_TEMPLATES=true
INSTALL_LABELS=true
INSTALL_AGENTS_MD=true

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --workflows-only)
      INSTALL_TEMPLATES=false
      INSTALL_LABELS=false
      INSTALL_AGENTS_MD=false
      shift
      ;;
    --no-labels)
      INSTALL_LABELS=false
      shift
      ;;
    --no-agents-md)
      INSTALL_AGENTS_MD=false
      shift
      ;;
    --help)
      head -n 8 "$0" | tail -n +2 | sed 's/^# *//'
      exit 0
      ;;
    *)
      echo "Unknown option: $1 (use --help)"
      exit 1
      ;;
  esac
done

echo "🔄 Loop Kit Installer"
echo ""

# Check gh CLI
if ! command -v gh &>/dev/null; then
  echo "⚠️  gh CLI not found. Labels won't be created."
  echo "   Install: https://cli.github.com/"
  INSTALL_LABELS=false
elif ! gh auth status &>/dev/null; then
  echo "⚠️  gh CLI not authenticated. Labels won't be created."
  echo "   Run: gh auth login"
  INSTALL_LABELS=false
fi

# Download function
download() {
  local url="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if command -v curl &>/dev/null; then
    curl -sL "$url" -o "$dest"
  elif command -v wget &>/dev/null; then
    wget -q "$url" -O "$dest"
  else
    echo "❌ Neither curl nor wget found"
    exit 1
  fi
}

# 1. Workflows
if $INSTALL_WORKFLOWS; then
  echo "📥 Installing workflows..."
  download "$REPO_RAW/workflows/loop-job.md" ".agents/workflows/loop-job.md"
  download "$REPO_RAW/workflows/loop-status.md" ".agents/workflows/loop-status.md"
  echo "   ✅ .agents/workflows/loop-job.md"
  echo "   ✅ .agents/workflows/loop-status.md"
fi

# 2. Templates
if $INSTALL_TEMPLATES; then
  echo "📥 Installing templates..."

  # Issue templates
  download "$REPO_RAW/templates/github/ISSUE_TEMPLATE/bug_report.yml" ".github/ISSUE_TEMPLATE/bug_report.yml"
  download "$REPO_RAW/templates/github/ISSUE_TEMPLATE/feature_request.yml" ".github/ISSUE_TEMPLATE/feature_request.yml"
  download "$REPO_RAW/templates/github/ISSUE_TEMPLATE/config.yml" ".github/ISSUE_TEMPLATE/config.yml"
  echo "   ✅ .github/ISSUE_TEMPLATE/"

  # PR template
  download "$REPO_RAW/templates/github/PULL_REQUEST_TEMPLATE.md" ".github/PULL_REQUEST_TEMPLATE.md"
  echo "   ✅ .github/PULL_REQUEST_TEMPLATE.md"

  # Auto-label action
  download "$REPO_RAW/templates/github/workflows/auto-label-issues.yml" ".github/workflows/auto-label-issues.yml"
  echo "   ✅ .github/workflows/auto-label-issues.yml"
fi

# 3. AGENTS.md
if $INSTALL_AGENTS_MD; then
  if [ -f "AGENTS.md" ]; then
    echo "⏭️  AGENTS.md already exists, skipping (won't overwrite)"
  else
    download "$REPO_RAW/templates/AGENTS.template.md" "AGENTS.md"
    echo "   ✅ AGENTS.md (template — edit the {{placeholders}})"
  fi
fi

# 4. Labels
if $INSTALL_LABELS; then
  echo "🏷️  Creating GitHub labels..."
  gh label create "P0-critical" --color "B60205" --description "Critical: blocks all progress" --force 2>/dev/null
  gh label create "P1-high"     --color "D93F0B" --description "High priority: core functionality" --force 2>/dev/null
  gh label create "P2-medium"   --color "FBCA04" --description "Medium priority: quality improvements" --force 2>/dev/null
  gh label create "P3-low"      --color "0E8A16" --description "Low priority: polish and nice-to-have" --force 2>/dev/null
  gh label create "plan-needed"          --color "5319E7" --description "Requires design plan before implementation" --force 2>/dev/null
  gh label create "skip-human-decision"  --color "D4C5F9" --description "Needs human decision — do not auto-implement" --force 2>/dev/null
  echo "   ✅ Labels created"
fi

echo ""
echo "🎉 Loop Kit installed!"
echo ""
echo "Next steps:"
echo "  1. Edit AGENTS.md — fill in your project's build/test commands"
echo "  2. In your AI agent, type /loop to start processing issues"
echo "  3. Type /loop-status for a quick dashboard"
