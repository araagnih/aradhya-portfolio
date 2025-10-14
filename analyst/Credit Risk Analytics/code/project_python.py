#Logistic Regression on the UCI "Default of Credit Card Clients" dataset
#setup and imports
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import (
    roc_auc_score, roc_curve, confusion_matrix, precision_recall_fscore_support, accuracy_score
)

#loading all data
CSV_PATH = "default of credit card clients_clean.csv"
XLS_PATH = "default of credit card clients.xls"

if os.path.exists(CSV_PATH):
    df = pd.read_csv(CSV_PATH)
elif os.path.exists(XLS_PATH):
    df = pd.read_excel(XLS_PATH, header=0)
else:
    raise FileNotFoundError(
        "Couldn't find either:\n"
        " - default of credit card clients_clean.csv\n"
        " - default of credit card clients.xls\n"
        "Place one of these files next to this script and rerun."
    )


if df.columns.tolist()[0] == 0 or str(df.columns.tolist()[0]).startswith("Unnamed"): #in case first row is also included/read as data 
    #assuming row 0 has real names
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)


if "ID" in df.columns:
    df.drop(columns=["ID"], inplace=True) #ID is not taken as a feature

#matching all column names to R script
rename_map = {
    "PAY_0": "repayment_status_september",
    "PAY_2": "repayment_status_august",
    "PAY_3": "repayment_status_july",
    "PAY_4": "repayment_status_june",
    "PAY_5": "repayment_status_may",
    "PAY_6": "repayment_status_april",
    "BILL_AMT1": "bill_september",
    "BILL_AMT2": "bill_august",
    "BILL_AMT3": "bill_july",
    "BILL_AMT4": "bill_june",
    "BILL_AMT5": "bill_may",
    "BILL_AMT6": "bill_april",
    "PAY_AMT1": "payment_september",
    "PAY_AMT2": "payment_august",
    "PAY_AMT3": "payment_july",
    "PAY_AMT4": "payment_june",
    "PAY_AMT5": "payment_may",
    "PAY_AMT6": "payment_april",
    "default payment next month": "df_pay",
}
df.rename(columns={c: rename_map.get(c, c) for c in df.columns}, inplace=True)


needed = [
    "SEX","EDUCATION","MARRIAGE","AGE","LIMIT_BAL","df_pay",
    "repayment_status_september","repayment_status_august","repayment_status_july",
    "repayment_status_june","repayment_status_may","repayment_status_april",
    "bill_september","bill_august","bill_july","bill_june","bill_may","bill_april",
    "payment_september","payment_august","payment_july","payment_june","payment_may","payment_april"
]
missing = [c for c in needed if c not in df.columns]
if missing:
    print("Warning: some expected columns were not found (continuing if they’re truly absent):", missing)

#data cleaning

#SEX: 1= male, 2= female
if df["SEX"].dtype != "O":
    df["SEX"] = df["SEX"].replace({1: "male", 2: "female"}).astype("category")

#MARRIAGE: 1=married, 2=single, 3=others
df["MARRIAGE"] = df["MARRIAGE"].replace({1: "married", 2: "single", 3: "others", 0: "others"}).astype("category")

#EDUCATION: allowed 1,2,3,4; map {0,5,6}->4 ("others");then decode labels
if df["EDUCATION"].dtype != "O":
    df["EDUCATION"] = df["EDUCATION"].replace({0: 4, 5: 4, 6: 4})
    df["EDUCATION"] = df["EDUCATION"].map({1: "graduate school", 2: "university", 3: "high school", 4: "others"}).astype("category")
else:
    
    df["EDUCATION"] = df["EDUCATION"].astype("category")


repay_cols = [
    "repayment_status_september","repayment_status_august","repayment_status_july",
    "repayment_status_june","repayment_status_may","repayment_status_april"
]
for c in repay_cols:
    if c in df.columns:
        df[c] = pd.to_numeric(df[c], errors="coerce").fillna(0)
        df[c] = df[c].replace({-2: 0, -1: 0})


numeric_cols = [
    "LIMIT_BAL","AGE",
    "bill_september","bill_august","bill_july","bill_june","bill_may","bill_april",
    "payment_september","payment_august","payment_july","payment_june","payment_may","payment_april",
] + repay_cols
for c in numeric_cols:
    if c in df.columns:
        df[c] = pd.to_numeric(df[c], errors="coerce")

#target (as int 0/1)
df["df_pay"] = pd.to_numeric(df["df_pay"], errors="coerce").fillna(0).astype(int)

