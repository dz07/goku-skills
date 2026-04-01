---
name: jira-wiki-mastery
description: Master Jira wiki markup formatting based on real-world user testing. Covers working syntax for headers, code blocks, lists, and callouts. Use when creating or formatting Jira wiki pages, troubleshooting documentation, or converting content to Jira-compatible markdown.
version: "1.0.0"
metadata:
  openclaw:
    emoji: "📋"
    triggers: ["jira wiki", "jira markup", "jira format", "wiki page", "documentation format"]
---

# Jira Wiki Mastery - Proven Formatting Guide

Master Jira wiki formatting with battle-tested syntax that actually works in production Jira environments.

## Proven Working Format

### Headers
```markdown
# MAIN TITLE
## 🚨 SECTION HEADER  
### Subsection Header
#### Sub-subsection
```

**✅ Works:** Standard markdown headers with emoji support
**❌ Fails:** `h1.` `h2.` old Jira markup syntax

### Code Blocks
```markdown
```bash
systemctl status service
command here
```
```

**✅ Works:** Triple backticks with language specification
**❌ Fails:** `{code}`, `{noformat}`, legacy Jira macros

### Lists and Checklists
```markdown
- Bullet point item
- Another bullet point
- **Bold bullet point**

1. Numbered item
2. Another numbered item

- [ ] Checkbox item (for task lists)
- [x] Completed checkbox item
```

**✅ Works:** Standard markdown lists with checkbox support
**❌ Fails:** Wiki-specific list syntax

### Text Formatting
```markdown
**Bold text**
*Italic text*
`inline code`
~~Strikethrough text~~
```

**✅ Works:** Standard markdown formatting
**❌ Fails:** `*bold*` single asterisk for bold

### Callouts and Tips
```markdown
> **💡 TIP:** Use blockquotes with bold for information callouts
> This creates a nice visual separation

> **⚠️ WARNING:** Important safety information
> Multiple lines work well here

> **📝 NOTE:** General information
> Clean and readable format
```

**✅ Works:** Blockquotes with emoji and bold headers
**❌ Fails:** `{{info}}`, `{panel}`, `{warning}` Confluence macros

### Tables
```markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Data A   | Data B   | Data C   |
```

**✅ Works:** Standard markdown table syntax
**❌ Fails:** Wiki-specific table markup

### Links and References
```markdown
[Link text](https://example.com)
[Internal page link](PageName)
<email@example.com>
```

**✅ Works:** Standard markdown link syntax
**❌ Fails:** `[PageName|Display Text]` old wiki syntax

## Failed Formats (Don't Use)

### Legacy Jira Markup
```
h1. Header (OLD - doesn't work)
h2. Section (OLD - doesn't work)
{code}script here{code} (Confluence-only)
{noformat}text{noformat} (legacy)
{{info}}message{{/info}} (macro not supported)
{panel:title=Text}content{panel} (macro not supported)
```

### Confluence-Specific
```
{code:language=bash}
script content
{code}
```
**Note:** This works in Confluence but NOT in Jira wiki pages

## Document Structure Template

```markdown
# DOCUMENT TITLE
*Brief description or purpose*

## 🚨 CRITICAL SECTION
Important information that needs attention

### Quick Commands
```bash
command1
command2
```

### Checklist
- [ ] Step 1
- [ ] Step 2  
- [ ] Step 3

## 🔧 DETAILED PROCEDURES

### Procedure 1
Step-by-step instructions

```bash
#!/bin/bash
script content here
```

### Procedure 2
More detailed steps

> **💡 TIP:** Helpful information for users
> Additional context or warnings

## 📋 TROUBLESHOOTING
Common issues and solutions

## 📞 ESCALATION
When to contact support

> **⚠️ IMPORTANT:** Critical final notes
> Always test in non-production first
```

## Validation Checklist

Before publishing a Jira wiki page:
- [ ] Headers use `#` markdown syntax
- [ ] Code blocks use triple backticks with language
- [ ] Lists use standard markdown format
- [ ] Callouts use blockquotes with bold/emoji
- [ ] No legacy Jira markup (`h1.`, `{code}`, etc.)
- [ ] No Confluence-specific macros
- [ ] Links use standard markdown format
- [ ] Tables use standard markdown format

## Common Conversion Patterns

### From Confluence to Jira
```markdown
# OLD (Confluence)
{code:java}
public class Example {}
{code}

# NEW (Jira Compatible)
```java
public class Example {}
```
```

### From Legacy Jira to Modern
```markdown
# OLD (Legacy Jira)
h1. Title
{noformat}command{noformat}

# NEW (Modern Jira)
# Title
```bash
command
```
```

## Troubleshooting Format Issues

**Problem:** Headers not rendering
**Solution:** Use `#` instead of `h1.` syntax

**Problem:** Code blocks showing as plain text
**Solution:** Use triple backticks instead of `{code}` macros

**Problem:** Lists not formatting
**Solution:** Ensure proper spacing and use `-` for bullets

**Problem:** Callouts not highlighting
**Solution:** Use blockquotes `>` with bold text instead of macros

## Real-World Example

Based on successful user implementation:

```markdown
# WAZUH MEMORY DEBUGGING WIKI
*For IT Team Reference*

## 🚨 SYMPTOMS
- Dashboard not loading (browser timeout)
- Indexer service crashed  
- OutOfMemoryError in logs

## 🔍 QUICK DIAGNOSIS

### Check Service Status
```bash
systemctl status wazuh-indexer
systemctl status wazuh-dashboard
```

### Memory Usage  
```bash
free -h
```

> **💡 TIP:** Always restart indexer before dashboard—the dashboard depends on the indexer being healthy!
```

This format was tested and confirmed working in production Jira environment.

## Integration with Other Skills

When creating documentation:
1. Use this skill for Jira wiki formatting
2. Use `cron-mastery` for OpenClaw automation docs
3. Use `human-writing` for natural language flow
4. Combine for professional, working documentation

## Version History

- v1.0.0: Initial version based on real user testing and validation
- Confirmed working format from production Jira deployment
- Standard markdown approach for maximum compatibility