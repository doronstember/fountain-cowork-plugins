---
name: onboard
description: >
  Sets up a new Fountain OS team member's personal Claude workspace. Triggers when a
  new user types "onboard", "set up my Claude", "set me up", "set up my workspace",
  "get me started", or is directed to run this step during Fountain OS onboarding
  (the "Set up your workspace" step in the onboarding wizard).
version: 0.1.0
---

## Onboard

Set up a new team member's personal Fountain OS workspace. Run the full sequence below.

### Step 0: Open the onboarding wizard

**Do this first, before saying anything else.**

Search Google Drive for `onboarding-wizard.html` in the Fountain Shared / setup-kit folder. Download or access the file, save it temporarily to the user's Cowork folder as `onboarding-wizard.html` if it is not already there, then call `present_files` with that path. This opens the wizard in the right panel of Claude Desktop.

After calling `present_files`, greet the user briefly in the chat — something like: "Welcome to Fountain OS. The setup wizard is open in the right panel — it will guide you through each step. I'll run through the setup questions here in the chat at the same time. Let's start with a few basics."

If the wizard file is not accessible (Drive not connected or file not found), skip silently and proceed to Step 1 without mentioning it.

### Step 1: Load team context

Search Google Drive for `company-context.md` in the Fountain Shared folder. Read the file. It provides the canonical team roster, org structure, active projects, and company vocabulary.

If the file is not accessible (Drive not connected or file not found), pause and tell the user:

"I need access to the shared team context to set you up properly. Please make sure Google Drive is connected in Settings → Connectors, then try again."

### Step 2: Interview the new user

Ask the following questions in 2-3 conversational turns (not all at once). Be welcoming and collegial — this is their first real interaction with the platform.

1. **Name and role**: What's your name, and what's your role at Fountain?
2. **Responsibilities**: What are your main areas of ownership or focus?
3. **Key relationships**: Who do you work with most closely? Who do you report to, and who reports to you?
4. **Recurring meetings**: Do you have any regular meetings (weekly syncs, standups, etc.)? What are they and when?
5. **Working style**: Any preferences for how Claude should work with you? (e.g., concise vs. detailed)
6. **Domain focus**: Is your work primarily clinical, operational, product/tech, or a mix?
7. **Email**: What email address should Claude use when referencing you?

### Step 3: Generate CLAUDE.md

Using the interview answers and the team context from Step 1, write `.claude/CLAUDE.md` to the user's Cowork folder.

Use the template in `references/claude-md-template.md` as the structural guide. Personalize all sections for this specific user:

- Populate the People section with teammates they mentioned, pulling full names and roles from company-context.md
- Set tone table entries based on their role and stated relationships
- Include their actual recurring meetings
- Reflect their working style preferences
- Strip sections that don't apply to their role (e.g., clinical terms if they have no clinical context)

### Step 4: Create memory directory structure

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

### Step 5: Confirm

Tell the user what was created. Keep it brief — they can review the files themselves. Point them to the next step in the onboarding wizard: Configure Task Sync (type `task-setup` to run it).

See `references/claude-md-template.md` for the full CLAUDE.md template structure.
