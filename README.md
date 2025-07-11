# ⚽ FIFA Player Stats Analysis Using Machine Learning

This project explores the application of regression and classification models to analyze FIFA player statistics and predict players’ overall ratings. The dataset comprises various physical, technical, and demographic attributes, enabling a comprehensive assessment of key performance drivers in professional football.

---

## 🧱 Project Milestones

### 📊 Milestone 1: Exploratory Data Analysis (EDA)

- **Objective:** Understand the data structure and initial patterns in FIFA player attributes.
- **Tasks Completed:**
  - Imported and cleaned the FIFA dataset from Kaggle.
  - Removed irrelevant columns (e.g., ID, Photo, and other text-based metadata).
  - Handled missing values and converted currency features (e.g., converting Wage and Value to numeric).
  - Conducted univariate analysis using bar charts and histograms.
  - Generated correlation matrices and heatmaps to identify important predictors of `Overall` rating.
  - Visualized position-wise average ratings and top-rated players.

---

### 🧠 Milestone 2: Regression Modeling and Diagnostics

- **Objective:** Build a regression model to predict a player’s `Overall` rating based on key features.
- **Tasks Completed:**
  - Selected relevant numeric features including:
    - `Age`, `Potential`, `Wage`, `Value`, `SprintSpeed`, `BallControl`, `Vision`, etc.
  - Applied multiple linear regression using `lm()` in R.
  - Performed model diagnostics:
    - Residual vs Fitted plots
    - Q-Q plot for normality
    - Variance Inflation Factor (VIF) to detect multicollinearity
  - Evaluated metrics: Adjusted R², RMSE, and residual analysis.

---

### 🧪 Final Report: Classification Modeling and Results

- **Objective:** Categorize players into “Low”, “Mid”, or “High” based on Overall rating.
- **Tasks Completed:**
  - Created a new categorical variable (`RatingClass`) using quantiles:
    - `Low` (Below 65), `Mid` (65–80), `High` (Above 80)
  - Applied Logistic Regression and Decision Tree Classifier.
  - Visualized decision boundaries and tree splits.
  - Evaluated performance using:
    - Confusion matrix
    - Accuracy and class-wise precision
    - ROC curve and AUC score

- **Key Insights:**
  - `Potential`, `Wage`, and `BallControl` were significant predictors for both regression and classification.
  - High multicollinearity observed between `Value` and `Wage`.
  - Tree models provided interpretable rules to classify player tiers.

- **Challenges:**
  - Data imbalance in class labels (`High` players being rare).
  - Collinearity between technical skills.
  - Text features and categorical data (like positions) were excluded due to modeling limitations.

---

## 📌 Summary of Findings

- Players with high `Potential` and `BallControl` typically receive higher overall ratings.
- Wages and Market Value are inflated for attacking players and those with strong pace and dribbling.
- Regression models explained around **82% variance** in player rating.
- Classification model achieved **91% accuracy** on test data with Decision Tree.
---

## 🎯 Future Work

- Incorporate categorical variables (like preferred foot, club, nationality) using dummy encoding.
- Use Random Forest and XGBoost for improved classification.
- Apply clustering to identify player archetypes.
- Deploy the model using Shiny app or Flask to allow real-time predictions.

---

## 🧠 Author
**Mohammed Saif Wasay**  
*Data Analytics Graduate — Northeastern University*  
*Machine Learning Enthusiast | Passionate about turning data into insights*  

🔗 [Connect with me on LinkedIn](https://www.linkedin.com/in/mohammed-saif-wasay-4b3b64199/)
