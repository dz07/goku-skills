---
name: hr-job-super-scraper
description: Advanced job search and recruitment automation expert. Handles job board scraping, candidate matching, salary analysis, market research, and recruitment automation. Use for job searches, talent acquisition, market analysis, and recruitment process optimization.
version: "1.0.0"
metadata:
  openclaw:
    emoji: "💼"
    triggers: ["job search", "recruitment", "job scraping", "talent acquisition", "hiring", "job boards", "career search", "employment"]
---

# HR Job Super Scraper - Advanced Recruitment Intelligence

Master job search automation, talent acquisition, and recruitment analytics with comprehensive scraping and analysis capabilities.

## Core Job Search Framework

### Job Scraping Pipeline
```
1. TARGET IDENTIFICATION
   ├── Job board selection
   ├── Search parameters definition
   ├── Geographic targeting
   └── Industry/role filtering

2. DATA EXTRACTION
   ├── Job listings scraping
   ├── Company information gathering
   ├── Salary data collection
   └── Requirements analysis

3. DATA PROCESSING
   ├── Duplicate removal
   ├── Information standardization
   ├── Skill extraction
   └── Qualification parsing

4. MATCHING & ANALYSIS
   ├── Candidate-job matching
   ├── Skill gap analysis
   ├── Salary benchmarking
   └── Market trend analysis

5. REPORTING & AUTOMATION
   ├── Opportunity prioritization
   ├── Application tracking
   ├── Alert generation
   └── Performance metrics
```

## Advanced Job Board Integration

### Scrapling-Based Scraping Framework
```python
# Comprehensive job board scraping using Scrapling
from scrapling.fetchers import StealthyFetcher, FetcherSession
import json
import time
from datetime import datetime

class JobBoardScraper:
    def __init__(self):
        self.session = FetcherSession(impersonate='chrome')
        self.results = []
        
    def scrape_indeed(self, query, location, pages=5):
        """Scrape Indeed job listings"""
        jobs = []
        base_url = "https://de.indeed.com/jobs"
        
        for page in range(pages):
            params = {
                'q': query,
                'l': location,
                'start': page * 10
            }
            
            try:
                response = self.session.get(base_url, params=params)
                job_cards = response.css('[data-jk]')
                
                for card in job_cards:
                    job_data = {
                        'title': card.css('h2.jobTitle a span::text').get(),
                        'company': card.css('[data-testid="company-name"]::text').get(),
                        'location': card.css('[data-testid="job-location"]::text').get(),
                        'salary': card.css('.metadata .salary::text').get(),
                        'summary': card.css('.summary::text').get(),
                        'link': 'https://de.indeed.com' + card.css('h2.jobTitle a::attr(href)').get(),
                        'date_posted': card.css('.date::text').get(),
                        'source': 'indeed'
                    }
                    jobs.append(job_data)
                
                time.sleep(2)  # Rate limiting
                
            except Exception as e:
                print(f"Error scraping Indeed page {page}: {e}")
                
        return jobs
    
    def scrape_stepstone(self, query, location, pages=3):
        """Scrape StepStone job listings"""
        jobs = []
        base_url = "https://www.stepstone.de/jobs"
        
        for page in range(pages):
            search_url = f"{base_url}/{query.replace(' ', '-')}-in-{location}?page={page+1}"
            
            try:
                response = self.session.get(search_url)
                job_cards = response.css('[data-testid="job-item"]')
                
                for card in job_cards:
                    job_data = {
                        'title': card.css('.job-element-title::text').get(),
                        'company': card.css('.job-element-company::text').get(),
                        'location': card.css('.job-element-location::text').get(),
                        'salary': card.css('.job-element-salary::text').get(),
                        'link': card.css('a::attr(href)').get(),
                        'summary': card.css('.job-element-summary::text').get(),
                        'source': 'stepstone'
                    }
                    jobs.append(job_data)
                
                time.sleep(3)  # Rate limiting
                
            except Exception as e:
                print(f"Error scraping StepStone page {page}: {e}")
                
        return jobs
    
    def scrape_linkedin(self, query, location, pages=3):
        """Scrape LinkedIn job listings (requires careful rate limiting)"""
        jobs = []
        base_url = "https://www.linkedin.com/jobs/search"
        
        for page in range(pages):
            params = {
                'keywords': query,
                'location': location,
                'start': page * 25
            }
            
            try:
                # Use stealthy fetcher for LinkedIn
                response = StealthyFetcher.fetch(base_url, params=params, solve_cloudflare=True)
                job_cards = response.css('[data-entity-urn]')
                
                for card in job_cards:
                    job_data = {
                        'title': card.css('.job-title::text').get(),
                        'company': card.css('.job-company::text').get(),
                        'location': card.css('.job-location::text').get(),
                        'link': card.css('.job-title a::attr(href)').get(),
                        'summary': card.css('.job-summary::text').get(),
                        'source': 'linkedin'
                    }
                    jobs.append(job_data)
                
                time.sleep(5)  # Longer delay for LinkedIn
                
            except Exception as e:
                print(f"Error scraping LinkedIn page {page}: {e}")
                
        return jobs
```

