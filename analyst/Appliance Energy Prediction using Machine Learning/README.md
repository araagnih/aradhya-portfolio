# Appliance Energy Prediction using Machine Learning  

Predicting household energy consumption using regression and neural network models for smarter energy management.  

![Python](https://img.shields.io/badge/Python-3.9-blue?logo=python)
![Pandas](https://img.shields.io/badge/Data%20Analysis-Pandas-yellowgreen)
![Scikit-learn](https://img.shields.io/badge/Machine%20Learning-Scikit--learn-orange)
![Matplotlib](https://img.shields.io/badge/Visualization-Matplotlib-blueviolet)
![EDA](https://img.shields.io/badge/EDA-brightgreen)
![Feature Engineering](https://img.shields.io/badge/Feature%20Engineering-yellow)
![PCA](https://img.shields.io/badge/PCA-important)
![Model Evaluation](https://img.shields.io/badge/Model%20Evaluation-red)
![Neural Network](https://img.shields.io/badge/Model-Neural%20Network-lightblue)

---

## 🧩 Problem Statement  
Growing energy demands make it essential to understand and optimize household power usage.  
This project builds predictive models to estimate **appliance energy consumption** using indoor climate data, humidity, temperature, and external conditions.  
By accurately forecasting energy usage, such models can help design **smarter energy management systems** that reduce waste and improve efficiency.

---

## 📊 Dataset  
- **Source**: [UCI Machine Learning Repository – Appliances Energy Prediction Dataset](https://archive.ics.uci.edu/ml/datasets/Appliances+energy+prediction)  
- **Records**: 19,735 instances (each representing 10-minute intervals over 4.5 months)  
- **Attributes**: 29 (temperature, humidity, weather, and time-based variables)  
- **Target**: `Appliances`: household energy use (Wh)  

---

## ⚙️ Approach  

### **Workflow Overview**
<img src="visuals/workflow.png" width="900"/>

1. **Data Preprocessing**  
   - Checked for null values (none found)  
   - Outlier detection using DBSCAN and LOF  
   - Log normalization of skewed target variable  

2. **Exploratory Data Analysis (EDA)**  
   - Identified energy consumption patterns across time and day  
   - Analyzed correlations among temperature and humidity features  

3. **Feature Engineering**  
   - Recursive Feature Elimination (RFE) for top predictors  
   - PCA to reduce 27 features → 9 components (capturing 95 % variance)  

4. **Modeling**  
   - Regression: Linear, Ridge, Lasso  
   - Neural Network: 2 hidden layers (ReLU), Dropout 0.2  
   - Compared before/after PCA for performance changes  

5. **Evaluation**  
   - Metrics: R² Score, Bias–Variance Trade-off  
   - Cross-validated models to ensure reliability  

---

## 🎨 Visuals  



### **Exploratory Data Analysis**

**Target Variable Distribution**
<img src="visuals/histogram_target.png" width="600"/>
*Energy consumption is right-skewed, with most readings under 100 Wh.*

**Log Transformation Effect**
<img src="visuals/before_after_log_transform.png" width="600"/>
*Log normalization reduced skewness and stabilized variance.*

**Outlier Detection**
<img src="visuals/dbscan_outlier_plot.png" width="600"/>
*DBSCAN identified high-usage spikes retained as valid surges.*

**Local Outlier Factor (LOF)**
<img src="visuals/local_outlier_box_plot.png" width="600"/>
*LOF confirmed outliers behaved similarly to regular points.*

**Target Variable Boxplot**
<img src="visuals/boxplot_target.png" width="600"/>
*High-end outliers correspond to genuine consumption peaks.*

**Correlation Matrix**
<img src="visuals/correlation_plot.png" width="700"/>
*Temperature (T1–T9) and Humidity (RH1–RH9) groups show strong intra-correlation.*

**Consumption by Day & Hour**
<img src="visuals/mean_energy_by_weekday.png" width="600"/>
*Weekends (Fri–Sun) record higher usage than weekdays.*

<img src="visuals/mean_energy_by_hour.png" width="600"/>
*Energy peaks around 7 PM — matching evening household activity.*

---

### **Feature Engineering**

**Top 20 Features Selected via RFE**
<img src="visuals/rfe_top20_features_v2.png" width="700"/>
*Top 5 predictors (gold) had strongest influence on appliance energy.*

**PCA Variance Curve**
<img src="visuals/pca_variance_curve_v2.png" width="700"/>
*9 components capture 95 % of total variance.*

**Before vs After PCA**
<img src="visuals/before_after_pca_grid_v2.png" width="800"/>
*Dimensionality reduced from 27 → 9 principal components.*

---

### **Modeling and Results**

**Model Performance (R²)**
<img src="visuals/model_comparison_r2.png" width="600"/>
*Neural Network achieved highest R² before PCA.*

**PCA Effect on Models**
<img src="visuals/pca_effect_models.png" width="650"/>
*LASSO improved most after PCA, showing reduced overfitting.*

**Neural Network Architecture**
<img src="visuals/nn_architecture.png" width="800"/>
*Two hidden layers (ReLU) + Dropout (0.2) prevented overfitting.*

---

## 📈 Results  

| Model | R² (Before PCA) | R² (After PCA) | Observation |
|:------|:----------------:|:---------------:|:-------------|
| **Linear Regression** | 0.82 | 0.84 | Small gain after PCA |
| **Ridge Regression**  | 0.85 | 0.87 | Regularization stabilized predictions |
| **Lasso Regression**  | 0.83 | **0.89** | Best among regressors after PCA |
| **Neural Network**    | **0.90** | 0.86 | Best overall before PCA |

---

## 💡 Key Insights  

<img src="visuals/findings_summary_tiles.png" width="700"/>

- **Lasso Regression** → Best model after PCA (simpler, more generalizable)  
- **Neural Network** → Best before PCA (highest accuracy on raw features)  
- **PCA** → Reduced dimensionality (27 → 9) while retaining 95 % variance  
- Weekends and evenings show peak energy consumption  
- Strong correlations among indoor climate variables indicate redundancy handled well by PCA  

---

## 🚀 Next Steps  

- Extend models to forecast energy usage as a **time-series problem** (ARIMA, LSTM)  
- Integrate external weather feeds for real-time prediction  
- Build interactive dashboards for smart home energy insight  
- Explore classification of usage patterns (low/medium/high consumption)  


