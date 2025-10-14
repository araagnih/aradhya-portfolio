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

**Pipeline (ML Workflow): End-to-end workflow from dataset to results**  
 

<img src="visuals/_pipeline_diagram.png" alt="ML pipeline" width="1200">


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

**Confusion Matrix**  
The model correctly classified **159 out of 171 patients**, with only 6 false positives and 6 false negatives. Errors were balanced, giving ~94% across precision, recall, and F1.   
<img src="visuals/02_confusion_matrix.png" alt="Confusion Matrix" width="400">

---

**ROC Curve**  
An **AUC of 0.95** demonstrates excellent ability to separate benign from malignant tumors in this dataset. The sharp curve indicates few false alarms at high sensitivity, important for medical screening.  
<img src="visuals/03_roc.png" alt="ROC curve" width="500">

---


**Calibration Curve**  
Predicted probabilities closely matched actual outcomes (points near diagonal), showing the model is not just accurate, but also **well-calibrated** for probability-based decision-making.  
<img src="visuals/10_calibration.png" width="400"></p>  

---

**Precision-Recall vs Threshold**  
The model maintained both high precision and recall above 90% across a wide range of thresholds, meaning predictions are reliable even if the cutoff probability is adjusted.   
<img src="visuals/09_pr_threshold.png" alt="PR vs threshold" width="600">

---

**Calibration Curve**  
Predicted probabilities closely matched actual outcomes (points near diagonal), showing the model is not just accurate, but also **well-calibrated** for probability-based decision-making.   
<img src="visuals/10_calibration.png" alt="Calibration curve" width="500">


---

## 🎨 Visuals  

**Correlation Heatmap (All Features)**  
Many of the 30 features are highly correlated (e.g., *mean radius, mean perimeter, mean area*). This confirmed the need for dimensionality reduction and feature selection to avoid redundancy.  
<img src="visuals/01_corr_full.png" alt="Full correlation heatmap" width="700">

---

**Correlation Heatmap (Selected Features)**  
After RFECV, the three strongest predictors emerged: *worst radius, worst concave points, worst texture*. The focused heatmap shows they are less correlated with each other, justifying their selection.
<img src="visuals/01_corr_subset.png" alt="Subset correlation heatmap" width="600">

---


**Permutation Feature Importance**  
On the test set, *worst concave points* and *worst radius* caused the largest drops in accuracy when permuted, proving they are essential to classification.   
<img src="visuals/04_perm_importance.png" alt="Permutation Importance" width="600">

---

**SHAP Beeswarm (Global)**  
For individual patients, high values of *worst radius* and *worst concave points* consistently pushed predictions toward malignancy, while lower values pushed toward benign.   
<img src="visuals/05_shap_beeswarm.png" alt="SHAP Beeswarm" width="700">

---

**SHAP Mean |Impact| (Bar)**  
Across the test set, *worst radius* contributed the most to the model’s decision process, reinforcing what we saw in permutation importance. 
<img src="visuals/06_shap_bar.png" alt="SHAP bar chart" width="600">

---

**SHAP Dependence Plot**  
Higher *worst radius* values strongly increased malignancy prediction, especially when paired with high *worst texture*. This reveals an interaction between tumor size and texture.  
<img src="visuals/07_shap_dependence.png" alt="SHAP dependence" width="600">

---

**Partial Dependence & ICE (PDP + ICE)**  
When *worst concave points* exceeded ~0.5, predictions shifted sharply toward malignancy for most patients, confirming this threshold as clinically meaningful.  
<img src="visuals/08_pdp_ice.png" alt="PDP + ICE plots" width="800">

---

**LIME Explanation (Local)**  
For a specific test patient, LIME showed that *worst concave points > 0.57* was the decisive feature driving the prediction of malignancy, a transparent case-level justification.  
<img src="visuals/09_lime_example.png" alt="LIME local explanation" width="500">

---

**Boxplots (EDA)**  
Malignant tumors consistently had higher values for *worst concave points* and *worst radius*, while benign cases had lower, tighter distributions. This aligns with model explanations from SHAP and LIME.  
<img src="visuals/eda_worst_concave_points_boxplot.png" alt="Boxplot concave points" width="400">  
<img src="visuals/eda_worst_radius_boxplot.png" alt="Boxplot worst radius" width="400">  
<img src="visuals/eda_worst_texture_boxplot.png" alt="Boxplot worst texture" width="400">

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

