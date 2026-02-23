---
name: onboard
description: >
  Sets up a new Fountain OS team member's personal Claude workspace. Triggers when a
  new user types "onboard", "set up my Claude", "set me up", "set up my workspace",
  "get me started", or is directed to run this step during Fountain OS onboarding
  (the "Set up your workspace" step in the onboarding wizard).
version: 0.2.0
---

## Onboard

Set up a new team member's personal Fountain OS workspace. Run the full sequence below.

### Step 1: Open the onboarding wizard

**Do this first, before saying anything else.**

The wizard file is bundled with this plugin at `references/onboarding-wizard.html`. Copy it to the user's Cowork folder as `onboarding-wizard.html`, then call `present_files` with that path. This opens the wizard in the right panel of Claude Desktop.

After calling `present_files`, greet the user briefly in the chat: "Welcome to Fountain OS. The setup wizard is open in the right panel. It will guide you through each step, and I'll work through the setup questions here in the chat. Let's get started."

### Step 2: Verify Google Drive connection

Before proceeding, check whether the Google Drive MCP connector is available by attempting a Drive search (e.g., search for `company-context.md`).

- **If Drive is connected:** Confirm silently and proceed to Step 3.
- **If Drive is NOT connected:** Stop and tell the user:

  "Before we continue, I need you to connect Google Drive. Go to **Settings > Connectors** (the puzzle piece icon at the bottom of the left sidebar), find Google Drive, and click Connect. Once it's linked, come back and type `onboard` again."

  Do not proceed until Drive is connected. The rest of the setup depends on it.

### Step 3: Load team context

Search Google Drive for `company-context.md` in the Fountain Shared folder. Read the file. It provides the canonical team roster, org structure, active projects, and company vocabulary.

If the file is found but unreadable, tell the user and ask them to check their Drive permissions.

### Step 4: Interview the new user

Ask the following questions in 2-3 conversational turns (not all at once). Be welcoming and collegial.

1. **Name and role**: What's your name, and what's your role at Fountain?
2. **Responsibilities**: What are your main areas of ownership or focus?
3. **Key relationships**: Who do you work with most closely? Who do you report to, and who reports to you?
4. **Recurring meetings**: Do you have any regular meetings (weekly syncs, standups, etc.)? What are they and when?
5. **Working style**: Any preferences for how Claude should work with you? (e.g., concise vs. detailed)
6. **Domain focus**: Is your work primarily clinical, operational, product/tech, or a mix?
7. **Email**: What email address should Claude use when referencing you?

### Step 5: Generate CLAUDE.md

Using the interview answers and the team context from Step 3, write `.claude/CLAUDE.md` to the user's Cowork folder.

Use the template in `references/claude-md-template.md` as the structural guide. Personalize all sections for this specific user:

- Populate the People section with teammates they mentioned, pulling full names and roles from company-context.md
- Set tone table entries based on their role and stated relationships
- Include their actual recurring meetings
- Reflect their working style preferences
- Strip sections that don't apply to their role (e.g., clinical terms if they have no clinical context)

### Step 6: Create memory directory structure

Create the following structure under `.claude/`:

```
.claude/
  memory/
    METADATA.md
    glossary.md
    people/
    projects/
    context/
      fountain.md
```

Write a starter `glossary.md` containing the core Fountain terms from company-context.md's Quick Reference section.

Write a starter `context/fountain.md` covering the user's role, domain focus, and key relationships.

Write `METADATA.md` with initial timestamps for all files just created. Format:

```
# Memory Metadata

| File | Last Updated |
|---|---|
| CLAUDE.md | [today's date] |
| glossary.md | [today's date] |
| context/fountain.md | [today's date] |
```

### Step 7: Set up task board

Run the `task-setup` skill automatically. Tell the user: "Now I'll set up your task board." Then execute the task-setup sequence.

### Step 8: Confirm

Tell the user what was created. Keep it brief. Let them know:

- Their workspace is configured and ready
- Type `triage` at the start of each session for a morning briefing
- Type `reflect` at the end of each session to compound what they learned
- The onboarding wizard in the right panel has a summary of everything that was set up

See `references/claude-md-template.md` for the full CLAUDE.md template structure.
