# Breast Cancer Classification with Explainable AI  

This project applies **machine learning and explainable AI (XAI)** to the **Wisconsin Diagnostic Breast Cancer dataset** to classify tumors as **benign (1)** or **malignant (0)**.  
The focus is not only on achieving strong performance but also on ensuring **interpretability and trustworthiness** — key requirements for healthcare applications.  

![Python](https://img.shields.io/badge/Python-3.9-blue?logo=python) ![Scikit-learn](https://img.shields.io/badge/Machine%20Learning-Scikit--learn-orange) ![Imbalanced-learn](https://img.shields.io/badge/Oversampling-SMOTE-red) ![SHAP](https://img.shields.io/badge/Explainability-SHAP-green) ![LIME](https://img.shields.io/badge/Explainability-LIME-lightblue) ![Matplotlib](https://img.shields.io/badge/Visualization-Matplotlib-blueviolet) ![Seaborn](https://img.shields.io/badge/Visualization-Seaborn-lightblue) ![EDA](https://img.shields.io/badge/EDA-brightgreen) ![RFECV](https://img.shields.io/badge/Feature%20Selection-RFECV-yellow) ![GridSearchCV](https://img.shields.io/badge/GridSearchCV-important) ![Calibration](https://img.shields.io/badge/Model%20Calibration-blue)


---

## 🧩 Problem Statement  
Breast cancer is one of the most common cancers worldwide.  
Machine learning can assist in **early detection**, but models must be both **accurate** and **explainable** to be clinically useful.  

This project builds an **interpretable Decision Tree model** optimized for **F1 score** using **feature selection (RFECV)** and **class imbalance handling (SMOTE)**.  
We also integrate explainability tools (Permutation Importance, SHAP, PDP, LIME) and probability calibration to ensure trust in predictions.  

---

## 📊 Dataset  
- **Source**: Built-in `sklearn.datasets.load_breast_cancer`  
- **Samples**: 569 tumors  
- **Features**: 30 numeric features (e.g., mean radius, worst texture, concavity error)  
- **Target**:  
  - `0` = Malignant  
  - `1` = Benign  

### Class Balance
The dataset is **imbalanced**:  
- ~63% Benign  
- ~37% Malignant  
→ Handled via **SMOTE oversampling inside cross-validation**.  

<p align="center"><img src="visuals/00_class_distribution.png" width="550"></p>  

---

## ⚙️ Approach  

**Pipeline (ML Workflow)**  
End-to-end workflow from dataset to results.  

<img src="visuals/pipeline_diagram.png" alt="ML pipeline" width="1200">


1. **Data Preprocessing**  
   - Scaling via MinMaxScaler  
   - Stratified train/test split  

2. **Exploratory Data Analysis (EDA)**  
   - Correlation heatmaps (full + subset)  
   - Feature distribution plots (boxplots for top features)  

3. **Feature Selection**  
   - RFECV (DecisionTree, 10-fold CV, scoring=F1)  
   - Selected 3 features: `worst radius`, `worst texture`, `worst concave points`  

4. **Modeling**  
   - Pipeline: `SMOTE → DecisionTree`  
   - Hyperparameter tuning with **GridSearchCV (10-fold, F1)**  

5. **Evaluation**  
   - Classification report (Acc, Precision, Recall, F1, ROC-AUC)  
   - Confusion Matrix  
   - ROC Curve  
   - Precision–Recall vs Threshold  
   - Calibration Curve  

6. **Explainability**  
   - **Permutation Importance**  
   - **SHAP (beeswarm, bar, dependence plots)**  
   - **Partial Dependence + ICE**  
   - **LIME** for local case explanations  

---

## 📈 Results  

| Metric      | Value (~) |
|-------------|-----------|
| Accuracy    | 92.98%    |
| Precision   | 94.39%    |
| Recall      | 94%       |
| F1 Score    | 94%       |
| ROC-AUC     | 95.04%    |

**Confusion Matrix & ROC**
<p align="center">
  <img src="visuals/02_confusion_matrix.png" width="530">
  <img src="visuals/03_roc.png" width="560">
</p>

**Precision–Recall vs Threshold**  
<p align="center"><img src="visuals/09_pr_threshold.png" width="500"></p>  

**Calibration Curve**  
<p align="center"><img src="visuals/10_calibration.png" width="400"></p>  

---

## 🎨 Visuals  

**Correlation Heatmaps**
<p align="center">
  <img src="visuals/01_corr_full.png" width="800">
  <img src="visuals/01_corr_subset.png" width="800">
</p>

**Top Feature Distributions**
<p align="center">
  <img src="visuals/eda_worst_concave_points_boxplot.png" width="460">
  <img src="visuals/eda_worst_radius_boxplot.png" width="460">
  <img src="visuals/eda_worst_texture_boxplot.png" width="460">
</p>

**Permutation Importance**
<p align="center"><img src="visuals/04_perm_importance.png" width="650"></p>

**SHAP (Global + Local)**  
<p align="center">
  <img src="visuals/05_shap_beeswarm.png" width="600">
  <img src="visuals/06_shap_bar.png" width="600">
</p>
<p align="center"><img src="visuals/07_shap_dependence.png" width="650"></p>

**PDP + ICE**
<p align="center"><img src="visuals/08_pdp_ice.png" width="850"></p>

**LIME (Single Prediction Explanation)**
<p align="center"><img src="visuals/09_lime_example.png" width="600"></p>  

---

## 💡 Key Insights  
- Only **3 features** were needed for strong performance (`worst radius`, `worst texture`, `worst concave points`).  
- The model achieved **ROC-AUC ~0.95** with balanced precision/recall.  
- **Consistent importance across methods**: permutation, SHAP, PDP all confirmed the same top features.  
- **Interpretability tools (SHAP, LIME, PDP)** provide transparency into predictions.  
- **Threshold and calibration analysis** make the model more aligned with real-world healthcare workflows.  

---

## 🚀 Next Steps  
- Extend pipeline to **Random Forest / Gradient Boosting** and compare explainability.  
- Explore **probability calibration methods** (Platt scaling, isotonic regression).  
- Develop a **cost-sensitive thresholding strategy** for healthcare contexts.  
- Wrap pipeline into a **deployable API or app** for end-to-end demo.  

---

## ⚖️ Disclaimer  
This project is for **educational and portfolio purposes only**.  
Not intended for direct clinical use.  

---

