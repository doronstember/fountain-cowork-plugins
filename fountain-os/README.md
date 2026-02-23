# Fountain OS Plugin

Core skills for the Fountain OS platform. Installs four skills that power every team member's daily work sessions: triage, reflect, onboard, and task-setup.

---

## Skills

| Skill | Trigger phrases | Purpose |
|---|---|---|
| **triage** | "triage", "start my session", "morning briefing", "what do I have today" | Start-of-session briefing: opens task board, pulls calendar, scans Gmail and Slack, surfaces team updates |
| **reflect** | "reflect", "good night", "done for now", "wrap up", "heading out", "that's all" | End-of-session memory review: proposes atomic updates to CLAUDE.md and memory files |
| **onboard** | "onboard", "set me up", "set up my Claude", "set up my workspace" | One-time setup for new team members: reads shared team context, interviews user, generates personal CLAUDE.md |
| **task-setup** | "task-setup", "set up my task board", "set up task management" | One-time task management setup: creates productivity-app/ with task board, sync shortcuts, and build scripts |

---

## Prerequisites

These connectors should be set up before using the skills:

| Connector | Used by | Required? |
|---|---|---|
| Google Drive | triage, onboard | Yes — reads Shared/company-context.md and Shared/context/projects/ |
| Granola | triage | Yes — meeting syncs and action item extraction |
| Gmail | triage | Yes — email scanning |
| Google Calendar | triage | Yes — daily schedule |
| Slack | triage | Yes — team message scanning |

---

## Daily workflow

1. Open a Cowork session
2. Type **triage** to start — skill opens the task board and delivers a prioritized briefing
3. Work through your day
4. Type **reflect** when done — skill reviews the session and proposes memory updates as a batch

---

## New team member setup (one-time)

1. Complete the Fountain OS onboarding wizard
2. When prompted, type **onboard** — reads shared team context and generates your personal CLAUDE.md
3. When prompted, type **task-setup** — creates your task board and sync shortcuts

---

## Components

```
fountain-os/
├── skills/
│   ├── triage/               Session start orchestration
│   │   ├── SKILL.md
│   │   └── references/
│   │       └── slack-search-guide.md
│   ├── reflect/              Session end review and memory compounding
│   │   └── SKILL.md
│   ├── onboard/              New member workspace setup
│   │   ├── SKILL.md
│   │   └── references/
│   │       └── claude-md-template.md
│   └── task-setup/           Task management infrastructure setup
│       ├── SKILL.md
│       └── references/
│           ├── tasks-json-schema.md
│           └── setup-shortcuts.md
└── README.md
```

---

## No configuration required

This plugin has no required environment variables and no MCP server dependencies of its own. All external service access goes through the connectors listed in Prerequisites above.
