#!/bin/zsh
# Creates or refreshes ~/AI-Studio:   zsh setup-studio.sh S   (or G)
# Never touches the person's idea folders. Re-run anytime to update the rules.
ME="${1:u}"; me="${1:l}"
[[ -z "$ME" || ! "$ME" =~ '^[A-Z]$' ]] && { echo "usage: zsh setup-studio.sh <one letter, e.g. S>"; exit 1; }
HERE="${0:A:h}"
ROOT="${STUDIO_ROOT:-$HOME/AI-Studio}"
mkdir -p "$ROOT" || exit 1

# Rules and guides: always refreshed to this version
rm -rf "$ROOT/protocol" "$ROOT/guides"
cp -R "$HERE/protocol" "$HERE/guides" "$ROOT/"

# CLAUDE.md: write if missing or from an older kit (no protocol imports)
if [[ ! -f "$ROOT/CLAUDE.md" ]] || ! grep -q '@protocol/' "$ROOT/CLAUDE.md"; then
  [[ -f "$ROOT/CLAUDE.md" ]] && mv "$ROOT/CLAUDE.md" "$ROOT/CLAUDE.old.md"
  sed "s/{{ME}}/$ME/g" "$HERE/CLAUDE.template.md" > "$ROOT/CLAUDE.md"
fi

# Private settings: message channels come from channels.env (in the private kit, never in the public repo)
if [[ -f "$HERE/channels.env" ]]; then
  source "$HERE/channels.env"
  cat > "$ROOT/studio.local.md" <<EOF
# Private studio settings: never share, publish or push online
- Person: $ME
- My inbox channel (Rahul writes here): $PREFIX-$me
- Rahul's channel (I write here): $PREFIX-mc
EOF
  PHONE="$PREFIX-$me"
elif [[ ! -f "$ROOT/studio.local.md" ]]; then
  printf "# Private studio settings\n- Person: %s\n- Message line: not set up (no channels.env in kit). Skip protocol 05.\n" "$ME" > "$ROOT/studio.local.md"
fi

[[ -f "$ROOT/IDEA-LOG.md" ]] || printf "# IDEA LOG (%s)\n\n| # | Idea | Status | Folder |\n|---|---|---|---|\n" "$ME" > "$ROOT/IDEA-LOG.md"
printf "studio.local.md\n.DS_Store\n" > "$ROOT/.gitignore"

if xcode-select -p >/dev/null 2>&1 && command -v git >/dev/null; then
  cd "$ROOT"
  [[ -d .git ]] || git init -q
  git config user.name >/dev/null || git config user.name "$ME"
  git config user.email >/dev/null || git config user.email "$me@ai-studio.local"
  git add -A && git commit -qm "Studio rules updated" >/dev/null 2>&1
  echo "Version history: on"
else
  echo "Version history: OFF. Run 'xcode-select --install' once, then re-run this script."
fi
command -v jq >/dev/null || echo "Note: jq missing. The message line needs it ('brew install jq')."
echo "Studio ready: $ROOT"
[[ -n "$PHONE" ]] && echo "Phone (ntfy app) channel: $PHONE"
if [[ -z "$STUDIO_ROOT" ]]; then open "$ROOT"; fi
exit 0
