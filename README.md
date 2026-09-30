# Obesity-CVD-Risk-Statistical-Predictor

Statistical analysis and multiple linear regression model in R predicting CVD risk and weight
## Objectives
The main objective of this study is to examine how demographic variables and lifestyle factors are associated with body weight, and to evaluate whether weight can be accurately predicted through a multiple linear regression model.

---

## Key Findings & Results
- **Predictive Modeling:** Built a multiple linear regression model that explains 58.5% of the variance in people's weight (Adjusted R² = 0.5852) with a Mean Absolute Error (MAE) of 13.57 kg.
- **Dietary & Lifestyle Impact:** Identified that frequent consumption of high-calorie food (FAVC) and food between meals (CAEC) are statistically significant predictors of weight.
- **Transportation & Activity:** Confirmed through Kruskal-Wallis and Wilcoxon post-hoc tests that the type of transportation used (MTRANS) is significantly associated with physical activity frequency (FAF).
- **Family History:** Found a statistically significant positive correlation between a family history of overweight and higher BMI.

---

## Dataset
**Source:** [Obesity or CVD Risk – Kaggle](https://www.kaggle.com/datasets/aravindpcoder/obesity-or-cvd-risk-classifyregressorcluster)

The dataset contains information on individuals' lifestyle habits, physical characteristics, and eating behaviours, aimed at predicting obesity levels and cardiovascular disease (CVD) risk. It includes over 2,000 records with a mix of numerical and categorical variables.

### Key Variables
| Variable | Type | Description |
|---|---|---|
| `Age`, `Height`, `Weight` | Numeric | Physical measurements and demographic data |
| `FCVC`, `NCP`, `CH2O` | Numeric | Dietary habits (vegetables, meals, water intake) |
| `FAF`, `TUE` | Numeric | Physical activity and technology usage time |
| `FAVC`, `CAEC`, `CALC` | Categorical | Consumption habits (high caloric, snacking, alcohol) |
| `MTRANS` | Categorical | Transportation used |
| `family_history_with_overweight` | Categorical | Family history |

---

## Research Questions
1. Is there a statistically significant difference in BMI between individuals with and without a family history of overweight?
2. Does physical activity frequency (FAF) have a significant linear relationship with weight?
3. Are dietary habits (FAVC, CAEC) associated with obesity level?
4. Can we predict an individual's weight from lifestyle and demographic variables using multiple linear regression?

---

## Repository Structure
- `analysis.R`: R script containing all data processing, descriptive analysis, bivariate inference tests (Chi-squared, Kruskal-Wallis, Pearson/Spearman), and the multiple linear regression model.
- `Final_Report.pdf`: Comprehensive academic report detailing the statistical methodologies, visualizations, and in-depth conclusions.

---

## Software
All statistical analysis and modeling were performed in **R**.

---

## Context & Team
Collaborative project developed by a team of 4 undergraduate students as part of the Statistics course for the **Artificial Intelligence Bachelor's Degree** at **Universitat Politècnica de Catalunya (UPC)**.

*My main contributions:*
