---
name: analysis-super-agent
description: Advanced data analysis and insights expert. Handles statistical analysis, pattern recognition, data visualization, predictive modeling, and business intelligence. Use for complex analytical tasks, data interpretation, trend analysis, and decision-support analytics.
version: "1.0.0"  
metadata:
  openclaw:
    emoji: "📊"
    triggers: ["analyze", "analysis", "data analysis", "statistics", "trends", "insights", "patterns", "business intelligence"]
---

# Analysis Super Agent - Advanced Analytics Intelligence

Master complex data analysis with statistical modeling, pattern recognition, predictive analytics, and business intelligence capabilities.

## Core Analysis Framework

### Analytical Process Pipeline
```
1. DATA UNDERSTANDING
   ├── Data source identification
   ├── Data quality assessment  
   ├── Variable classification
   └── Missing data analysis

2. EXPLORATORY ANALYSIS
   ├── Descriptive statistics
   ├── Distribution analysis
   ├── Correlation analysis
   └── Outlier detection

3. ADVANCED ANALYTICS
   ├── Statistical modeling
   ├── Pattern recognition
   ├── Predictive modeling
   └── Causal analysis

4. INSIGHT GENERATION
   ├── Result interpretation
   ├── Business context mapping
   ├── Recommendation development
   └── Action plan creation

5. VISUALIZATION & REPORTING
   ├── Chart and graph creation
   ├── Dashboard development
   ├── Executive summaries
   └── Technical documentation
```

## Statistical Analysis Capabilities

### Descriptive Statistics
```python
# Comprehensive descriptive analysis
import pandas as pd
import numpy as np
from scipy import stats

def comprehensive_descriptive_analysis(data):
    analysis = {}
    
    for column in data.select_dtypes(include=[np.number]).columns:
        analysis[column] = {
            # Central tendencies
            'mean': data[column].mean(),
            'median': data[column].median(),
            'mode': data[column].mode().iloc[0] if len(data[column].mode()) > 0 else np.nan,
            
            # Variability measures
            'std': data[column].std(),
            'variance': data[column].var(),
            'range': data[column].max() - data[column].min(),
            'iqr': data[column].quantile(0.75) - data[column].quantile(0.25),
            
            # Distribution shape
            'skewness': stats.skew(data[column].dropna()),
            'kurtosis': stats.kurtosis(data[column].dropna()),
            
            # Percentiles
            'percentiles': {
                '25th': data[column].quantile(0.25),
                '50th': data[column].quantile(0.50),
                '75th': data[column].quantile(0.75),
                '90th': data[column].quantile(0.90),
                '95th': data[column].quantile(0.95)
            },
            
            # Quality metrics
            'missing_count': data[column].isnull().sum(),
            'missing_percentage': (data[column].isnull().sum() / len(data)) * 100,
            'unique_values': data[column].nunique(),
            'zero_count': (data[column] == 0).sum()
        }
    
    return analysis
```

### Inferential Statistics
```python
# Statistical testing framework
from scipy.stats import ttest_ind, chi2_contingency, pearsonr, spearmanr

def statistical_testing_suite(data, target_var, test_vars):
    results = {}
    
    for var in test_vars:
        if data[var].dtype in ['int64', 'float64']:
            # Correlation analysis
            pearson_r, pearson_p = pearsonr(data[var].dropna(), data[target_var].dropna())
            spearman_r, spearman_p = spearmanr(data[var].dropna(), data[target_var].dropna())
            
            results[var] = {
                'test_type': 'correlation',
                'pearson_correlation': pearson_r,
                'pearson_p_value': pearson_p,
                'spearman_correlation': spearman_r,
                'spearman_p_value': spearman_p,
                'significance': 'significant' if min(pearson_p, spearman_p) < 0.05 else 'not_significant'
            }
            
        else:
            # Chi-square test for categorical variables
            contingency_table = pd.crosstab(data[var], data[target_var])
            chi2, p_value, dof, expected = chi2_contingency(contingency_table)
            
            results[var] = {
                'test_type': 'chi_square',
                'chi2_statistic': chi2,
                'p_value': p_value,
                'degrees_of_freedom': dof,
                'significance': 'significant' if p_value < 0.05 else 'not_significant'
            }
    
    return results
```

## Pattern Recognition and Machine Learning

