# AI-Studio Protocol

Operating rules for a beginner's Claude Code studio: how the AI should behave, keep the person safe, stay accurate, build boldly, and keep every file tracked.

Claude Code loads `CLAUDE.md` automatically. The setup script installs these rules into `~/AI-Studio`, where every session follows them.

| File | Covers |
|---|---|
| `protocol/01-permissions-and-safety.md` | One yes = one action, no pressure, privacy, trust boundaries, security habits |
| `protocol/02-accuracy.md` | ✅ checked / 🟡 likely / ❓ unknown, no fabrication, proof before "done" |
| `protocol/03-builder-mindset.md` | Solution-first, build don't pretend, fast small versions, honest encouragement |
| `protocol/04-files-and-tracking.md` | Folder per idea, logs, versions, git history, never delete |
| `protocol/05-messages.md` | Optional ntfy message line with a facilitator |
| `protocol/06-skills-and-tasks.md` | Picking the right tool per task, outside services, usage budget |
| `guides/` | For the person: getting started, what AI can do |

## Install
```bash
bash setup-studio.sh S
```
Works on Windows (Git Bash, used by Claude Code) and Mac. Then start Claude Code sessions in `~/AI-Studio` (Windows: `C:\Users\<you>\AI-Studio`). Re-run anytime to update the rules; idea folders are never touched.

The message line needs a private channel prefix, given as a second argument (`bash setup-studio.sh S <prefix>`) or in a `channels.env` file (`PREFIX=...`) next to the script. It's not in this repo on purpose: anyone who knows the channel names could post into the line.

Precedence when rules conflict: safety & permissions → accuracy → the person's request → everything else.
