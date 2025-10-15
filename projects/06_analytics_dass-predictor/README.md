# Depression, Anxiety & Stress Predictor  

This project uses the **DASS-42 survey dataset (~40K responses)** to predict mental health severity levels (Normal → Extremely Severe) based on personality traits and demographics.  

![Python](https://img.shields.io/badge/Python-3.9-blue?logo=python) 
![Pandas](https://img.shields.io/badge/Data%20Analysis-Pandas-yellowgreen) 
![Scikit-learn](https://img.shields.io/badge/Machine%20Learning-Scikit--learn-orange) 
![Matplotlib](https://img.shields.io/badge/Visualization-Matplotlib-blueviolet) 
![Seaborn](https://img.shields.io/badge/Visualization-Seaborn-lightblue) 
![Jupyter](https://img.shields.io/badge/Environment-Jupyter-orange?logo=jupyter) 
![EDA](https://img.shields.io/badge/EDA-brightgreen) 
![Feature Engineering](https://img.shields.io/badge/Feature%20Engineering-yellow) 
![PCA](https://img.shields.io/badge/PCA-important) 
![Cross Validation](https://img.shields.io/badge/Cross%20Validation-blue) 
![Model Evaluation](https://img.shields.io/badge/Model%20Evaluation-red) 
![Models](https://img.shields.io/badge/Models-LogReg%20%7C%20RF%20%7C%20KNN%20%7C%20DT-lightgrey)



---

## 🧩 Problem Statement  
Mental health conditions such as depression, anxiety, and stress impact quality of life and productivity. Using survey data, we built predictive models to classify individuals into severity categories, aiming to demonstrate how data-driven approaches can support early detection.  

---

## 📊 Dataset  
- **Source**: DASS-42 Survey (Depression, Anxiety and Stress Scales).  
- **Responses**: ~40,000 participants.  
- **Format**: Likert scale (1 = Did not apply, 4 = Applied most of the time).  
- **Features**: Personality questions (TIPI), demographics (age, gender, education, religion, urbanicity).  
- **Target**: Depression severity (Normal, Mild, Moderate, Severe, Extremely Severe).
   
### ⚠️ Dataset Access
The original dataset is not included in this repository.  
You can download the DASS-42 dataset or use your own survey data.  
Update the file path in `df_dass = pd.read_csv("path/to/DASS_data.csv", sep="\t", engine="python")` before running.

---

## ⚙️ Approach  
1. **Data Preprocessing**  
   - Null value checks, outlier removal.  
   - Variable selection, normalization, feature encoding.  

2. **Exploratory Data Analysis (EDA)**  
   - Age & gender distributions.  
   - Correlations (e.g., TIPI4 = anxious → higher depression; TIPI9 = calm → lower depression).  
   - Demographic insights (religion, marital status).  

3. **Models Tested**  
   - Logistic Regression  
   - Random Forest  
   - Decision Tree  
   - K-Nearest Neighbors (KNN)  

4. **Dimensionality Reduction**  
   - PCA applied (26 → 15 features).  
   - Improved accuracy for most models except Logistic Regression.  

---

## 📈 Results  

| Model                | Accuracy | Precision | Recall | F1   |  
|----------------------|----------|-----------|--------|------|  
| **Logistic Regression** | **90.8%** | 90.7%    | 90.8%  | 90.6% |  
| Random Forest        | 88.3%    | 88.1%    | 88.3%  | 88.1% |  
| KNN                  | 82.2%    | 81.3%    | 82.3%  | 80.9% |  
| Decision Tree        | 77.0%    | 78.7%    | 78.6%  | 78.7% |  

- Logistic Regression performed the best, despite being the simplest model.  
- PCA improved Random Forest and KNN performance.  

---

## 🎨 Visuals  

**Pipeline (ML Workflow)**  
Step-by-step pipeline from dataset to results.  
<img src="visuals/pipeline_diagram.png" alt="ML pipeline" width="1400">

---

**Model Accuracy Comparison**  
Logistic Regression performed the best (90.8%), followed by Random Forest.  
<img src="visuals/model_accuracy.png" alt="Model accuracy comparison" width="600">

---

**PCA Cumulative Variance Explained**  
15 components retained ~60% variance, balancing efficiency and accuracy.  
<img src="visuals/pca_variance.png" alt="PCA cumulative variance" width="600">

---

**Focused Correlation (Personality vs Depression)**  
- TIPI4 (Anxious) strongly positive with Depression.  
- TIPI9 (Calm) strongly negative with Depression.  
<img src="visuals/correlation_tipivsdepression.png" alt="TIPI vs Depression correlation" width="600">

---

**Expanded Correlation Matrix (Selected Features)**  
- Depression, Anxiety, and Stress are highly correlated.  
- Personality traits (TIPI4, TIPI9) are stronger predictors than Age.  
<img src="visuals/_correlation_matrix.png" alt="Correlation matrix" width="700">


---

## 💡 Key Insights  
- Personality traits strongly influence depression severity (TIPI4 = anxious, TIPI9 = calm).  
- Younger and urban populations reported higher depression levels.  
- Married participants generally had lower depression scores.  
- Logistic Regression provided the most reliable classification.  

---

## 🚀 Next Steps  
- Extend modeling to Anxiety and Stress severity classification.  
- Explore deep learning models for larger-scale datasets.  
- Apply results to design targeted mental health interventions.  

