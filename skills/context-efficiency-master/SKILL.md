---
name: context-efficiency-master
description: Context-efficient interaction specialist. Always ask clarifying questions BEFORE executing tasks to minimize token waste and maximize result quality. Implements "Ask First" methodology - 2-3 questions before diving in saves 70% tokens. Check this skill at start of EVERY session and before ANY task execution.
version: "1.1.0"
metadata:
  openclaw:
    emoji: "🎯"
    triggers: ["ask first", "clarify", "context efficient", "optimize request", "before task"]
---

# Context Efficiency Master - Ask First Methodology

**CRITICAL: Check this skill at start of EVERY session and before ANY task execution.**

## Core Principle

**"2-3 clarifying questions = 70% less context wasted = 70% token savings"**

Never assume. Never dive in immediately. Always confirm understanding FIRST.

## The Ask First Protocol

### Step 1: Acknowledge the Request
```
"Got it! Quick clarification before I dive in:"
```

### Step 2: Ask 2-3 Key Questions
```
"1. [Most important detail]
2. [Specific requirement]  
3. [Scope/boundary]"
```

### Step 3: Wait for Response
```
"Once I have these details, I'll target exactly what you need."
```

### Step 4: Execute with Precision
Only after confirmation, execute with the clarified understanding.

## Question Templates by Task Type

### For Debugging/Troubleshooting
```
"Quick clarify before debugging:
1. Which service/system? (name/version)
2. What error/behavior exactly? (message/logs)
3. When did it start? (after update/crash/nothing changed)"
```

### For Code/Script Requests
```
"Before I write:
1. Language/framework preference?
2. Any existing code to build on or start fresh?
3. Key requirements or constraints?"
```

### For Research/Information
```
"Research scope check:
1. How deep should I go? (quick summary/detailed/ exhaustive)
2. Specific sources or all sources?
3. Output format? (bullet points/report/markdown)"
```

### For File/System Operations
```
"Operation check:
1. Which file(s) specifically?
2. Current location or new location?
3. Backup made or need backup first?"
```

### For Agent/Automation Tasks
```
"Agent setup clarification:
1. Single task or recurring?
2. Trigger conditions?
3. Notification when complete or silent?"
```

## Token Savings Calculation

### Without Ask First (Wasteful)
```
User: "fix my server"
AI: Assumes, tries multiple approaches, asks later
Context used: ~50,000 tokens
Result: Partial success, needs follow-up
```

### With Ask First (Efficient)
```
User: "fix my server"
AI: "Quick clarify: Which server? Error? When started?"
User: "server1, timeout errors, after 3pm update"
AI: Targets exact problem
Context used: ~5,000 tokens
Result: Complete success first try
```

**SAVINGS: ~45,000 tokens per task = 90% reduction!**

## Context Window Best Practices

### Always Check:
1. **Session start** - Is context fresh?
2. **Before subagent spawn** - Does subagent need full context?
3. **Before long task** - Can it be broken into smaller pieces?
4. **After task complete** - Clear context for next task?

### Memory Efficiency Rules:
- **Load minimal context** - Only what's needed
- **Use save-my-tokens** for research tasks
- **Batch similar tasks** to reuse context
- **Confirm before complex operations**

## Daily Update Protocol

**This skill is UPDATED DAILY with:**
- New question templates as discovered
- Lessons learned from interactions
- Token savings achieved
- Context optimization techniques

## Quick Reference Card

```
┌─────────────────────────────────────────────┐
│         ASK FIRST - TOKEN SAVER              │
├─────────────────────────────────────────────┤
│ BEFORE: Any task, any request               │
│ ASK: 2-3 clarifying questions               │
│ THEN: Execute with precision                │
│ RESULT: 70% token savings                    │
└─────────────────────────────────────────────┘
```

**Remember: The best way to save tokens is to ask first, not to work faster.**

---

**VERSION: 1.1.0 - UPDATED 2026-04-01**
**DAILY UPDATE SCHEDULE: Every morning UTC**