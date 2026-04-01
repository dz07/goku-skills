---
name: context-agent-protocol
description: Context Agent priority protocol - MUST be checked before ANY task. Routes requests to appropriate models, uses save-my-tokens for research, and implements Ask First methodology. Priority: Cerebras > Mistral > MiniMax > Claude. Check at session start.
version: "1.0.0"
metadata:
  openclaw:
    emoji: "🎯"
    triggers: ["context agent", "ask first", "route request", "optimize task", "pre-process"]
---

# Context Agent Protocol - Priority Pre-Processor

**CRITICAL: This protocol is MANDATORY at session start and before ANY task execution.**

## Priority Model Stack (Use in Order)

1. **Cerebras** (FREE) ⭐
   - Research tasks
   - Information gathering
   - Analysis
   - Use: `save-my-tokens` API

2. **Mistral** (CHEAP)
   - Quick pre-processing
   - Simple clarifications
   - Task routing

3. **MiniMax** (MODERATE)
   - Standard tasks
   - Medium complexity
   - Default for routine work

4. **Claude Sonnet** (EXPENSIVE)
   - Complex reasoning ONLY
   - Architecture decisions
   - When other models insufficient

## Context Agent Responsibilities

### 1. Request Reception
When main agent receives a task:
```
→ Forward to Context Agent for optimization
```

### 2. Analysis & Optimization
- What does user REALLY want?
- What's the minimal context needed?
- Can save-my-tokens handle this?
- Which model is most cost-effective?

### 3. Research Routing
**For ANY research/information task:**
```bash
cd ~/.openclaw/workspace/save-my-tokens && python3 simple-api.py research "..."
```
**SAVES 95% tokens vs direct API calls!**

### 4. Clarification (If Needed)
Ask 2-3 questions MAX:
```
"Quick clarification before proceeding:
1. [Most important detail]
2. [Specific requirement]
This saves 70% tokens by getting it Right first time."
```

### 5. Task Routing
Return optimized brief to main agent:
```json
{
  "clarified_request": "Exact request after questions",
  "context_needed": "Minimal context to load",
  "model_to_use": "Cerebras/Mistral/MiniMax/Claude",
  "use_save_my_tokens": true/false,
  "questions_if_needed": ["Q1", "Q2"]
}
```

## Decision Flowchart

```
User Request
     ↓
CONTEXT AGENT (Cerebras)
     ↓
├── Research task? ──→ use save-my-tokens (95% savings!)
├── Need clarification? ──→ Ask 2-3 questions
├── Simple task? ──→ Route to Mistral/MiniMax
├── Complex reasoning? ──→ Route to Claude
└── Multi-step? ──→ Spawn specialized subagent
```

## Save-My-Tokens Integration

**ALWAYS use for:**
- Market research
- Technical documentation lookup
- Competitive analysis
- Information gathering
- Salary benchmarking
- Job search research

**Command:**
```bash
cd ~/.openclaw/workspace/save-my-tokens && python3 simple-api.py research "QUERY"
```

## Ask First Protocol

**Rule: 2-3 questions before diving in = 70% token savings**

### For Debugging:
```
"Quick clarify before debugging:
1. Which service/system? (name/version)
2. What error/behavior? (message/logs)
3. When did it start?"
```

### For Code/Scripts:
```
"Before I write:
1. Language/framework?
2. Existing code to build on?
3. Key requirements?"
```

### For Research:
```
"Research scope check:
1. How deep? (summary/detailed/exhaustive)
2. Specific sources?
3. Output format?"
```

## Model Selection Matrix

| Task Type | Recommended Model | Alternative |
|-----------|------------------|-------------|
| Research/Info | Cerebras (free) | Mistral |
| Quick clarifications | Mistral | Cerebras |
| Standard tasks | MiniMax | Mistral |
| Complex reasoning | Claude Sonnet | MiniMax |
| Heavy coding | Claude Sonnet | MiniMax |
| Simple monitoring | Mistral | MiniMax |

## Daily Protocol Checklist

- [ ] Session start: Check this protocol
- [ ] Load context-efficiency-master skill
- [ ] For research: Use save-my-tokens first
- [ ] For new tasks: Ask 2-3 clarifying questions
- [ ] Route to appropriate model
- [ ] Reserve expensive tokens for when needed

## Token Savings Achieved

When properly followed:
- Research tasks: 95% savings (Cerebras vs Claude)
- General tasks: 70% savings (Ask First methodology)
- Overall: 80%+ average token reduction

---

**VERSION: 1.0.0 - Created 2026-04-01**
**DAILY UPDATE: Check for new optimizations**