### Multi-Platform Job Aggregation
```python
# Comprehensive job search across multiple platforms
def comprehensive_job_search(query, location, candidate_profile=None):
    scraper = JobBoardScraper()
    all_jobs = []
    
    # German job boards
    job_sources = [
        ('indeed', scraper.scrape_indeed),
        ('stepstone', scraper.scrape_stepstone),
        ('xing', scraper.scrape_xing),
        ('monster', scraper.scrape_monster),
        ('glassdoor', scraper.scrape_glassdoor),
        ('linkedin', scraper.scrape_linkedin)
    ]
    
    for source_name, scrape_function in job_sources:
        try:
            print(f"Scraping {source_name}...")
            jobs = scrape_function(query, location)
            all_jobs.extend(jobs)
            print(f"Found {len(jobs)} jobs from {source_name}")
        except Exception as e:
            print(f"Failed to scrape {source_name}: {e}")
    
    # Remove duplicates
    unique_jobs = remove_duplicates(all_jobs)
    
    # Score and rank jobs if candidate profile provided
    if candidate_profile:
        scored_jobs = score_job_matches(unique_jobs, candidate_profile)
        return sorted(scored_jobs, key=lambda x: x['match_score'], reverse=True)
    
    return unique_jobs

def remove_duplicates(jobs):
    """Remove duplicate job listings based on title and company"""
    seen = set()
    unique_jobs = []
    
    for job in jobs:
        job_key = (job.get('title', '').lower(), job.get('company', '').lower())
        if job_key not in seen and job.get('title'):
            seen.add(job_key)
            unique_jobs.append(job)
    
    return unique_jobs
```

## Intelligent Job Matching

