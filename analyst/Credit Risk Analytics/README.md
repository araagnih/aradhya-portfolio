# Credit Risk Analytics: Understanding Customer Defaults with R

Exploring customer behavior and repayment trends using **R** to uncover drivers of **credit card payment defaults**.  
This project applies **credit risk analytics**, **data visualization**, and **customer segmentation** techniques to identify patterns that signal financial distress.

![R](https://img.shields.io/badge/R-4.x-blue?logo=r)
![Python](https://img.shields.io/badge/Python-3.9-yellow?logo=python)
![tidyverse](https://img.shields.io/badge/Data%20Wrangling-tidyverse-teal)
![ggplot2](https://img.shields.io/badge/Visualization-ggplot2-blueviolet)
![dplyr](https://img.shields.io/badge/Data%20Processing-dplyr-yellowgreen)
![corrplot](https://img.shields.io/badge/Correlation-corrplot-orange)
![Credit%20Risk](https://img.shields.io/badge/Domain-Credit%20Risk%20Analytics-red)
![Customer%20Insights](https://img.shields.io/badge/Focus-Customer%20Behavior%20%26%20Repayment-lightblue)
![EDA](https://img.shields.io/badge/Exploratory%20Analysis-brightgreen)

---

## 🧩 Problem Statement

Credit card defaults are one of the most common and costly risks faced by financial institutions.  
This project investigates **how customer demographics, credit limits, and repayment patterns** affect default probability, helping identify high-risk customer segments early.

---

## 📊 Dataset

- **Source:** UCI Machine Learning Repository – *Default of Credit Card Clients*  
- **Records:** 30,000 clients (Taiwan, 2005)  
- **Target:** `df_pay` → 1 = Default, 0 = No Default  
- **Categories:**  
  - **Demographic:** SEX, EDUCATION, MARRIAGE, AGE  
  - **Financial:** LIMIT_BAL, BILL_AMT1–6, PAY_AMT1–6  
  - **Behavioral:** PAY_0–PAY_6 (repayment status for last six months)

---

## ⚙️ Workflow Overview

<img src="visuals/workflow.png" width="850"/>

1. **Data Wrangling (R):** cleaned categorical encodings, grouped anomalies, renamed variables.  
2. **Exploratory Analysis (R):** visualized distributions, repayment trends, and credit relationships.  
3. **Modeling (Python):** logistic regression (balanced) + ROC, confusion matrix, and coefficients.  

---

## 📈 Exploratory Data Analysis

### 1) Customer Demographics
<img src="visuals/06_sex_counts.png" width="420"/> <img src="visuals/04_education_counts.png" width="420"/>

*Majority of clients are female and university-educated — a young professional customer base.*

<img src="visuals/05_marriage_counts.png" width="420"/>

*Married and single clients dominate; marital stability aligns with stronger repayment discipline.*

---

### 2) Default Distribution
<img src="visuals/01_target_distribution.png" width="550"/>

*About 22% of clients defaulted, highlighting a class imbalance typical of real portfolios.*

---

### 3) Credit Limit Patterns
<img src="visuals/02_limit_bal_hist.png" width="420"/> <img src="visuals/09_limit_bal_by_target_box.png" width="420"/>

*Defaulters generally have lower credit limits; higher limits tend to follow clean repayment histories.*

---

### 4) Age Influence
<img src="visuals/03_age_hist.png" width="420"/> <img src="visuals/10_age_by_target_box.png" width="420"/>

*Most clients are 25–40. Older customers default less in absolute terms, though overlap remains high.*

---

### 5) Repayment Behavior Snapshot
<img src="visuals/07_pay0_counts.png" width="550"/>

*On-time status (0) dominates, while 1–2 month delays are early stress signals.*

---

### 6) Correlations
<img src="visuals/08_corr_heatmap.png" width="700"/>

*Bills across months are highly correlated; recent repayment status features align most with default.*

---

### 7) Monthly Bill vs Payment (Portfolio Averages)
<img src="visuals/monthly_avg_bill_vs_payment_bar.png" width="700"/>

*Billed amounts trend down slightly, while payments stay lower — a sign of revolving balances.*

---

### 8) Credit Limit vs Age — Smooth Trends by Education
<img src="visuals/education_age_credit_smooth_labeled.png" width="900"/>

*Credit limits rise with age across groups; graduate/university lines sit above others.*

---

## 🧠 Predictive Modeling (Python)

**Logistic Regression** with `class_weight="balanced"` to handle the 78/22 split.  
Stratified train/test split; evaluation emphasizes recall vs. business cost trade-offs.

### Feature Importance (Coefficients)
<img src="visuals/feature_importance_logreg.png" width="700"/>

*Recent delinquency (PAY_0) is most predictive; higher credit limits dampen risk.*

### ROC Curve
<img src="visuals/roc_curve.png" width="500"/>

*AUC = **0.718** — reasonable ranking power between classes.*

### Confusion Matrix (Threshold = 0.50)
<img src="visuals/confusion_matrix.png" width="420"/>

*Recall for defaulters is prioritized; precision can be improved via threshold tuning.*

---

## 📈 Model Results

| Metric | Value |
|---|---|
| **Accuracy** | ~**67.9%** |
| **Precision** | ~37% |
| **Recall** | ~64% |
| **F1-Score** | ~47% |
| **ROC-AUC** | **0.718** |

---

## 💡 Key Insights

- **Repayment consistency** (PAY_* variables) is the clearest signal of default.  
- **Lower credit limits** and **younger age** correlate with higher risk.  
- Explainable baseline shows how **EDA + simple modeling** provides actionable risk insight.

---

## 🚀 Next Steps

- Ensembles (Gradient Boosting / XGBoost) with calibrated probabilities.  
- Threshold optimization using business costs.  
- Drift & fairness checks by segment; optional R Shiny dashboard.

---

## 📘 Supplementary R Notebook

`Credit_Card_Default_Analysis.Rmd` includes:  
- Data cleaning & recoding  
- All EDA visuals above  
- Notes on feature construction and anomalies
