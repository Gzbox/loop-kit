#!/usr/bin/env bash
# Loop Kit Installer
# Usage: bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
#
# Interactive mode (default): prompts for each option
# Non-interactive mode: pass flags to skip prompts
#
# Options:
#   --all                Install everything without prompting
#   --workflows-only     Only install workflow files (minimal)
#   --no-labels          Skip GitHub label creation
#   --no-agents-md       Skip AGENTS.md creation
#   --no-templates       Skip Issue/PR templates
#   --version <tag>      Install a specific version (e.g., v1.0.0). Default: main
#   --help               Show this help
set -euo pipefail

LOOP_KIT_VERSION="${LOOP_KIT_VERSION:-main}"
REPO_RAW="https://raw.githubusercontent.com/Gzbox/loop-kit"
INSTALL_WORKFLOWS=true
INSTALL_TEMPLATES=""   # empty = ask interactively
INSTALL_LABELS=""      # empty = ask interactively
INSTALL_AGENTS_MD=""   # empty = ask interactively
INTERACTIVE=true       # default: interactive mode

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --all)
      INSTALL_WORKFLOWS=true
      INSTALL_TEMPLATES=true
      INSTALL_LABELS=true
      INSTALL_AGENTS_MD=true
      INTERACTIVE=false
      shift
      ;;
    --workflows-only)
      INSTALL_WORKFLOWS=true
      INSTALL_TEMPLATES=false
      INSTALL_LABELS=false
      INSTALL_AGENTS_MD=false
      INTERACTIVE=false
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
    --no-templates)
      INSTALL_TEMPLATES=false
      shift
      ;;
    --version)
      if [[ -z "${2:-}" ]]; then
        echo "Error: --version requires a tag name (e.g., v1.0.0)"
        exit 1
      fi
      LOOP_KIT_VERSION="$2"
      shift 2
      ;;
    --help)
      head -n 16 "$0" | tail -n +2 | sed 's/^# *//'
      exit 0
      ;;
    *)
      echo "Unknown option: $1 (use --help)"
      exit 1
      ;;
  esac
done

# Helper: ask Y/n question (default Y)
ask() {
  local prompt="$1" default="${2:-Y}"
  if ! $INTERACTIVE; then return 0; fi
  printf "%s " "$prompt"
  read -r answer </dev/tty
  answer="${answer:-$default}"
  [[ "$answer" =~ ^[Yy] ]]
}

echo ""
echo "🔄 Loop Kit Installer"
echo ""

# ── Interactive prompts ──────────────────────────────────────────

if $INTERACTIVE; then
  # Version
  printf "? Version to install (main): "
  read -r ver_input </dev/tty
  if [[ -n "$ver_input" ]]; then
    LOOP_KIT_VERSION="$ver_input"
  fi

  echo ""

  # Workflows are always installed (core purpose of Loop Kit)
  echo "   Workflows (/loop, /loop-issue, /loop-status) — always installed ✓"
  echo ""

  # Templates
  if [[ -z "$INSTALL_TEMPLATES" ]]; then
    if ask "? Install Issue/PR templates? (Y/n)"; then
      INSTALL_TEMPLATES=true
    else
      INSTALL_TEMPLATES=false
    fi
  fi

  # AGENTS.md
  if [[ -z "$INSTALL_AGENTS_MD" ]]; then
    if [ -f "AGENTS.md" ]; then
      echo "   AGENTS.md already exists — will not overwrite ✓"
      INSTALL_AGENTS_MD=false
    elif ask "? Create AGENTS.md template? (Y/n)"; then
      INSTALL_AGENTS_MD=true
    else
      INSTALL_AGENTS_MD=false
    fi
  fi

  # Labels
  if [[ -z "$INSTALL_LABELS" ]]; then
    if ask "? Create priority labels on GitHub? (Y/n)"; then
      INSTALL_LABELS=true
    else
      INSTALL_LABELS=false
    fi
  fi

  echo ""
fi

# ── Fill in defaults for non-interactive mode ────────────────────

[[ -z "$INSTALL_TEMPLATES" ]] && INSTALL_TEMPLATES=true
[[ -z "$INSTALL_LABELS" ]] && INSTALL_LABELS=true
[[ -z "$INSTALL_AGENTS_MD" ]] && INSTALL_AGENTS_MD=true

REPO_RAW="${REPO_RAW}/${LOOP_KIT_VERSION}"

echo "📦 Installing Loop Kit (${LOOP_KIT_VERSION})..."
echo ""

# Check gh CLI (only matters for labels)
if $INSTALL_LABELS; then
  if ! command -v gh &>/dev/null; then
    echo "⚠️  gh CLI not found. Labels won't be created."
    echo "   Install: https://cli.github.com/"
    INSTALL_LABELS=false
  elif ! gh auth status &>/dev/null; then
    echo "⚠️  gh CLI not authenticated. Labels won't be created."
    echo "   Run: gh auth login"
    INSTALL_LABELS=false
  fi
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

# 1. Workflows (always installed)
echo "📥 Installing workflows..."
download "$REPO_RAW/workflows/loop-job.md" ".agents/workflows/loop-job.md"
download "$REPO_RAW/workflows/loop-issue.md" ".agents/workflows/loop-issue.md"
download "$REPO_RAW/workflows/loop-status.md" ".agents/workflows/loop-status.md"
echo "   ✅ .agents/workflows/loop-job.md"
echo "   ✅ .agents/workflows/loop-issue.md"
echo "   ✅ .agents/workflows/loop-status.md"

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

# 4. Labels (delegate to setup-labels.sh — non-fatal if it fails)
if $INSTALL_LABELS; then
  echo "🏷️  Creating GitHub labels..."
  LABEL_SCRIPT=$(mktemp)
  download "$REPO_RAW/scripts/setup-labels.sh" "$LABEL_SCRIPT"
  if bash "$LABEL_SCRIPT" --quiet; then
    :
  else
    echo "   ⚠️  Label creation failed (no remote or auth issue). You can run setup-labels.sh later."
  fi
  rm -f "$LABEL_SCRIPT"
fi

# 5. Version file
echo "$LOOP_KIT_VERSION" > .agents/.loop-kit-version
echo "   ✅ .agents/.loop-kit-version ($LOOP_KIT_VERSION)"

echo ""
echo "🎉 Loop Kit installed!"
echo ""
echo "Next steps:"
echo "  1. Edit AGENTS.md — fill in your project's build/test commands"
echo "  2. In your AI agent, type /loop to start processing issues"
echo "  3. Type /loop-issue #N to process a specific issue"
echo "  4. Type /loop-status for a quick dashboard"