### Candidate Profile Analysis
```python
# Advanced candidate-job matching system
import re
from difflib import SequenceMatcher

class JobMatcher:
    def __init__(self):
        self.skill_synonyms = {
            'kubernetes': ['k8s', 'kubernetes', 'kube'],
            'javascript': ['js', 'javascript', 'node.js', 'nodejs'],
            'python': ['python', 'py', 'django', 'flask'],
            'aws': ['amazon web services', 'aws', 'amazon cloud'],
            'docker': ['docker', 'containerization', 'containers']
        }
        
    def extract_skills_from_text(self, text):
        """Extract skills from job description or CV"""
        if not text:
            return []
            
        text_lower = text.lower()
        found_skills = []
        
        # Common technical skills
        tech_skills = [
            'python', 'java', 'javascript', 'react', 'angular', 'vue',
            'kubernetes', 'docker', 'aws', 'azure', 'gcp',
            'terraform', 'ansible', 'jenkins', 'git', 'linux',
            'mysql', 'postgresql', 'mongodb', 'redis',
            'machine learning', 'ai', 'data science', 'analytics'
        ]
        
        for skill in tech_skills:
            if skill in text_lower:
                found_skills.append(skill)
        
        # Check for skill synonyms
        for canonical_skill, synonyms in self.skill_synonyms.items():
            for synonym in synonyms:
                if synonym in text_lower and canonical_skill not in found_skills:
                    found_skills.append(canonical_skill)
        
        return list(set(found_skills))
    
    def calculate_match_score(self, job, candidate_profile):
        """Calculate job-candidate match score"""
        score = 0
        max_score = 100
        
        # Skill matching (40% of score)
        job_skills = self.extract_skills_from_text(job.get('title', '') + ' ' + job.get('summary', ''))
        candidate_skills = candidate_profile.get('skills', [])
        
        if job_skills and candidate_skills:
            skill_matches = len(set(job_skills) & set(candidate_skills))
            skill_score = min((skill_matches / len(job_skills)) * 40, 40)
            score += skill_score
        
        # Experience level matching (25% of score)
        required_experience = self.extract_experience_level(job.get('summary', ''))
        candidate_experience = candidate_profile.get('experience_years', 0)
        
        if required_experience:
            exp_diff = abs(candidate_experience - required_experience)
            exp_score = max(25 - (exp_diff * 3), 0)
            score += exp_score
        else:
            score += 15  # Default score if experience not specified
        
        # Location preference (15% of score)
        job_location = job.get('location', '').lower()
        preferred_locations = [loc.lower() for loc in candidate_profile.get('preferred_locations', [])]
        
        if any(pref_loc in job_location for pref_loc in preferred_locations):
            score += 15
        elif 'remote' in job_location and 'remote' in preferred_locations:
            score += 15
        
        # Salary match (20% of score)
        job_salary = self.extract_salary_range(job.get('salary', ''))
        desired_salary = candidate_profile.get('desired_salary')
        
        if job_salary and desired_salary:
            salary_min, salary_max = job_salary
            if salary_min <= desired_salary <= salary_max:
                score += 20
            elif desired_salary < salary_min:
                score += 15  # Job pays more than desired
            else:
                score += 5   # Job pays less than desired
        
        return min(score, max_score)
    
    def extract_experience_level(self, job_description):
        """Extract required experience level from job description"""
        if not job_description:
            return None
            
        # Look for experience patterns
        patterns = [
            r'(\d+)[\+\-\s]*year[s]?\s*(?:of\s+)?experience',
            r'(\d+)[\+\-\s]*jahr[e]?\s*(?:berufserfahrung|erfahrung)',
            r'minimum\s+(\d+)\s+years?',
            r'mindestens\s+(\d+)\s+jahre?'
        ]
        
        for pattern in patterns:
            match = re.search(pattern, job_description.lower())
            if match:
                return int(match.group(1))
        
        return None
    
    def extract_salary_range(self, salary_text):
        """Extract salary range from salary text"""
        if not salary_text:
            return None
            
        # Common salary patterns
        patterns = [
            r'€(\d{1,3}(?:,\d{3})*)\s*-\s*€(\d{1,3}(?:,\d{3})*)',
            r'(\d{1,3}(?:,\d{3})*)\s*-\s*(\d{1,3}(?:,\d{3})*)\s*€',
            r'up to €(\d{1,3}(?:,\d{3})*)',
            r'bis zu €(\d{1,3}(?:,\d{3})*)'
        ]
        
        for pattern in patterns:
            match = re.search(pattern, salary_text.replace('.', ','))
            if match:
                if len(match.groups()) == 2:
                    min_sal = int(match.group(1).replace(',', ''))
                    max_sal = int(match.group(2).replace(',', ''))
                    return (min_sal, max_sal)
                else:
                    max_sal = int(match.group(1).replace(',', ''))
                    return (0, max_sal)
        
        return None
```

