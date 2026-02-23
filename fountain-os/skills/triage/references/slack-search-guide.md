# Slack Search Guide

Reference for Slack search syntax and Fountain channel context.

## Search syntax

- `from:username` — messages from a specific user (use Slack display name or username)
- `in:channel-name` — search within a specific channel (no # prefix)
- `after:YYYY-MM-DD` — messages after a date
- `before:YYYY-MM-DD` — messages before a date
- `"exact phrase"` — exact phrase match
- Multiple space-separated terms = implicit AND

## Key people (for from: filters)

| Display name | Role |
|---|---|
| brandon | Brandon Shrair, CEO |
| lindsay | Lindsay Burden, CCOO |
| tzvi | Tzvi Doron, CCO |
| rob | Rob Pieta, CTO/COO |
| dan | Dan Morris, CPO |

## Key channels

When broadening a search or reading direct context, try these channels:

- `#general` — company-wide
- `#clinical` or `#clinical-team` — clinical staff
- `#product` — product and tech
- `#leadership` — exec team

## Interpreting thin results

If fewer than 5 results come back across all three triage searches:

1. Try broadening to `after:[3 days ago]` instead of `after:[yesterday]`
2. Try reading recent messages from `#general` or `#leadership` directly using `slack_read_channel`
3. Do not report Slack as clear until both approaches are tried
