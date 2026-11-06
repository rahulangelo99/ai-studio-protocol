#!/usr/bin/env bash
# Creates or refreshes ~/AI-Studio.   bash setup-studio.sh S [channel-prefix]
# Works on Windows (Git Bash, which Claude Code uses) and macOS/Linux.
# Never touches the person's idea folders. Re-run anytime to update the rules.
ME=$(printf '%s' "$1" | tr '[:lower:]' '[:upper:]'); me=$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')
case "$ME" in [A-Z]) ;; *) echo "usage: bash setup-studio.sh <one letter, e.g. S> [channel-prefix]"; exit 1 ;; esac
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="${STUDIO_ROOT:-$HOME/AI-Studio}"
mkdir -p "$ROOT" || exit 1

# Rules and guides: always refreshed to this version
rm -rf "$ROOT/protocol" "$ROOT/guides"
cp -R "$HERE/protocol" "$HERE/guides" "$ROOT/"

# CLAUDE.md: write if missing or from an older kit (no protocol imports)
if [ ! -f "$ROOT/CLAUDE.md" ] || ! grep -q '@protocol/' "$ROOT/CLAUDE.md"; then
  [ -f "$ROOT/CLAUDE.md" ] && mv "$ROOT/CLAUDE.md" "$ROOT/CLAUDE.old.md"
  sed "s/{{ME}}/$ME/g" "$HERE/CLAUDE.template.md" > "$ROOT/CLAUDE.md"
fi

# Private settings: channel prefix from 2nd argument or channels.env (never in the public repo)
PHONE=""
PREFIX=$(printf '%s' "$2" | tr -cd 'A-Za-z0-9-')
[ -z "$PREFIX" ] && [ -f "$HERE/channels.env" ] && PREFIX=$(sed -n 's/^PREFIX=//p' "$HERE/channels.env" | tr -cd 'A-Za-z0-9-')
if [ -n "$PREFIX" ]; then
  cat > "$ROOT/studio.local.md" <<EOF
# Private studio settings: never share, publish or push online
- Person: $ME
- My inbox channel (Rahul writes here): $PREFIX-$me
- Rahul's channel (I write here): $PREFIX-mc
EOF
  PHONE="$PREFIX-$me"
elif [ ! -f "$ROOT/studio.local.md" ]; then
  printf "# Private studio settings\n- Person: %s\n- Message line: not set up (no channel prefix given). Skip protocol 05.\n" "$ME" > "$ROOT/studio.local.md"
fi

# Hooks: Claude Code itself delivers messages at session start and on every prompt
mkdir -p "$ROOT/.claude/hooks"
cp "$HERE/studio-files/.claude/hooks/inbox.sh" "$ROOT/.claude/hooks/inbox.sh"
if [ -f "$ROOT/.claude/settings.json" ] && ! grep -q 'inbox.sh' "$ROOT/.claude/settings.json"; then
  mv "$ROOT/.claude/settings.json" "$ROOT/.claude/settings.backup.json"
fi
cp "$HERE/studio-files/.claude/settings.json" "$ROOT/.claude/settings.json"

[ -f "$ROOT/IDEA-LOG.md" ] || printf "# IDEA LOG (%s)\n\n| # | Idea | Status | Folder |\n|---|---|---|---|\n" "$ME" > "$ROOT/IDEA-LOG.md"
printf "studio.local.md\n.claude/inbox.state\n.DS_Store\nThumbs.db\ndesktop.ini\n" > "$ROOT/.gitignore"

# Version history (git). On macOS, /usr/bin/git is a stub until developer tools are installed.
if git --version >/dev/null 2>&1; then
  cd "$ROOT"
  [ -d .git ] || git init -q
  git config user.name >/dev/null || git config user.name "$ME"
  git config user.email >/dev/null || git config user.email "$me@ai-studio.local"
  git add -A && git commit -qm "Studio rules updated" >/dev/null 2>&1
  echo "Version history: on"
else
  echo "Version history: OFF. Install Git (Windows: https://git-scm.com/download/win; Mac: run 'xcode-select --install'), then re-run this script."
fi

echo "Studio ready: $ROOT"
[ -n "$PHONE" ] && echo "Phone (ntfy app) channel: $PHONE"
if [ -z "$STUDIO_ROOT" ]; then
  if command -v explorer.exe >/dev/null 2>&1; then
    explorer.exe "$(cygpath -w "$ROOT" 2>/dev/null || echo "$ROOT")" >/dev/null 2>&1
  elif command -v open >/dev/null 2>&1; then open "$ROOT"
  fi
fi
exit 0