### Automated Application Tracking
```python
# Application tracking and management system
import sqlite3
from datetime import datetime, timedelta

class ApplicationTracker:
    def __init__(self, db_path="job_applications.db"):
        self.db_path = db_path
        self.init_database()
    
    def init_database(self):
        """Initialize SQLite database for tracking applications"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS applications (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                job_title TEXT NOT NULL,
                company TEXT NOT NULL,
                location TEXT,
                salary TEXT,
                job_url TEXT,
                application_date DATE,
                status TEXT DEFAULT 'planned',
                match_score REAL,
                notes TEXT,
                follow_up_date DATE,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS application_status_log (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                application_id INTEGER,
                old_status TEXT,
                new_status TEXT,
                changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                notes TEXT,
                FOREIGN KEY (application_id) REFERENCES applications (id)
            )
        ''')
        
        conn.commit()
        conn.close()
    
    def add_application(self, job_data, match_score=None, status='planned'):
        """Add new job application to tracking system"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            INSERT INTO applications 
            (job_title, company, location, salary, job_url, application_date, status, match_score)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            job_data.get('title'),
            job_data.get('company'),
            job_data.get('location'),
            job_data.get('salary'),
            job_data.get('link'),
            datetime.now().date(),
            status,
            match_score
        ))
        
        application_id = cursor.lastrowid
        conn.commit()
        conn.close()
        
        return application_id
    
    def update_status(self, application_id, new_status, notes=None):
        """Update application status with logging"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Get current status
        cursor.execute('SELECT status FROM applications WHERE id = ?', (application_id,))
        result = cursor.fetchone()
        if not result:
            conn.close()
            return False
        
        old_status = result[0]
        
        # Update status
        cursor.execute(
            'UPDATE applications SET status = ? WHERE id = ?',
            (new_status, application_id)
        )
        
        # Log status change
        cursor.execute('''
            INSERT INTO application_status_log 
            (application_id, old_status, new_status, notes)
            VALUES (?, ?, ?, ?)
        ''', (application_id, old_status, new_status, notes))
        
        conn.commit()
        conn.close()
        
        return True
    
    def get_applications_summary(self):
        """Get summary of all applications"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            SELECT 
                status,
                COUNT(*) as count,
                AVG(match_score) as avg_match_score
            FROM applications 
            GROUP BY status
        ''')
        
        summary = {}
        for row in cursor.fetchall():
            summary[row[0]] = {
                'count': row[1],
                'avg_match_score': row[2] or 0
            }
        
        conn.close()
        return summary
    
    def get_follow_up_reminders(self, days_ahead=7):
        """Get applications that need follow-up"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cutoff_date = (datetime.now() + timedelta(days=days_ahead)).date()
        
        cursor.execute('''
            SELECT * FROM applications 
            WHERE follow_up_date <= ? 
            AND status IN ('applied', 'interviewing')
            ORDER BY follow_up_date
        ''', (cutoff_date,))
        
        reminders = []
        for row in cursor.fetchall():
            reminders.append({
                'id': row[0],
                'job_title': row[1],
                'company': row[2],
                'status': row[7],
                'follow_up_date': row[9]
            })
        
        conn.close()
        return reminders
```

## Market Analysis and Insights

### Salary Benchmarking
```python
# Advanced salary analysis and benchmarking
class SalaryAnalyzer:
    def __init__(self):
        self.salary_data = []
    
    def analyze_salary_trends(self, jobs_data, location_filter=None, experience_filter=None):
        """Analyze salary trends from job data"""
        filtered_jobs = []
        
        for job in jobs_data:
            if not job.get('salary'):
                continue
                
            if location_filter and location_filter.lower() not in job.get('location', '').lower():
                continue
                
            salary_range = self.extract_salary_range(job.get('salary'))
            if salary_range:
                filtered_jobs.append({
                    'title': job.get('title'),
                    'company': job.get('company'),
                    'location': job.get('location'),
                    'salary_min': salary_range[0],
                    'salary_max': salary_range[1],
                    'salary_avg': (salary_range[0] + salary_range[1]) / 2
                })
        
        if not filtered_jobs:
            return None
        
        # Calculate statistics
        salaries = [job['salary_avg'] for job in filtered_jobs]
        
        analysis = {
            'sample_size': len(filtered_jobs),
            'min_salary': min(salaries),
            'max_salary': max(salaries),
            'median_salary': sorted(salaries)[len(salaries)//2],
            'mean_salary': sum(salaries) / len(salaries),
            'percentiles': {
                '25th': sorted(salaries)[len(salaries)//4],
                '75th': sorted(salaries)[3*len(salaries)//4],
                '90th': sorted(salaries)[9*len(salaries)//10]
            },
            'by_location': self.group_by_location(filtered_jobs),
            'by_company_size': self.analyze_by_company_size(filtered_jobs)
        }
        
        return analysis
    
    def generate_salary_report(self, position, location, experience_years):
        """Generate comprehensive salary report"""
        # Search for salary data
        jobs = comprehensive_job_search(position, location)
        salary_analysis = self.analyze_salary_trends(jobs, location)
        
        if not salary_analysis:
            return "Insufficient salary data found for analysis."
        
        # Generate recommendations
        recommendations = []
        
        median_salary = salary_analysis['median_salary']
        
        if experience_years < 2:
            target_range = (median_salary * 0.7, median_salary * 0.9)
            recommendations.append("As a junior professional, target 70-90% of median salary")
        elif experience_years < 5:
            target_range = (median_salary * 0.9, median_salary * 1.2)
            recommendations.append("With your experience, aim for 90-120% of median salary")
        else:
            target_range = (median_salary * 1.1, median_salary * 1.5)
            recommendations.append("Senior level - target 110-150% of median salary")
        
        report = {
            'position': position,
            'location': location,
            'market_analysis': salary_analysis,
            'recommended_range': target_range,
            'recommendations': recommendations,
            'generated_at': datetime.now().isoformat()
        }
        
        return report
```

