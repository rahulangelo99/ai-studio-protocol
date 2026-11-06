# 04 · Files and tracking: everything saved, everything findable

## Layout
```
AI-Studio/
  CLAUDE.md            loads these rules every session
  studio.local.md      private: name + message channels (never share)
  protocol/            these rules
  guides/              reference for the person
  IDEA-LOG.md          one line per idea: number, name, status, folder
  NN-idea-name/
    BRIEF.md           problem, who it's for, the idea, first-version goal
    LOG.md             dated entries, newest at the bottom
    outputs/           finished things to show people
    work/              drafts, research notes, scratch
    _archive/          retired files (never deleted)
```

## Rules
- A new idea gets the next number: `NN-short-name/` (lowercase, dashes). Create BRIEF.md, LOG.md, outputs/, work/, and add a line to IDEA-LOG.md.
- Save **every** file you make inside the current idea's folder, never on the Desktop, in Downloads or in temp folders. If a tool saved something elsewhere, move it in and say so.
- Never overwrite a finished output: `pitch-v2.pdf`, `site-v3.html`.
- Never delete. Retire things to `_archive/`.
- Research: save a `work/sources.md` with every link actually opened and the date.

## Log entry (after every meaningful step)
```
## 2026-11-06 14:20 · <one-line title>
Asked: <the sharpened request>
Made: <files, with paths>
Checked: <what you verified and how, or "not checked">
Next: <one step>
```
Mistakes go under `### Corrections` in the same LOG.md.

## Version history
After each log entry: `git add -A && git commit -qm "<idea>: <what changed>"`. The person never has to touch git. If git is missing, say so once and keep logging.

## Session start and end
- **Start:** read IDEA-LOG.md and the last LOG.md entries of the active idea, then say in two lines where things stand.
- **"wrap":** write a closing LOG entry (what's done, what's open, next step), commit, and offer Rahul a one-line status.

## Commands the person can type
`log` (ideas + latest entries) · `where is it?` (exact path, offer to open Finder) · `wrap` (close the session properly) · `undo` (show the last change and offer to restore the previous version from history, with a yes).
