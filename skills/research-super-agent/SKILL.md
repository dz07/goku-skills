---
name: research-super-agent
description: Advanced research specialist with deep web search, data analysis, and information synthesis capabilities. Handles complex research tasks, competitive analysis, market research, technical documentation research, and multi-source information gathering. Use for any research-intensive tasks requiring thorough investigation and analysis.
version: "1.0.0"
metadata:
  openclaw:
    emoji: "🔬"
    triggers: ["research", "investigate", "analyze", "market research", "competitive analysis", "information gathering", "study"]
---

# Research Super Agent - Advanced Information Intelligence

Master complex research tasks with systematic investigation, multi-source analysis, and comprehensive reporting capabilities.

## Core Research Methodologies

### Systematic Research Process
```
1. SCOPE DEFINITION
   ├── Define research objectives
   ├── Identify key questions
   ├── Set success criteria
   └── Determine scope boundaries

2. SOURCE IDENTIFICATION
   ├── Primary sources (direct data)
   ├── Secondary sources (reports, studies)
   ├── Web resources (official sites, forums)
   └── Expert knowledge bases

3. DATA COLLECTION
   ├── Web search strategies
   ├── Document analysis
   ├── Information extraction
   └── Source validation

4. ANALYSIS & SYNTHESIS
   ├── Pattern identification
   ├── Gap analysis
   ├── Comparative analysis
   └── Insight generation

5. REPORTING & DOCUMENTATION
   ├── Executive summary
   ├── Detailed findings
   ├── Recommendations
   └── Supporting evidence
```

## Research Specializations

### Market Research
```bash
# Market analysis framework
1. Market size and growth trends
2. Competitive landscape mapping
3. Customer segment analysis
4. Industry trends and forecasts
5. Pricing and positioning analysis
6. SWOT analysis for key players
7. Market entry barriers and opportunities
```

**Tools and Sources:**
- Industry reports (Gartner, Forrester, IDC)
- Government statistics and databases
- Company financial reports and filings
- Trade publications and journals
- Professional networks and forums

### Technical Research
```bash
# Technology investigation process
1. Technology landscape overview
2. Feature and capability comparison
3. Performance benchmarking
4. Integration requirements analysis
5. Security and compliance review
6. Cost-benefit analysis
7. Implementation roadmap planning
```

**Research Channels:**
- Official documentation
- GitHub repositories and code analysis
- Technical forums (Stack Overflow, Reddit)
- Vendor websites and whitepapers
- Academic papers and research journals

### Competitive Analysis
```bash
# Competitive intelligence gathering
1. Competitor identification and categorization
2. Product/service feature comparison
3. Pricing strategy analysis
4. Marketing and positioning review
5. Customer review and feedback analysis
6. Financial performance comparison
7. Strategic direction assessment
```

**Intelligence Sources:**
- Company websites and press releases
- Social media presence analysis
- Customer review platforms
- Industry analyst reports
- Patent and trademark databases

## Advanced Research Techniques

### Multi-Source Validation
```python
# Research validation framework
def validate_information(claim, sources):
    validation_score = 0
    
    # Primary source verification
    if has_primary_source(claim):
        validation_score += 40
    
    # Multiple source confirmation
    confirmed_sources = count_confirming_sources(claim)
    validation_score += min(confirmed_sources * 10, 30)
    
    # Source credibility assessment
    credibility_score = assess_source_credibility(sources)
    validation_score += credibility_score * 0.3
    
    # Recency factor
    if is_recent(claim, months=6):
        validation_score += 10
    
    return validation_score
```

### Search Strategy Optimization
```bash
# Advanced search techniques
1. Boolean search operators (AND, OR, NOT)
2. Phrase searches ("exact phrase")
3. Site-specific searches (site:domain.com)
4. File type filtering (filetype:pdf)
5. Date range limitations
6. Language and region targeting
7. Social media search strategies
```

### Information Synthesis Methods
```markdown
# Synthesis framework
## Pattern Analysis
- Identify recurring themes
- Map cause-and-effect relationships
- Recognize trend patterns
- Spot anomalies and outliers

## Gap Analysis
- Information gaps identification
- Missing data points
- Conflicting information resolution
- Additional research needs

## Insight Generation
- Cross-source correlation
- Implicit information extraction
- Future trend prediction
- Strategic implications
```

## Research Project Templates

### Market Entry Research
```markdown
# Market Entry Research Template

## Executive Summary
- Market opportunity size
- Key success factors
- Major challenges and risks
- Go/no-go recommendation

## Market Analysis
- Market size and growth rate
- Customer segments and needs
- Buying behavior and preferences
- Distribution channels

## Competitive Landscape
- Direct and indirect competitors
- Market share distribution
- Competitive positioning
- Differentiation opportunities

## Regulatory Environment
- Key regulations and compliance
- Licensing and certification requirements
- Industry standards and best practices
- Political and economic factors

## Financial Projections
- Revenue opportunity assessment
- Cost structure analysis
- Investment requirements
- ROI projections and timeline

## Risk Assessment
- Market risks
- Competitive risks
- Regulatory risks
- Mitigation strategies

## Recommendations
- Entry strategy options
- Resource requirements
- Timeline and milestones
- Success metrics
```

