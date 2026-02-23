---
name: task-setup
description: >
  One-time setup for the Fountain OS task management system. Triggers when a user
  types "task-setup", "set up my task board", "set up task management", "set up my
  tasks", or is directed to run this step during Fountain OS onboarding (the
  "Configure Task Sync" step in the onboarding wizard).
version: 0.2.0
---

## Task Setup

Perform one-time setup of the Fountain OS task management system. This creates the full `productivity-app/` infrastructure including the task board, sync scripts, and shortcuts.

### Step 1: Verify Google Drive connection

Before proceeding, check whether the Google Drive MCP connector is available by attempting a Drive search.

- **If Drive is connected:** Proceed to Step 2.
- **If Drive is NOT connected:** Tell the user:

  "The task sync needs Google Drive to pull shared project context. Please connect Google Drive in **Settings > Connectors** first, then run `task-setup` again."

  Do not proceed until Drive is connected.

### Step 2: Check for existing installation

Check whether `productivity-app/` already exists in the Cowork folder.

- If it exists, list what's there and ask: "It looks like a task setup already exists. Do you want to overwrite it, or set up only the missing pieces?"
- If it does not exist, proceed without asking.

### Step 3: Create directory structure

Create the following under the Cowork folder:

```
productivity-app/
  data/
    tasks.json
  scripts/
    build-viewer.py
  shortcuts/
    daily-meeting-sync.md
  task-viewer.html
```

### Step 4: Write tasks.json

Write a starter `tasks.json` with an empty task list. See `references/tasks-json-schema.md` for the full schema.

```json
{
  "version": 1,
  "tasks": []
}
```

### Step 5: Write task-viewer.html

Write a complete, self-contained single-file HTML task board. Requirements:

- Reads `data/tasks.json` via a relative fetch call
- Displays tasks grouped by timeline bucket: Today, This Week, Next Week, Inbox, Someday
- Supports marking tasks done, editing task text, and snoozing
- Uses Fountain brand colors: navy `#213364`, cream `#EBE4CE`, cyan `#00B7C5`, warm amber `#C9813A`
- Clean, minimal UI, no external CDN dependencies
- All CSS and JS inline in the single file

The task viewer should feel like a real tool, not a prototype.

### Step 6: Write build-viewer.py

Write a Python script at `scripts/build-viewer.py`. The script should:

- Read `data/tasks.json`
- Validate the schema (check version field, check tasks is an array)
- Print a confirmation on success: "Task viewer OK — [N] tasks loaded"
- Be runnable with `python3 productivity-app/scripts/build-viewer.py` from the Cowork root

### Step 7: Write sync shortcut

Write the shortcut file. See `references/setup-shortcuts.md` for the full content.

**`shortcuts/daily-meeting-sync.md`**: Instructions for Claude to query Granola for the past 24 hours of meetings, extract action items and project updates, append tasks to tasks.json, and write project status to `Shared/context/projects/`.

The shortcut should end with running `python3 productivity-app/scripts/build-viewer.py` to refresh the viewer.

### Step 8: Run and confirm

After writing all files:

1. Run `python3 productivity-app/scripts/build-viewer.py` to verify the script works
2. Call `present_files` with `productivity-app/task-viewer.html` to open the board
3. Tell the user: "Your task board is set up. Type triage at the start of any session to open it automatically."

See `references/tasks-json-schema.md` and `references/setup-shortcuts.md` for the schema and shortcut specs.
