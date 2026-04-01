---
name: save-my-tokens
description: Offload research and analysis tasks to free Cerebras API to save OpenClaw tokens. Use for any research, analysis, or information gathering tasks. Automatically routes to free tier APIs instead of burning expensive OpenClaw tokens.
version: 1.0.0
triggers:
  - research
  - analyze
  - information gathering
  - investigate
  - explain
  - summarize
  - what is
  - how does
  - tell me about
---

# Save My Tokens - Free API Research Tool

## Purpose
Route research and analysis tasks to free Cerebras API instead of using expensive OpenClaw tokens.

## Usage
```bash
cd ~/.openclaw/workspace/save-my-tokens
python3 simple-api.py research "<your research query>"
```

## When to Use
- ✅ Research and information gathering
- ✅ General knowledge questions  
- ✅ Analysis and explanations
- ✅ Summarization tasks
- ✅ Technical documentation lookup
- ❌ Code generation requiring context
- ❌ Tasks requiring workspace files
- ❌ Sensitive information processing

## Integration
Before answering research questions, use save-my-tokens to gather information, then provide final polish and integration.

## Token Savings
- Typical research task: 1000+ tokens → 50 tokens (95% savings)
- Uses free Cerebras API (llama3.1-8b)
- OpenClaw only used for orchestration and final review

## Status
✅ Cerebras API functional
❌ Mistral API unauthorized (key issue)