### Clustering Analysis
```python
# Advanced clustering techniques
from sklearn.cluster import KMeans, DBSCAN, AgglomerativeClustering
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import silhouette_score

def perform_clustering_analysis(data, methods=['kmeans', 'dbscan', 'hierarchical']):
    results = {}
    
    # Standardize the data
    scaler = StandardScaler()
    scaled_data = scaler.fit_transform(data)
    
    if 'kmeans' in methods:
        # K-means clustering with optimal k selection
        silhouette_scores = []
        k_range = range(2, 11)
        
        for k in k_range:
            kmeans = KMeans(n_clusters=k, random_state=42)
            cluster_labels = kmeans.fit_predict(scaled_data)
            silhouette_avg = silhouette_score(scaled_data, cluster_labels)
            silhouette_scores.append(silhouette_avg)
        
        optimal_k = k_range[np.argmax(silhouette_scores)]
        
        # Final k-means with optimal k
        kmeans_final = KMeans(n_clusters=optimal_k, random_state=42)
        kmeans_labels = kmeans_final.fit_predict(scaled_data)
        
        results['kmeans'] = {
            'optimal_k': optimal_k,
            'labels': kmeans_labels,
            'silhouette_score': max(silhouette_scores),
            'cluster_centers': kmeans_final.cluster_centers_
        }
    
    if 'dbscan' in methods:
        # DBSCAN clustering
        dbscan = DBSCAN(eps=0.5, min_samples=5)
        dbscan_labels = dbscan.fit_predict(scaled_data)
        
        results['dbscan'] = {
            'labels': dbscan_labels,
            'n_clusters': len(set(dbscan_labels)) - (1 if -1 in dbscan_labels else 0),
            'n_noise_points': list(dbscan_labels).count(-1)
        }
    
    if 'hierarchical' in methods:
        # Hierarchical clustering
        hierarchical = AgglomerativeClustering(n_clusters=optimal_k if 'kmeans' in methods else 3)
        hierarchical_labels = hierarchical.fit_predict(scaled_data)
        
        results['hierarchical'] = {
            'labels': hierarchical_labels,
            'n_clusters': hierarchical.n_clusters_
        }
    
    return results
```

### Time Series Analysis
```python
# Time series analysis framework
import pandas as pd
from statsmodels.tsa.seasonal import seasonal_decompose
from statsmodels.tsa.arima.model import ARIMA
from statsmodels.tsa.stattools import adfuller

def time_series_analysis(data, date_col, value_col):
    # Prepare time series data
    ts_data = data.set_index(pd.to_datetime(data[date_col]))[value_col]
    ts_data = ts_data.sort_index()
    
    analysis = {}
    
    # Basic time series statistics
    analysis['basic_stats'] = {
        'start_date': ts_data.index.min(),
        'end_date': ts_data.index.max(),
        'frequency': pd.infer_freq(ts_data.index),
        'observations': len(ts_data),
        'missing_values': ts_data.isnull().sum()
    }
    
    # Stationarity test
    adf_result = adfuller(ts_data.dropna())
    analysis['stationarity'] = {
        'adf_statistic': adf_result[0],
        'p_value': adf_result[1],
        'is_stationary': adf_result[1] < 0.05
    }
    
    # Seasonal decomposition
    if len(ts_data) >= 24:  # Need sufficient data points
        decomposition = seasonal_decompose(ts_data, model='additive', period=12)
        analysis['decomposition'] = {
            'trend': decomposition.trend,
            'seasonal': decomposition.seasonal,
            'residual': decomposition.resid
        }
    
    # Trend analysis
    analysis['trend_analysis'] = {
        'overall_trend': 'increasing' if ts_data.iloc[-1] > ts_data.iloc[0] else 'decreasing',
        'volatility': ts_data.std(),
        'coefficient_of_variation': ts_data.std() / ts_data.mean()
    }
    
    return analysis
```

## Business Intelligence and KPI Analysis

### KPI Monitoring Framework
```python
# KPI analysis and monitoring system
def kpi_analysis(data, kpi_definitions):
    kpi_results = {}
    
    for kpi_name, kpi_config in kpi_definitions.items():
        metric_value = calculate_metric(data, kpi_config['formula'])
        
        kpi_results[kpi_name] = {
            'current_value': metric_value,
            'target_value': kpi_config.get('target'),
            'performance': calculate_performance(metric_value, kpi_config.get('target')),
            'trend': calculate_trend(data, kpi_config['formula']),
            'status': determine_status(metric_value, kpi_config),
            'insights': generate_kpi_insights(metric_value, kpi_config, data)
        }
    
    return kpi_results

def calculate_performance(current, target):
    if target and target != 0:
        return ((current - target) / target) * 100
    return None

def determine_status(value, config):
    if 'thresholds' in config:
        if value >= config['thresholds'].get('excellent', float('inf')):
            return 'excellent'
        elif value >= config['thresholds'].get('good', float('inf')):
            return 'good' 
        elif value >= config['thresholds'].get('warning', float('-inf')):
            return 'warning'
        else:
            return 'critical'
    return 'undefined'
```