### Job Market Intelligence
```python
# Comprehensive job market analysis
class JobMarketIntelligence:
    def __init__(self):
        self.market_data = {}
    
    def analyze_job_market_trends(self, jobs_data, time_period_days=30):
        """Analyze job market trends and patterns"""
        analysis = {
            'total_jobs': len(jobs_data),
            'top_employers': self.get_top_employers(jobs_data),
            'popular_skills': self.get_popular_skills(jobs_data),
            'location_distribution': self.get_location_distribution(jobs_data),
            'remote_opportunities': self.analyze_remote_work(jobs_data),
            'experience_requirements': self.analyze_experience_requirements(jobs_data),
            'salary_insights': self.get_salary_insights(jobs_data),
            'industry_trends': self.analyze_industry_trends(jobs_data)
        }
        
        return analysis
    
    def get_top_employers(self, jobs_data, top_n=10):
        """Get top hiring companies"""
        company_counts = {}
        for job in jobs_data:
            company = job.get('company', 'Unknown')
            company_counts[company] = company_counts.get(company, 0) + 1
        
        return sorted(company_counts.items(), key=lambda x: x[1], reverse=True)[:top_n]
    
    def get_popular_skills(self, jobs_data, top_n=20):
        """Extract and rank most in-demand skills"""
        skill_counts = {}
        matcher = JobMatcher()
        
        for job in jobs_data:
            job_text = (job.get('title', '') + ' ' + job.get('summary', '')).lower()
            skills = matcher.extract_skills_from_text(job_text)
            
            for skill in skills:
                skill_counts[skill] = skill_counts.get(skill, 0) + 1
        
        return sorted(skill_counts.items(), key=lambda x: x[1], reverse=True)[:top_n]
    
    def analyze_remote_work(self, jobs_data):
        """Analyze remote work opportunities"""
        remote_keywords = ['remote', 'home office', 'telecommute', 'work from home', 'hybrid']
        remote_count = 0
        
        for job in jobs_data:
            job_text = (job.get('title', '') + ' ' + job.get('location', '') + ' ' + job.get('summary', '')).lower()
            if any(keyword in job_text for keyword in remote_keywords):
                remote_count += 1
        
        return {
            'remote_jobs': remote_count,
            'remote_percentage': (remote_count / len(jobs_data)) * 100 if jobs_data else 0,
            'onsite_jobs': len(jobs_data) - remote_count
        }
    
    def generate_market_report(self, position, locations, save_to_file=True):
        """Generate comprehensive job market report"""
        all_jobs = []
        
        for location in locations:
            jobs = comprehensive_job_search(position, location)
            all_jobs.extend(jobs)
        
        market_analysis = self.analyze_job_market_trends(all_jobs)
        
        report = {
            'report_metadata': {
                'position': position,
                'locations': locations,
                'generated_at': datetime.now().isoformat(),
                'total_jobs_analyzed': len(all_jobs)
            },
            'market_intelligence': market_analysis,
            'recommendations': self.generate_market_recommendations(market_analysis)
        }
        
        if save_to_file:
            filename = f"job_market_report_{position.replace(' ', '_')}_{datetime.now().strftime('%Y%m%d')}.json"
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump(report, f, indent=2, ensure_ascii=False)
        
        return report
```

This comprehensive HR Job Super Scraper provides advanced job search automation, intelligent matching, application tracking, and market analysis capabilities for modern recruitment needs.