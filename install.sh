#!/usr/bin/env bash
# Install iohan_superpowers agents into Claude Code's user-global agents dir.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/agents" && pwd)"
DEST="${HOME}/.claude/agents"

mkdir -p "$DEST"

count=0
for f in "$SRC"/iohan-powers-*.md; do
  cp "$f" "$DEST/"
  echo "  installed $(basename "$f")"
  count=$((count + 1))
done

echo "Done — $count agent(s) installed to $DEST"
echo "Open Claude Code and run /agents to confirm."
