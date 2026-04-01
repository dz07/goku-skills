---
name: cron-mastery
description: Master OpenClaw cron job configuration and troubleshooting. Covers session targets, payload types, delivery modes, scheduling patterns, and common failure patterns. Use when creating, debugging, or optimizing cron jobs for automated tasks, reminders, monitoring, or recurring agent workflows.
version: "1.0.0"
metadata:
  openclaw:
    emoji: "⏰"
    triggers: ["cron job", "schedule task", "automate", "recurring", "reminder", "hourly", "daily", "weekly"]
---

# Cron Mastery - OpenClaw Automation Expert

Master OpenClaw cron jobs for automated tasks, reminders, monitoring, and recurring workflows.

## Core Principles

### Session Target Rules (CRITICAL)

**sessionTarget determines where the job runs:**

```yaml
# MAIN SESSION (Current conversation)
sessionTarget: "main"
payload.kind: "systemEvent"  # ONLY systemEvent allowed
# Result: Injects text into current chat

# ISOLATED SESSION (Fresh subagent each time)  
sessionTarget: "isolated"
payload.kind: "agentTurn"    # ONLY agentTurn allowed
# Result: Creates new subagent, runs task, auto-announces

# CURRENT SESSION (Bind to session where created)
sessionTarget: "current" 
payload.kind: "agentTurn"    # ONLY agentTurn allowed
# Result: Runs in the session that created the cron

# NAMED SESSION (Persistent session)
sessionTarget: "session:my-project"
payload.kind: "agentTurn"    # ONLY agentTurn allowed  
# Result: Runs in persistent named session
```

### Payload Types

**systemEvent:**
```json
{
  "kind": "systemEvent",
  "text": "🔔 Reminder: Check server logs"
}
```
- Simple text injection
- No AI processing
- Only works with sessionTarget: "main"

**agentTurn:**
```json
{
  "kind": "agentTurn", 
  "message": "Search for DevOps jobs in Germany",
  "model": "claude-sonnet-4",
  "timeoutSeconds": 600
}
```
- Full AI agent execution
- Requires sessionTarget: "isolated"|"current"|"session:xxx"
- Can use tools, reasoning, memory

### Schedule Types

**Every (Recurring):**
```json
{
  "kind": "every",
  "everyMs": 3600000,        // 1 hour = 3600000ms
  "anchorMs": 1775042940000  // Start time (Unix timestamp)
}
```

**At (One-time):**
```json
{
  "kind": "at",
  "at": "2026-04-01T15:30:00Z"  // ISO-8601 timestamp
}
```

**Cron Expression:**
```json
{
  "kind": "cron",
  "expr": "0 */6 * * *",  // Every 6 hours
  "tz": "UTC"             // Optional timezone
}
```

### Delivery Modes

**announce (Default for isolated agentTurn):**
```json
{
  "mode": "announce",
  "channel": "telegram",  // Optional
  "to": "722246960"       // Optional
}
```

**webhook:**
```json
{
  "mode": "webhook",
  "to": "https://api.example.com/webhook"
}
```

**none:**
```json
{
  "mode": "none"
}
```

## Common Patterns

### Hourly Job Search Agent
```json
{
  "name": "DevOps Job Search - Hourly",
  "schedule": {
    "kind": "every",
    "everyMs": 3600000
  },
  "sessionTarget": "isolated",
  "payload": {
    "kind": "agentTurn",
    "message": "Search German DevOps jobs for Elmehdi profile. Use Scrapling to check Siemens, LinkedIn. Report new opportunities.",
    "timeoutSeconds": 600
  },
  "delivery": {
    "mode": "announce"
  }
}
```

### Daily System Monitor
```json
{
  "name": "Wazuh Health Check",
  "schedule": {
    "kind": "cron", 
    "expr": "0 8 * * *"
  },
  "sessionTarget": "isolated",
  "payload": {
    "kind": "agentTurn",
    "message": "Check Wazuh services status. Verify indexer memory usage, dashboard health, manager logs.",
    "timeoutSeconds": 300
  }
}
```

### Simple Reminder
```json
{
  "name": "Meeting Reminder",
  "schedule": {
    "kind": "at",
    "at": "2026-04-01T14:00:00Z"
  },
  "sessionTarget": "main",
  "payload": {
    "kind": "systemEvent", 
    "text": "🔔 Meeting in 30 minutes: DevOps team standup"
  }
}
```

## Troubleshooting

### Common Failures

