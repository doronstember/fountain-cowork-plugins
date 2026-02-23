---
name: triage
description: >
  Run at the start of every Cowork session. Triggers when the user types "triage",
  says "start my session", "what's going on today", "morning briefing", "what do I
  have today", or otherwise indicates they are beginning a work session and want a
  situational summary of tasks, calendar, messages, and team updates.
version: 0.2.0
---

## Triage

Run a full session start sequence. Execute all steps in the order below.

### Step 0: Load lessons

Before anything else, check whether `memory/lessons.md` exists. If it does, read it silently. The rules in it override any defaults for this session.

### Step 1: Open the task board

Call `present_files` with `productivity-app/task-viewer.html`. Say exactly:

"Your task board is in the right panel (click the task viewer card below if it didn't open automatically)."

### Step 2: Run background syncs (silent, parallel)

Run this sync in the background. Do not announce it. Mention new tasks captured only if any were found; skip silently if the MCP is unavailable.

- **Granola sync**: Follow `productivity-app/shortcuts/daily-meeting-sync.md` to extract action items from recent meetings into tasks.json and write shared project status updates to `Shared/context/projects/`.

### Step 3: Pull today's calendar

Call `list_gcal_events` for today. Check the current time before describing any events. Do not describe past events as upcoming. Note meetings, prep needs, and scheduling constraints.

### Step 4: Scan Gmail (parallel)

Run these two Gmail searches in parallel:

1. `after:[yesterday] is:unread OR is:important` for broad recent coverage
2. `after:[3 days ago] is:starred` for items flagged earlier

Surface anything time-sensitive, requiring a response, or relevant to open tasks. Signal over noise. Do not surface routine notifications or newsletters.

### Step 5: Scan Slack (parallel, dynamic)

Build the Slack search dynamically from the user's CLAUDE.md. Read the People section to extract leadership names (the people listed in the leadership table or equivalent). Then run three searches in parallel, all scoped to the past 48 hours:

1. **Direct mentions**: `[user's first name] after:[yesterday]` across all channels and DMs
2. **Leadership messages**: `from:[name1] OR from:[name2] OR ... after:[yesterday]` using the leadership names from CLAUDE.md
3. **Urgency signals**: `urgent OR ASAP OR "need you" OR deadline after:[yesterday]`

If any result looks substantive, read the thread. A thin result set is not a green light. If fewer than 5 results come back total, broaden the date window or try channel-specific reads. Do not report Slack as clear until all three searches are done.

See `references/slack-search-guide.md` for search syntax and channel list.

### Step 6: Scan shared project context

Scan `Shared/context/projects/` for files with a `Last updated` timestamp newer than the previous session. Surface a brief summary: which projects had updates, what type (decisions, blockers, progress), who was involved. Keep to 2-3 lines unless the user asks for detail. If `Shared/` is not readable, skip silently.

### Step 7: Deliver the briefing

Present a prioritized summary covering:

- Today's schedule (upcoming events only; omit anything already past)
- Priority tasks from the task board (owner: self or unassigned; skip tasks snoozed until today or later)
- Any urgent emails or messages needing a response
- Team project updates worth knowing
- Any new tasks captured from syncs

Sort by urgency and time-sensitivity. Surface 3-5 items maximum unless more are genuinely pressing. End with one clear suggestion for where to start.

### Task display rules

Show only tasks where `owner.type == "self"` or no owner is set. Skip tasks assigned to other named individuals. If ownership is ambiguous and the user is a plausible owner, surface it and ask. Skip tasks where `snoozedUntil` is today or a future date.
