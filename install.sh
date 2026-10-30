#!/bin/sh
# ContentSCALE Research skill: copy the skill to ~/.claude/skills and set up its Python tools.
# Usage: sh install.sh   (from the cloned or unzipped repo)
# An existing ~/.claude/skills/cs-content-research is moved to ~/.claude/skills/.backup-<date>/ first.
set -e
SRC="$(cd "$(dirname "$0")" && pwd)/skills/cs-content-research"
DEST="$HOME/.claude/skills"
[ -f "$SRC/SKILL.md" ] || { echo "Run this from the repo folder (skills/cs-content-research not found)."; exit 1; }
mkdir -p "$DEST"
if [ -e "$DEST/cs-content-research" ]; then
  BACKUP="$DEST/.backup-$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP"
  mv "$DEST/cs-content-research" "$BACKUP/"
  echo "Previous version saved in $BACKUP"
fi
cp -R "$SRC" "$DEST/cs-content-research"
echo "Installed skill to $DEST/cs-content-research"

if command -v claude >/dev/null 2>&1 && claude plugin list 2>/dev/null | grep -q "contentscale@"; then
  echo "NOTE: the full contentscale plugin is installed too; it already has this skill as contentscale:cs-content-research."
fi
sh "$DEST/cs-content-research/scripts/setup.sh" || echo "NOTE: tool setup did not finish; run again: sh $DEST/cs-content-research/scripts/setup.sh"
echo ""
echo "For Instagram (once per computer): install the Sort Feed extension in Chrome (sortfeed.com), sign in to Instagram there,"
echo "and turn on the SortFeed connector in Claude (+ > Connectors). Without it Instagram is collected the slower way."
echo "Done. Restart Claude Code, then ask: \"Зроби research для клієнта …\""
