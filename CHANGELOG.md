# Changelog

## 2026-11-06 · Automatic message delivery
- Studio hooks (`.claude/settings.json` + `.claude/hooks/inbox.sh`): Claude Code itself checks the inbox at session start and on every message, so Rahul's notes arrive even if the live listener stopped.
- Session start opens the ntfy inbox in the browser (at most every 4 hours).
- Re-run INSTALL.md to get this.

## 2026-11-06 · Windows support
- Setup now runs in plain **bash**, which works on Windows (Git Bash, used by Claude Code) and Mac. Run it with `bash setup-studio.sh <LETTER> <PREFIX>`.
- Message line no longer needs `jq`: it reads ntfy's plain-text stream.
- Guides use Windows shortcuts: Win+H to dictate, Win+L to lock; folders open in File Explorer.
- New `INSTALL.md`: step-by-step install/update instructions any Claude Code session can follow.

## 2026-11-06 · v1
- Protocol 01–06: permissions, accuracy (incl. uncertainty, sources, statistics, recent events, quotes), builder mindset, file tracking, messages, skills.
