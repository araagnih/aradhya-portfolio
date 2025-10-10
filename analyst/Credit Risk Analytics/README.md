# Credit Risk Analytics: Understanding Customer Defaults with R  

Exploring customer behavior and repayment trends using **R** to uncover drivers of **credit card payment defaults**.  
This project applies **credit risk analytics**, **data visualization**, and **customer segmentation** techniques to identify patterns that signal financial distress.

![R](https://img.shields.io/badge/R-4.x-blue?logo=r)
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

<img src="visuals/workflow_diagram.png" width="850"/>

1. **Data Wrangling:** cleaned categorical encodings, grouped anomalies, renamed variables for clarity.  
2. **Exploratory Analysis:** visualized distributions, repayment trends, and credit relationships.  
3. **Insight Generation:** interpreted behavioral and demographic factors that drive repayment reliability.  

---

## 📈 Exploratory Data Analysis  

### **1. Customer Demographics**

<img src="visuals/06_sex_counts.png" width="420"/> <img src="visuals/04_education_counts.png" width="420"/>

*Majority of clients are female and university-educated — a young professional customer base.*

<img src="visuals/05_marriage_counts.png" width="420"/>

*Married and single clients dominate; marital stability aligns with stronger repayment discipline.*

---

### **2. Default Distribution**

<img src="visuals/01_target_distribution.png" width="550"/>

*Roughly 22 % of clients defaulted, highlighting a class imbalance that mirrors real credit portfolios.*

---

### **3. Credit Limit Patterns**

<img src="visuals/02_limit_bal_hist.png" width="420"/> <img src="visuals/09_limit_bal_by_target_box.png" width="420"/>

*Defaulters generally have lower credit limits, indicating lenders reward repayment consistency with higher credit capacity.*

---

### **4. Age Influence on Default**

<img src="visuals/03_age_hist.png" width="420"/> <img src="visuals/10_age_by_target_box.png" width="420"/>

*Most clients are aged 25–40. Older customers default less often in absolute terms but show higher relative risk within their group.*

---

### **5. Education and Default Behavior**

<img src="visuals/education_default_bar.png" width="600"/>

*University graduates represent the largest share of defaulters, reflecting their dominance in the dataset rather than educational risk.*

---

### **6. Gender and Limit Balance**

<img src="visuals/limit_by_gender_violin.png" width="600"/>

*Females hold slightly higher credit limits on average, consistent with better repayment discipline observed in the data.*

---

### **7. Repayment Behavior**

<img src="visuals/07_pay0_counts.png" width="550"/>

*Most clients pay on time (status 0), but late payments of 1–2 months are early signals of financial strain.*

---

### **8. Correlation Matrix**

<img src="visuals/08_corr_heatmap.png" width="700"/>

*Bill and payment amounts are highly correlated; repayment status variables (PAY_0–PAY_6) show the strongest link with default probability.*

---

### **9. Monthly Bill vs Payment Trend**

<img src="visuals/monthly_bill_vs_payment.png" width="700"/>

*Average billing amounts decrease slightly over months, while payments remain consistently lower, suggesting reliance on revolving credit.*

---

### **10. Bills and Payments: Defaulters vs Non-Defaulters**

<img src="visuals/variation_bills_payments_defaulters.png" width="700"/>

*Non-defaulters consistently pay larger portions of their bills; defaulters maintain smaller payments relative to total balance.*

---

### **11. Education × Age Heatmap**

<img src="visuals/education_age_credit_heatmap.png" width="700"/>

*Clients with graduate education in middle-to-senior age groups enjoy higher credit limits. This is likely due to income maturity and tenure.*

---

## 📊 Summary of Findings  

| Factor | Observation | Implication |
|:-------|:-------------|:-------------|
| **Repayment History** | Strongest predictor of default behavior | Early delinquency signals future risk |
| **Credit Limit** | Lower among defaulters | Reflects trust and repayment history |
| **Age** | Middle-aged clients maintain best repayment records | Suggests income stability advantage |
| **Marital Status** | Married clients default less | Indicates potential correlation with financial stability |
| **Bill vs Payment Ratio** | High unpaid ratios correlate with defaults | Metric useful for credit monitoring dashboards |

---

## 💡 Key Insights  

- **Behavioral indicators** (repayment delay, bill–payment ratio) outweigh demographic ones.  
- **Timely payments** correlate with both higher credit limits and long-term customer retention.  
- **Combining credit limits, payment timeliness, and age** forms a reliable risk-profiling framework.  
- Insights can support **proactive limit adjustments** and **personalized credit interventions**.

---

## 🚀 Next Steps  

- Extend the analysis into a **predictive risk model** (e.g., logistic regression or random forest).  
- Incorporate **temporal trends** (rolling 3-month repayment metrics).  
- Build an **interactive R Shiny dashboard** for real-time monitoring.  
- Validate findings using **external or recent credit datasets**.

---

## 📘 Supplementary R Notebook  

A detailed R Markdown file (`Credit_Card_Default_Analysis.Rmd`) is available in the `/R` folder.  
It includes:  
- Full cleaning pipeline and categorical decoding  
- Code for every visualization  
- Extended exploration of **monthly bill-payment behavior** and **education-wise patterns**