#dropping any rows that still have NA
feature_cols = [c for c in numeric_cols if c in df.columns] + ["SEX","EDUCATION","MARRIAGE"]
use_cols = [c for c in feature_cols if c in df.columns] + ["df_pay"]
df = df.dropna(subset=use_cols).copy()

#train/test split

X = df[[c for c in feature_cols if c in df.columns]].copy()
y = df["df_pay"].copy()

cat_cols = [c for c in ["SEX","EDUCATION","MARRIAGE"] if c in X.columns]
num_cols = [c for c in X.columns if c not in cat_cols]

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.25, random_state=42, stratify=y
)


preprocess = ColumnTransformer(
    transformers=[
        ("num", StandardScaler(with_mean=True, with_std=True), num_cols),
        ("cat", OneHotEncoder(drop="first", handle_unknown="ignore", sparse_output=False), cat_cols),
    ],
    remainder="drop",
)

log_reg = LogisticRegression(
    max_iter=200,
    class_weight="balanced",
    solver="liblinear",
    n_jobs=None
)

pipe = Pipeline(steps=[("prep", preprocess), ("clf", log_reg)])
pipe.fit(X_train, y_train)


#Evaluation
proba_test = pipe.predict_proba(X_test)[:, 1]
pred_test = (proba_test >= 0.50).astype(int)

auc = roc_auc_score(y_test, proba_test)
acc = accuracy_score(y_test, pred_test)
prec, rec, f1, _ = precision_recall_fscore_support(y_test, pred_test, average="binary", zero_division=0)

print(f"AUC: {auc:.3f} | Accuracy: {acc:.3f} | Precision: {prec:.3f} | Recall: {rec:.3f} | F1: {f1:.3f}")


#Confusion Matrix
cm = confusion_matrix(y_test, pred_test)
fig, ax = plt.subplots(figsize=(6, 5))
im = ax.imshow(cm, cmap="Blues")
for (i, j), v in np.ndenumerate(cm):
    ax.text(j, i, f"{v}", ha="center", va="center", color="#0b2e4f", fontsize=14, fontweight="bold")
ax.set_xticks([0, 1]); ax.set_yticks([0, 1])
ax.set_xticklabels(["Non-Default", "Default"]); ax.set_yticklabels(["Non-Default", "Default"])
ax.set_xlabel("Predicted label"); ax.set_ylabel("True label")
ax.set_title("Confusion Matrix (Threshold = 0.5)")
plt.tight_layout()
plt.savefig("confusion_matrix.png", dpi=200)
plt.close(fig)

#ROC Curve
fpr, tpr, _ = roc_curve(y_test, proba_test)
fig, ax = plt.subplots(figsize=(6, 6))
ax.plot(fpr, tpr, linewidth=2.5, label=f"AUC = {auc:.3f}")
ax.plot([0, 1], [0, 1], linestyle="--", color="gray", linewidth=1)
ax.set_xlabel("False Positive Rate"); ax.set_ylabel("True Positive Rate")
ax.set_title("ROC Curve — Logistic Regression")
ax.legend(loc="lower right", frameon=True)
plt.tight_layout()
plt.savefig("roc_curve.png", dpi=200)
plt.close(fig)

#feature Importance
#feature names after preprocessing
ohe: OneHotEncoder = pipe.named_steps["prep"].named_transformers_["cat"]
cat_feature_names = []
if len(cat_cols) > 0:
    ohe_feature_names = ohe.get_feature_names_out(cat_cols).tolist()
    cat_feature_names = ohe_feature_names

all_feature_names = num_cols + cat_feature_names

coefs = pipe.named_steps["clf"].coef_.ravel()
coef_df = pd.DataFrame({"feature": all_feature_names, "coef": coefs})
#take top 15 for a clean chart
coef_df["abs"] = coef_df["coef"].abs()
coef_top = coef_df.sort_values("abs", ascending=False).head(15).sort_values("coef")

fig, ax = plt.subplots(figsize=(9, 6))
ax.barh(coef_top["feature"], coef_top["coef"], height=0.55, color="#0fa3b1")
ax.axvline(0, color="black", linewidth=1)
ax.set_xlabel("Coefficient Value")
ax.set_title("Feature Importance — Logistic Regression (Top 15)")
plt.tight_layout()
plt.savefig("feature_importance_logreg.png", dpi=200)
plt.close(fig)


#metric table for README
print("\n=== Test Metrics (Threshold = 0.50) ===")
print(pd.DataFrame({
    "Metric": ["Accuracy", "Precision", "Recall", "F1", "ROC-AUC"],
    "Value": [acc, prec, rec, f1, auc]
}).to_string(index=False))


