# tasks.json Schema

Full schema for the Fountain OS task file at `productivity-app/data/tasks.json`.

## Top-level structure

```json
{
  "version": 1,
  "tasks": []
}
```

## Task object

```json
{
  "id": "abc123",
  "text": "Task description",
  "status": "active",
  "timelineGroup": "today",
  "domain": "fountain",
  "owner": {
    "type": "self",
    "name": null
  },
  "snoozedUntil": null,
  "createdAt": "2026-02-23",
  "version": 1
}
```

## Field definitions

| Field | Type | Values | Description |
|---|---|---|---|
| `id` | string | Unique | Short random string or UUID fragment |
| `text` | string | Any | Task description |
| `status` | string | `active`, `done` | Current status |
| `timelineGroup` | string | `inbox`, `today`, `this_week`, `next_week`, `someday`, `done` | When to work on it |
| `domain` | string | `fountain`, `personal` | Work domain |
| `owner` | object | See below | Who owns the task |
| `snoozedUntil` | string or null | ISO date (`YYYY-MM-DD`) or null | Skip display until this date |
| `createdAt` | string | ISO date | When task was created |
| `version` | number | 1 | Schema version for this task |

## Owner object

```json
{
  "type": "self",
  "name": null
}
```

- `type`: `"self"` (user's own task), `"other"` (delegated to someone else), `"shared"` (joint ownership)
- `name`: null for self tasks; string name for delegated tasks (e.g., `"Lindsay"`, `"Rob"`)

## Display rules

Show tasks where:
- `owner.type == "self"` OR `owner` field is absent
- `status != "done"` (unless rendering the Done group)
- `snoozedUntil` is null OR is a date strictly before today

Skip tasks where `owner.name` is set to a specific person other than the current user.

## Timeline groups (display order)

1. **Today** -- do today
2. **This Week** -- do this week but not necessarily today
3. **Next Week** -- do next week
4. **Inbox** -- unsorted, needs classification
5. **Someday** -- no timeline commitment
6. **Done** -- completed tasks (collapsed by default)

## ID generation

Generate IDs as short random alphanumeric strings (6-8 characters). Example: `"t8kxp2"`, `"m3qvn7"`. Do not use sequential integers (fragile on concurrent writes).