**❌ "missing payload.kind"**
```bash
# Fix: Add payload.kind
"payload": {"kind": "agentTurn", "message": "..."}
```

**❌ "sessionTarget main requires systemEvent"**
```bash
# Fix: Change to isolated OR use systemEvent
"sessionTarget": "isolated"
"payload": {"kind": "agentTurn"}
```

**❌ "cron channel delivery config only for isolated"**
```bash
# Fix: Use isolated sessionTarget for delivery
"sessionTarget": "isolated"
"delivery": {"mode": "announce"}
```

**❌ Job runs but no results**
```bash
# Check: timeout too short
"payload": {"timeoutSeconds": 600}  # 10 minutes
```

### Debugging Commands

```bash
# List all cron jobs
cron action=list

# Check job run history  
cron action=runs jobId=<id>

# Test job immediately
cron action=run jobId=<id> runMode=force

# Update job settings
cron action=update jobId=<id> patch='{"enabled": false}'

# Remove failed job
cron action=remove jobId=<id>
```

## Time Calculations

```javascript
// Common intervals (milliseconds)
1 minute  = 60000
5 minutes = 300000  
30 minutes = 1800000
1 hour    = 3600000
6 hours   = 21600000
12 hours  = 43200000
1 day     = 86400000
1 week    = 604800000

// Get current timestamp
Date.now()  // JavaScript
date +%s000 # Bash (adds 000 for ms)
```

## Best Practices

### Session Target Selection

- **Simple reminders** → `sessionTarget: "main"` + `systemEvent`
- **AI tasks** → `sessionTarget: "isolated"` + `agentTurn`  
- **Persistent workflows** → `sessionTarget: "session:name"` + `agentTurn`
- **Current conversation** → `sessionTarget: "current"` + `agentTurn`

### Performance

- Set reasonable `timeoutSeconds` (300-600 for most tasks)
- Use `isolated` for independent tasks
- Batch related operations in single job
- Monitor with `cron action=runs` periodically

### Security

- Validate webhook URLs before adding
- Use named sessions for sensitive operations
- Test jobs with `runMode=force` before enabling
- Set appropriate timeouts to prevent hanging

## Integration Examples

### With Save-My-Tokens
```json
{
  "payload": {
    "kind": "agentTurn",
    "message": "Use save-my-tokens to research latest DevOps trends. Search for 'Kubernetes 2026 job market Germany' and 'DevOps salary trends'. Report findings.",
    "timeoutSeconds": 300
  }
}
```

### With Scrapling
```json
{
  "payload": {
    "kind": "agentTurn", 
    "message": "Use Scrapling to scrape job boards: arbeitnow.com, linkedin.com/jobs. Search 'DevOps Kubernetes Germany'. Extract: job titles, companies, salaries, links.",
    "timeoutSeconds": 600
  }
}
```

### Memory Integration
```json
{
  "payload": {
    "kind": "agentTurn",
    "message": "Check memory for last job search results. Compare with new findings. Update MEMORY.md with latest opportunities and track application status.",
    "timeoutSeconds": 300
  }
}
```

## Error Recovery

```bash
# If job fails repeatedly:
1. Check logs: cron action=runs jobId=<id>
2. Test manually: cron action=run jobId=<id> runMode=force  
3. Increase timeout: cron action=update jobId=<id> patch='{"payload":{"timeoutSeconds":900}}'
4. Simplify task: Break complex jobs into smaller pieces
5. Disable/recreate: action=remove then action=add
```

This skill enables reliable, scalable automation across all OpenClaw workflows.

## Jira Wiki Format (LEARNED FROM USER SUCCESS)

**✅ WORKING JIRA WIKI FORMAT:**


**❌ FAILED FORMATS:**
- `h1.` headers (old Jira markup)
- `{code}` blocks (Confluence-only) 
- `{noformat}` (legacy)
- `{{info}}` panels (not supported)

**Use standard markdown for maximum Jira compatibility!**
## Jira Wiki Format (LEARNED FROM USER SUCCESS)

**✅ WORKING JIRA WIKI FORMAT:**
```
# HEADER TITLE
## SECTION HEADER
### Subsection

```bash
command here
```

- Bullet point
- [ ] Checkbox item
**Bold text** and *italic text*

> **💡 TIP:** Use blockquotes with bold for callouts
```

**❌ FAILED FORMATS:**
- `h1.` headers (old Jira markup)
- `{code}` blocks (Confluence-only) 
- `{noformat}` (legacy)
- `{{info}}` panels (not supported)

**Standard markdown works best for this Jira version!**