### Cohort Analysis
```python
# Customer cohort analysis
def cohort_analysis(data, customer_id_col, date_col, value_col):
    # Prepare cohort data
    data['period'] = pd.to_datetime(data[date_col]).dt.to_period('M')
    data['cohort_group'] = data.groupby(customer_id_col)[date_col].transform('min').dt.to_period('M')
    
    # Calculate period number
    data['period_number'] = (data['period'] - data['cohort_group']).apply(attrgetter('n'))
    
    # Create cohort table
    cohort_data = data.groupby(['cohort_group', 'period_number'])[customer_id_col].nunique().reset_index()
    cohort_counts = cohort_data.pivot(index='cohort_group', columns='period_number', values=customer_id_col)
    
    # Calculate cohort sizes
    cohort_sizes = data.groupby('cohort_group')[customer_id_col].nunique()
    
    # Calculate retention rates
    retention_table = cohort_counts.divide(cohort_sizes, axis=0)
    
    return {
        'cohort_counts': cohort_counts,
        'cohort_sizes': cohort_sizes,
        'retention_rates': retention_table,
        'avg_retention_by_period': retention_table.mean()
    }
```

## Predictive Analytics

### Forecasting Models
```python
# Multi-model forecasting approach
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error

def build_forecasting_models(data, target_var, feature_vars, test_size=0.2):
    from sklearn.model_selection import train_test_split
    
    # Prepare data
    X = data[feature_vars]
    y = data[target_var]
    
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=test_size, random_state=42)
    
    models = {}
    
    # Linear Regression
    lr_model = LinearRegression()
    lr_model.fit(X_train, y_train)
    lr_pred = lr_model.predict(X_test)
    
    models['linear_regression'] = {
        'model': lr_model,
        'predictions': lr_pred,
        'mae': mean_absolute_error(y_test, lr_pred),
        'rmse': np.sqrt(mean_squared_error(y_test, lr_pred)),
        'feature_importance': dict(zip(feature_vars, lr_model.coef_))
    }
    
    # Random Forest
    rf_model = RandomForestRegressor(n_estimators=100, random_state=42)
    rf_model.fit(X_train, y_train)
    rf_pred = rf_model.predict(X_test)
    
    models['random_forest'] = {
        'model': rf_model,
        'predictions': rf_pred,
        'mae': mean_absolute_error(y_test, rf_pred),
        'rmse': np.sqrt(mean_squared_error(y_test, rf_pred)),
        'feature_importance': dict(zip(feature_vars, rf_model.feature_importances_))
    }
    
    # Model comparison
    best_model = min(models.keys(), key=lambda k: models[k]['rmse'])
    
    return {
        'models': models,
        'best_model': best_model,
        'test_data': {'X_test': X_test, 'y_test': y_test}
    }
```

## Data Visualization and Reporting

### Advanced Visualization Templates
```python
# Comprehensive visualization suite
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
import plotly.graph_objects as go

def create_analysis_dashboard(data, analysis_results):
    visualizations = {}
    
    # Distribution plots
    fig, axes = plt.subplots(2, 2, figsize=(15, 10))
    
    # Histogram with normal distribution overlay
    numeric_cols = data.select_dtypes(include=[np.number]).columns[:4]
    for i, col in enumerate(numeric_cols):
        ax = axes[i//2, i%2]
        ax.hist(data[col].dropna(), bins=30, alpha=0.7, density=True)
        ax.set_title(f'Distribution of {col}')
        ax.set_xlabel(col)
        ax.set_ylabel('Density')
    
    plt.tight_layout()
    visualizations['distributions'] = fig
    
    # Correlation heatmap
    correlation_matrix = data.corr()
    fig_corr = plt.figure(figsize=(12, 8))
    sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', center=0)
    plt.title('Correlation Matrix')
    visualizations['correlation'] = fig_corr
    
    # Time series plots if applicable
    if 'time_series' in analysis_results:
        fig_ts = go.Figure()
        fig_ts.add_trace(go.Scatter(y=analysis_results['time_series']['data'], mode='lines', name='Actual'))
        fig_ts.update_layout(title='Time Series Analysis', xaxis_title='Time', yaxis_title='Value')
        visualizations['time_series'] = fig_ts
    
    return visualizations
```

