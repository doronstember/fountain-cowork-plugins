---
name: reflect
description: >
  Run at the end of every Cowork session. Triggers when the user types "reflect",
  says "end of session", "wrap up", "good night", "heading out", "that's all",
  "thanks", or otherwise signals they are closing a work session. Also triggers
  automatically when a major deliverable has just wrapped and no new thread is open.
version: 0.1.0
---

## Reflect

Run a structured end-of-session review. Execute in order.

### Step 1: Review the session

Scan the conversation for anything worth compounding into memory:

- **New people**: Anyone mentioned by name who is not already in `memory/people/`
- **New projects or workstreams**: Any project, initiative, or topic not in `memory/projects/`
- **New terms or acronyms**: Any domain-specific language not in `memory/glossary.md`
- **Workflow patterns**: Any task or sequence the user ran more than once — watch for skill candidates
- **Project status changes**: Any decision made, blocker identified or resolved, timeline shift
- **"Remember this"**: Anything the user explicitly asked to remember

Note: formatting and behavioral corrections are captured automatically by the always-on rule in CLAUDE.md and do not need to be surfaced here.

Skip short or routine sessions where nothing substantive occurred.

### Step 2: Propose atomic updates

Present proposed updates as a batch with a single yes/no. Use this format:

---
Here's what I'd add to memory from this session:

1. Add [Name] to memory/people/ — [Role, one sentence of context]
2. Update memory/projects/[project].md — [What changed, one sentence]
3. Add "[term]" to memory/glossary.md — [Definition]

Approve all? (yes / skip individual items)

---

Each update must be atomic: one clear action per item. Do not bundle multiple changes into one item.

### Step 3: Flag team-relevant updates

For any proposed update that is team-relevant rather than purely personal, flag it separately after the batch:

"[Item N] seems relevant to the whole team. Want me to also write it to Shared/context/?"

One yes/no per flagged item.

Team-relevant examples: project status changed, cross-functional decision made, blocker identified or resolved, new vendor or partner engaged, key timeline shift.

NOT team-relevant: personal task preferences, individual workflow tweaks, single-person workstream updates, Doron-specific context.

### Step 4: Apply approved updates

When the user approves, write to the appropriate memory files. Update `memory/METADATA.md` timestamps for any file touched. Match the existing file structure and writing style — do not reformat files.

If writing to `Shared/context/`, append a dated entry: `[YYYY-MM-DD] [What changed, 1-2 sentences]` and update the `Last updated:` line at the top.

### Session close auto-triggers

Begin reflect automatically (without waiting for the user to type "reflect") when:

1. The user sends an explicit sign-off: "good night," "thanks," "done for now," "heading out," "that's all," or any clear wrap-up phrasing
2. A major deliverable just wrapped and no new thread is open

### Lessons consolidation

Read `memory/lessons.md` if it exists. Look for:

- Duplicate rules that say the same thing in different words — merge them
- Rules that have been consistently followed and are now habitual — promote them to CLAUDE.md proper (propose as an atomic update in Step 2)
- Rules that turned out to be wrong or outdated — flag for removal

This is cleanup only. Reflect does not capture corrections — those are written to lessons.md inline, immediately when they happen, without any command.

### Skill candidate tracking

During reflect, also check `memory/skill-candidates.md` (create it if it doesn't exist). For any workflow the user ran 1-2 times, add it to the Watch list. For anything at 3+ occurrences, promote it to Active and offer to build it.

Format for skill-candidates.md:

```
Watch (1-2 occurrences):
- [Workflow description] — first seen [date]

Active (3+ occurrences — ready to build):
- [Workflow description] — seen [N] times
```