### Technology Evaluation Research
```markdown
# Technology Evaluation Template

## Technology Overview
- Core capabilities and features
- Technical specifications
- Architecture and design principles
- Development and maintenance status

## Competitive Analysis
- Alternative solutions comparison
- Feature gap analysis
- Performance benchmarking
- Cost comparison

## Implementation Assessment
- Integration requirements
- Resource needs (technical, human)
- Timeline and complexity
- Training and adoption requirements

## Risk Analysis
- Technical risks
- Vendor risks
- Security considerations
- Compliance implications

## Total Cost of Ownership
- Licensing and subscription costs
- Implementation and integration costs
- Ongoing maintenance and support
- Training and change management

## Recommendation
- Suitability assessment
- Implementation roadmap
- Success criteria and metrics
- Monitoring and evaluation plan
```

## Research Tools and Resources

### Web Research Tools
```bash
# Search engines and databases
- Google (advanced search operators)
- Bing (unique indexing advantages)
- DuckDuckGo (privacy-focused)
- Yandex (Russian and Eastern European content)
- Baidu (Chinese content)

# Academic and professional databases
- Google Scholar
- JSTOR
- PubMed
- ResearchGate
- IEEE Xplore

# Business and financial research
- Bloomberg Terminal
- Thomson Reuters Eikon
- S&P Capital IQ
- Crunchbase
- PitchBook
```

### Data Analysis and Visualization
```python
# Research data processing pipeline
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

def analyze_research_data(data_sources):
    # Combine multiple data sources
    combined_data = merge_data_sources(data_sources)
    
    # Clean and normalize data
    clean_data = clean_and_normalize(combined_data)
    
    # Perform statistical analysis
    stats = generate_statistics(clean_data)
    
    # Create visualizations
    charts = create_visualizations(clean_data)
    
    # Generate insights
    insights = extract_insights(stats, charts)
    
    return {
        'data': clean_data,
        'statistics': stats,
        'visualizations': charts,
        'insights': insights
    }
```

### Information Organization Systems
```markdown
# Research organization framework

## Source Tracking
- Source URL and access date
- Author and publication information
- Credibility and bias assessment
- Relevance and importance rating

## Content Categorization
- Topic and subtopic classification
- Information type (fact, opinion, analysis)
- Supporting evidence quality
- Actionability level

## Insight Management
- Key findings documentation
- Cross-reference linking
- Update and revision tracking
- Recommendation development
```

## Quality Assurance Framework

### Source Credibility Assessment
```python
def assess_source_credibility(source):
    credibility_factors = {
        'author_expertise': 0,      # 0-25 points
        'publication_reputation': 0, # 0-25 points
        'peer_review_status': 0,     # 0-20 points
        'citation_frequency': 0,     # 0-15 points
        'recency': 0,               # 0-10 points
        'bias_assessment': 0        # 0-5 points
    }
    
    # Evaluate each factor
    total_score = sum(credibility_factors.values())
    
    if total_score >= 80:
        return "Highly Credible"
    elif total_score >= 60:
        return "Credible"
    elif total_score >= 40:
        return "Moderate Credibility"
    else:
        return "Low Credibility"
```

### Research Validation Checklist
```markdown
# Pre-delivery validation checklist

## Information Accuracy
- [ ] Facts verified against primary sources
- [ ] Statistics confirmed from authoritative sources
- [ ] Quotes and citations properly attributed
- [ ] No outdated or obsolete information

## Completeness Assessment
- [ ] All research objectives addressed
- [ ] Key questions answered
- [ ] Significant information gaps identified
- [ ] Alternative perspectives considered

## Analysis Quality
- [ ] Logical flow and reasoning
- [ ] Evidence supports conclusions
- [ ] Assumptions clearly stated
- [ ] Limitations acknowledged

## Presentation Standards
- [ ] Clear executive summary
- [ ] Well-organized sections
- [ ] Proper source citations
- [ ] Actionable recommendations
```

## Advanced Research Applications

### Trend Analysis and Forecasting
```python
# Trend analysis framework
def analyze_trends(historical_data, indicators):
    trends = {}
    
    for indicator in indicators:
        # Time series analysis
        trend_direction = calculate_trend_direction(historical_data[indicator])
        trend_strength = calculate_trend_strength(historical_data[indicator])
        
        # Seasonal pattern detection
        seasonality = detect_seasonality(historical_data[indicator])
        
        # Forecast generation
        forecast = generate_forecast(historical_data[indicator], periods=12)
        
        trends[indicator] = {
            'direction': trend_direction,
            'strength': trend_strength,
            'seasonality': seasonality,
            'forecast': forecast,
            'confidence': calculate_confidence_interval(forecast)
        }
    
    return trends
```

### Sentiment and Opinion Analysis
```bash
# Opinion research methodology
1. Source identification (reviews, forums, social media)
2. Content extraction and cleaning
3. Sentiment classification (positive, neutral, negative)
4. Topic modeling and theme extraction
5. Trend analysis over time
6. Geographic and demographic segmentation
7. Insight synthesis and reporting
```

### Regulatory and Compliance Research
```markdown
# Regulatory research framework

## Jurisdiction Analysis
- Applicable laws and regulations
- Regulatory body identification
- Compliance requirements mapping
- Penalty and enforcement review

## Change Monitoring
- Proposed regulation tracking
- Industry consultation participation
- Implementation timeline monitoring
- Impact assessment preparation

## Best Practice Research
- Industry standard identification
- Peer company analysis
- Expert recommendation synthesis
- Implementation guidance development
```

This comprehensive Research Super Agent provides systematic methodologies for conducting thorough, accurate, and actionable research across multiple domains and use cases.