### Executive Report Generation
```python
# Automated report generation
def generate_executive_report(analysis_results):
    report = {
        'executive_summary': {},
        'key_findings': [],
        'recommendations': [],
        'technical_details': {}
    }
    
    # Executive summary
    report['executive_summary'] = {
        'data_points_analyzed': len(analysis_results.get('data', [])),
        'key_metrics_count': len(analysis_results.get('kpis', {})),
        'significant_patterns': count_significant_patterns(analysis_results),
        'confidence_level': calculate_overall_confidence(analysis_results)
    }
    
    # Key findings extraction
    findings = extract_key_findings(analysis_results)
    report['key_findings'] = findings
    
    # Generate recommendations
    recommendations = generate_recommendations(analysis_results, findings)
    report['recommendations'] = recommendations
    
    return report

def extract_key_findings(results):
    findings = []
    
    # Statistical significance findings
    if 'statistical_tests' in results:
        significant_tests = [k for k, v in results['statistical_tests'].items() 
                           if v.get('significance') == 'significant']
        if significant_tests:
            findings.append(f"Statistically significant relationships found with: {', '.join(significant_tests)}")
    
    # Trend findings
    if 'trends' in results:
        for trend_name, trend_data in results['trends'].items():
            if trend_data.get('strength', 0) > 0.7:
                findings.append(f"Strong {trend_data['direction']} trend identified in {trend_name}")
    
    # Outlier findings
    if 'outliers' in results:
        outlier_count = sum(len(outliers) for outliers in results['outliers'].values())
        if outlier_count > 0:
            findings.append(f"Identified {outlier_count} data points requiring attention")
    
    return findings
```

## Advanced Analytics Applications

### Customer Segmentation Analysis
```python
# RFM Analysis for customer segmentation
def rfm_analysis(data, customer_id, date_col, monetary_col):
    import datetime as dt
    
    # Calculate RFM metrics
    now = dt.datetime.now()
    
    rfm = data.groupby(customer_id).agg({
        date_col: lambda x: (now - x.max()).days,  # Recency
        monetary_col: ['count', 'sum']  # Frequency and Monetary
    }).round(2)
    
    rfm.columns = ['Recency', 'Frequency', 'Monetary']
    
    # Create RFM scores
    rfm['R_Score'] = pd.qcut(rfm['Recency'].rank(method='first'), 5, labels=[5,4,3,2,1])
    rfm['F_Score'] = pd.qcut(rfm['Frequency'].rank(method='first'), 5, labels=[1,2,3,4,5])
    rfm['M_Score'] = pd.qcut(rfm['Monetary'].rank(method='first'), 5, labels=[1,2,3,4,5])
    
    # Combine scores
    rfm['RFM_Score'] = rfm['R_Score'].astype(str) + rfm['F_Score'].astype(str) + rfm['M_Score'].astype(str)
    
    # Segment customers
    def segment_customers(row):
        if row['RFM_Score'] in ['555', '554', '544', '545', '454', '455', '445']:
            return 'Champions'
        elif row['RFM_Score'] in ['543', '444', '435', '355', '354', '345', '344', '335']:
            return 'Loyal Customers'
        elif row['RFM_Score'] in ['553', '551', '552', '541', '542', '533', '532', '531', '452', '451']:
            return 'Potential Loyalists'
        elif row['RFM_Score'] in ['512', '511', '422', '421', '412', '411', '311']:
            return 'New Customers'
        elif row['RFM_Score'] in ['155', '154', '144', '214', '215', '115', '114']:
            return 'At Risk'
        else:
            return 'Others'
    
    rfm['Segment'] = rfm.apply(segment_customers, axis=1)
    
    return rfm
```

### A/B Test Analysis
```python
# Statistical A/B test analysis
from scipy.stats import chi2_contingency, ttest_ind

def ab_test_analysis(control_data, treatment_data, metric_col, test_type='ttest'):
    results = {}
    
    if test_type == 'ttest':
        # T-test for continuous metrics
        t_stat, p_value = ttest_ind(control_data[metric_col], treatment_data[metric_col])
        
        results = {
            'test_type': 't-test',
            'control_mean': control_data[metric_col].mean(),
            'treatment_mean': treatment_data[metric_col].mean(),
            'control_std': control_data[metric_col].std(),
            'treatment_std': treatment_data[metric_col].std(),
            't_statistic': t_stat,
            'p_value': p_value,
            'significant': p_value < 0.05,
            'effect_size': (treatment_data[metric_col].mean() - control_data[metric_col].mean()) / control_data[metric_col].std(),
            'confidence_interval': calculate_confidence_interval(control_data[metric_col], treatment_data[metric_col])
        }
    
    elif test_type == 'chi2':
        # Chi-square test for categorical metrics
        contingency_table = pd.crosstab(
            pd.concat([control_data['group'], treatment_data['group']]),
            pd.concat([control_data[metric_col], treatment_data[metric_col]])
        )
        
        chi2, p_value, dof, expected = chi2_contingency(contingency_table)
        
        results = {
            'test_type': 'chi-square',
            'chi2_statistic': chi2,
            'p_value': p_value,
            'degrees_of_freedom': dof,
            'significant': p_value < 0.05,
            'contingency_table': contingency_table
        }
    
    return results
```

This comprehensive Analysis Super Agent provides advanced analytical capabilities across statistical analysis, machine learning, business intelligence, and predictive analytics domains.