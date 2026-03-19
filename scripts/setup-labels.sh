#!/usr/bin/env bash
# Setup GitHub labels for the Loop Job workflow.
# Usage: bash .agents/workflows/setup-labels.sh [--platform <label>] [--help]
# Requires: gh CLI authenticated with repo access
#
# Options:
#   --platform <label>   Add a platform-specific dependency label (e.g., "depends-macos")
#                        Can be specified multiple times.
#   --quiet              Suppress banner and "Next steps" (for scripted use)
#   --help               Show this help message
#
# Examples:
#   bash .agents/workflows/setup-labels.sh
#   bash .agents/workflows/setup-labels.sh --platform depends-macos
#   bash .agents/workflows/setup-labels.sh --platform depends-macos --platform depends-linux
set -euo pipefail

PLATFORM_LABELS=()
QUIET=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --platform)
      if [[ -z "${2:-}" ]]; then
        echo "Error: --platform requires a label name"
        exit 1
      fi
      PLATFORM_LABELS+=("$2")
      shift 2
      ;;
    --quiet)
      QUIET=true
      shift
      ;;
    --help)
      head -n 15 "$0" | tail -n +2 | sed 's/^# *//'
      exit 0
      ;;
    *)
      echo "Unknown option: $1 (use --help for usage)"
      exit 1
      ;;
  esac
done

# Pre-flight: check gh auth
if ! gh auth status &>/dev/null; then
  echo "❌ gh CLI is not authenticated. Run 'gh auth login' first."
  exit 1
fi

if ! $QUIET; then
  echo "🏷  Setting up Loop Job labels..."
  echo ""
fi

# Priority labels
echo "Creating priority labels..."
gh label create "P0-critical" --color "B60205" --description "Critical: blocks all progress" --force
gh label create "P1-high"     --color "D93F0B" --description "High priority: core functionality" --force
gh label create "P2-medium"   --color "FBCA04" --description "Medium priority: quality improvements" --force
gh label create "P3-low"      --color "0E8A16" --description "Low priority: polish and nice-to-have" --force

# Classification labels
echo "Creating classification labels..."
gh label create "plan-needed"          --color "5319E7" --description "Requires design plan before implementation" --force
gh label create "skip-human-decision"  --color "D4C5F9" --description "Needs human decision — do not auto-implement" --force

# Platform-specific labels (optional)
if [ ${#PLATFORM_LABELS[@]} -gt 0 ]; then
  echo "Creating platform labels..."
  for label in "${PLATFORM_LABELS[@]}"; do
    gh label create "$label" --color "006B75" --description "Requires specific platform for validation" --force
  done
fi

echo "   ✅ Labels created"

if ! $QUIET; then
  echo ""
  echo "Next steps:"
  echo "  1. Install the full toolkit:  bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)"
  echo "  2. Or start directly:         In your AI coding agent, type /loop"
fi
