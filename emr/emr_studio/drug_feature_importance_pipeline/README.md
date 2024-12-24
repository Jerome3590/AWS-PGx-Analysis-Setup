
## Workflow Pipeline for Analyzing Drug Features As Key Drivers of Hospitalizations

## Overview
This project implements a machine learning workflow using the **CatBoost** algorithm in combination with **Apache Spark**. 
The workflow includes preprocessing steps, feature importance analysis, and interaction analysis to derive insights from 
All Payers Claim Database (APCD). Below is a detailed explanation for each step in the pipeline supported by Jupyter notebooks.

---

## Workflow Steps

### **1. Initial Data Preprocessing**
#### **1.1 Age Cohort Creation**
The dataset is segmented into **9 age cohorts** based on the following age ranges:
- 0–12
- 13–24
- 25–44
- 45–54
- 55–64
- 65–74
- 75–84
- 85–94
- 95–114

This segmentation ensures that age-related patterns can be effectively captured during model training.

#### **1.2 Drug Name Standardization**
Drug names in the dataset are standardized and consolidated to ensure consistency. This step involves:
- Removing duplicates or variations of the same drug name.
- Normalizing drug names (e.g., case formatting, removing special characters).

This preprocessing step is critical for reducing noise and improving model accuracy.

---

### **2. Feature Importance Model**
The first model is trained using the preprocessed data to determine the **initial feature importance**. The steps include:
- Training a CatBoost model on the dataset.
- Extracting feature importance scores for all features.

These scores help identify which features contribute most to the predictive power of the model.

---

### **3. Dataset Filtering and Model Refinement**
Using the feature importance scores from Step 2:
1. Filter the dataset to retain only the most important features (based on a predefined threshold).
2. Retrain a new CatBoost model using this reduced feature set.

This step ensures that only relevant features are included, improving model efficiency and interpretability.

---

### **4. Training and Test Feature Importances**
From the refined model:
- Extract feature importance scores for both training and test datasets.
- Compare these scores to validate that important features remain consistent across datasets.

This ensures that the model generalizes well and avoids overfitting.

---

### **5. Feature Interaction Analysis**
Using the refined CatBoost model:
1. Analyze **feature importance interactions** to identify how pairs of features interact with each other.
2. Use this information to uncover deeper insights into relationships between features and their combined impact on predictions.

CatBoost's built-in tools for interaction analysis are leveraged in this step.

---

### **6. Plotting Partial Dependency**
#### **6.1 Partial Dependency Plots**
Generate **Partial Dependency Plots (PDPs)** to visualize how individual features impact model predictions.

#### **6.2 Partial Dependency Interaction Plots**
Generate **Partial Dependency Interaction Plots** to visualize how interactions between two features influence predictions.

---

## Requirements

To run this workflow, you will need:
- **Apache Spark**: For distributed data processing.
- **CatBoost**: For machine learning modeling.
- Python libraries:
  - `pyspark`
  - `catboost`
  - `pandas`
  - `numpy`

Ensure that your environment is properly configured with these dependencies before proceeding.

---

## Instructions

1. **Preprocess Data**:
   - Segment data into age cohorts.
   - Standardize drug names.

2. **Train Initial Feature Importance Model**:
   - Train a CatBoost model on preprocessed data.
   - Extract initial feature importance scores.

3. **Filter Dataset and Refit Model**:
   - Retain only important features based on initial scores.
   - Train a new CatBoost model using filtered data.

4. **Extract Feature Importances**:
   - Get feature importance scores for both training and test datasets from the refined model.

5. **Analyze Feature Interactions**:
   - Use CatBoost's interaction analysis tools to evaluate feature pair interactions.

6. **Visualize Dependencies**:
   - Plot PDPs and interaction plots to understand feature behavior and interactions.

---

## Output

The workflow will produce:
1. A list of initial feature importance scores.
2. A reduced dataset containing only important features.
3. Training and test feature importance scores from the refined model.
4. Feature interaction analysis results.
5. Partial Dependency and Interaction Plots.

---

## Notes
- Ensure proper handling of missing values during preprocessing.
- Hyperparameter tuning may be required for optimal CatBoost performance.
- Use Spark's distributed capabilities for large datasets to improve processing efficiency.

---

## References
For more details on CatBoost and its functionality, refer to its official documentation.

