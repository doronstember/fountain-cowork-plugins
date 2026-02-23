# Setup Shortcuts Reference

Content spec for the sync shortcut file created by task-setup.

---

## daily-meeting-sync.md

**Path**: `productivity-app/shortcuts/daily-meeting-sync.md`

This shortcut is followed during session start triage. It syncs Granola meeting notes into tasks and shared project context.

### File content to write

```markdown
# Daily Meeting Sync

Run at session start. Extracts action items from recent Granola meetings and updates shared project context.

## Steps

1. Query Granola for meetings from the past 24 hours using `list_meetings` with `time_range: "last_30_days"` filtered to recent, or use `query_granola_meetings` with a query like "action items and decisions from the past 24 hours".

2. For each meeting, extract:
   - Action items explicitly assigned to the current user
   - Decisions made that affect active projects
   - Blockers identified or resolved

3. For each action item found:
   - Check `productivity-app/data/tasks.json` for duplicates (match on text similarity)
   - If not a duplicate, create a new task object:
     - `text`: action item text
     - `timelineGroup`: "inbox"
     - `domain`: "fountain"
     - `status`: "active"
     - `owner`: { "type": "self", "name": null }
     - `createdAt`: today's date
     - `id`: short random string
   - Append to the tasks array in tasks.json

4. For each project-relevant update (decision, blocker, status change):
   - Find or create the corresponding file in `Shared/context/projects/`
   - Append a dated entry at the bottom: `[YYYY-MM-DD] [What changed — 1-2 sentences]`
   - Update the `Last updated: [date]` line at the top of the file

5. Run `python3 productivity-app/scripts/build-viewer.py`

6. If new tasks were added, briefly note: "Captured [N] task(s) from recent meetings."
   If none, skip silently. If Granola MCP is unavailable, skip silently without error.
```
