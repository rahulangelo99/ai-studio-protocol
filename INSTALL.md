# INSTALL / UPDATE: instructions for Claude Code

Follow these steps when the person asks you to install or update their AI-Studio from this repo. Works on **Windows** and **Mac**. It's safe to run again: their idea folders are never touched.

Show each command before running it and wait for the person's approval. Tell them in plain words what each step did.

## You need from the person
1. **Their letter**: `S` or `G` (or whatever they were given).
2. **Their channel prefix**, from Rahul's setup email (it starts with `sg-`). It's private: don't print it in public places, and never commit it to a pushed repo. If they don't have it, continue without it; the message line stays off until they do.

## Step 1: Check the shell
Run in **bash** (on Windows, Claude Code uses Git Bash):
```bash
bash --version | head -1; git --version; curl --version | head -1
```
- If bash or git is missing on **Windows**: Git for Windows is needed (https://git-scm.com/download/win). Ask before installing; the person runs the installer themselves.
- If git is missing on **Mac**: ask, then run `xcode-select --install`.

## Step 2: Download the latest rules
```bash
rm -rf ~/Downloads/ai-studio-kit && mkdir -p ~/Downloads/ai-studio-kit && curl -sL https://github.com/rahulangelo99/ai-studio-protocol/archive/refs/heads/main.tar.gz | tar -xz -C ~/Downloads/ai-studio-kit
```

## Step 3: Install or update the studio
```bash
bash ~/Downloads/ai-studio-kit/ai-studio-protocol-main/setup-studio.sh <LETTER> <PREFIX>
```
Expected output: `Version history: on`, `Studio ready: …/AI-Studio`, and `Phone (ntfy app) channel: <PREFIX>-<letter>`. The folder opens in File Explorer or Finder.

## Step 4: Verify (report each as ✅ or ❌)
```bash
cd ~/AI-Studio && ls protocol && head -3 studio.local.md && git log --oneline -1
```
- [ ] 6 files in `protocol/`
- [ ] `.claude/settings.json` and `.claude/hooks/inbox.sh` exist (they deliver Rahul's notes automatically)
- [ ] `studio.local.md` shows their letter and inbox channel
- [ ] git shows a recent "Studio rules updated" commit
- [ ] Message line works. Post a test note, then run the hook, and confirm it prints "setup test":
  `curl -s -d "setup test" https://ntfy.sh/<PREFIX>-<letter> >/dev/null; sleep 1; CLAUDE_PROJECT_DIR=~/AI-Studio bash ~/AI-Studio/.claude/hooks/inbox.sh prompt`

## Step 5: Hand over
Tell the person: "Studio updated. Start a **new** Claude Code session in the AI-Studio folder so the new rules load." If Claude Code asks whether to trust the folder or allow its hooks, they should say yes: that's what delivers Rahul's notes. In the browser tab that opens (ntfy), click the bell icon and **Allow** notifications. Summarise what changed in 3 bullets (see `CHANGELOG.md`).

If any step fails, stop, show the exact error, and explain it in plain words. Don't improvise workarounds that install software or change settings without asking.
