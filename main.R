# Descriptive Analysis
# Load data
datos <- read.csv("Obesity DataSet.csv", stringsAsFactors = TRUE)

# General summary
summary(datos)

# Separation of variables
numeric_data <- datos[, c("Age", "Height", "Weight", "FCVC", "NCP", "CH2O", "FAF", "TUE")]
categ_data <- datos[, c("Gender", "family_history_with_overweight", "FAVC", "CAEC",
                        "SMOKE", "SCC", "MTRANS", "NObeyesdad")]

# numeric variables summary
num_summary <- data.frame(
  Variable = names(numeric_data),
  Mean = round(sapply(numeric_data, mean, na.rm = TRUE), 4),
  SD = round(sapply(numeric_data, sd, na.rm = TRUE), 4),
  Min = round(sapply(numeric_data, min, na.rm = TRUE), 4),
  Q1 = round(sapply(numeric_data, quantile, 0.25, na.rm = TRUE), 4),
  Median = round(sapply(numeric_data, median, na.rm = TRUE), 4),
  Q3 = round(sapply(numeric_data, quantile, 0.75, na.rm = TRUE), 4),
  Max = round(sapply(numeric_data, max, na.rm = TRUE), 4)
)
print(num_summary)

# Correlation matrix
library(corrplot) # install.packages("corrplot")
cor_matrix <- cor(numeric_data)
corrplot(cor_matrix, method = "color", type = "upper", addCoef.col = "black", tl.col = "black")

par(mfrow = c(2, 2)) # arrange plots in a 2x2 grid

# Distributions

# Gender
barplot(table(categ_data$Gender), col = c("pink", "lightblue"),
        main = "Gender Distribution", ylab = "Count")

# Age
hist(numeric_data$Age, col = "steelblue", border = "white",
     main = "Distribution of Age", xlab = "Age (Years)", ylab = "Count")

# Weight
hist(numeric_data$Weight, col = "coral", border = "white",
     main = "Distribution of Weight", xlab = "Weight (kg)", ylab = "Count")

# Boxplot of height
boxplot(numeric_data$Height, col = "lightgreen",
        main = "Boxplot of Height", ylab = "Height (m)")

par(mfrow = c(2, 2))

# Family history
plot(categ_data$family_history_with_overweight, main="Family History of Overweight",
     col="lightblue", ylab="Frequency")

# High caloric food (FAVC)
plot(categ_data$FAVC, main="Frequent consumption of high caloric food",
     col="salmon", ylab="Frequency")

# Vegetables consumption (FCVC)
hist(numeric_data$FCVC, main="Frequency of consumption of vegetables",
     xlab="Level (1-3)", col="seagreen", breaks=5)

# number of main meals (NCP)
boxplot(numeric_data$NCP, main="Number of main meals (NCP)",
        col="skyblue", ylab="Quantity")

par(mfrow = c(2, 2))

# Daily water consumption (CH2O)
hist(numeric_data$CH2O, breaks = 20, col = "steelblue", border = "white",
     main = "Daily Water Consumption (CH2O)", xlab = "Scale (1-3)", ylab = "Frequency")

# Physical activity frequency (FAF)
hist(numeric_data$FAF, breaks = 20, col = "darkorange", border = "white",
     main = "Physical Activity Frequency (FAF)", xlab = "Scale (0-3)", ylab = "Frequency")

# snacking (CAEC)
barplot(table(categ_data$CAEC), col = "steelblue",
        main = "Food Consumption Between Meals (CAEC)", las = 2)

# Calorie monitoring (SCC)
barplot(table(categ_data$SCC), col = c("tomato", "steelblue"),
        main = "Calorie Monitoring (SCC)")

# -------------------------------------------------------------------------
# Bivariate inference - Association between daily consumption of water and weight

df <- read.csv("ObesityDataSet.csv")
str(df[, c("CH2O", "Weight")])
summary(df$CH2O)
summary(df$Weight)

# Scatterplot
plot(df$CH2O, df$Weight,
     main = "Weight vs Daily Water Consumption",
     xlab = "CH2O",
     ylab = "Weight (kg)",
     pch = 19, col = rgb(0, 0, 1, 0.35))
abline(lm(Weight ~ CH2O, data = df), col = "red", lwd = 2)

# Correlations
pearson_res <- cor.test(df$CH2O, df$Weight, method = "pearson")
spearman_res <- cor.test(df$CH2O, df$Weight, method = "spearman", exact = FALSE)
pearson_res
spearman_res

# -------------------------------------------------------------------------
# Bivariate inference - Association between means of Transport and physical activity

datos <- read.csv(file.choose(), stringsAsFactors = TRUE)

# See SMOKE and SCC information
table(datos$SMOKE)
prop.table(table(datos$SMOKE)) * 100
table(datos$SCC)
prop.table(table(datos$SCC)) * 100

# Boxplot format
par(mar=c(6.5, 4, 3, 1))

# Boxplot
boxplot(FAF ~ MTRANS, data = datos,
        main = "Physical Activity according to Means of Transport",
        xlab = "",
        ylab = "Physical Activity Frequency (FAF)",
        col = c("#4EA8DE", "#56CFE1", "#70E000", "#94D2BD", "#FFB703"),
        cex.axis = 0.82,
        frame.plot = FALSE)

# Q-Q Plot
modelo_norm <- lm(FAF ~ MTRANS, data = datos)
plot(modelo_norm, which = 2, pch = 16, col = "darkblue", main = "Normal Q-Q Plot")

# Kruskal-Wallis
kruskal.test(FAF ~ MTRANS, data = datos)

# Wilcoxon post-hoc
pairwise.wilcox.test(datos$FAF, datos$MTRANS, p.adjust.method = "bonferroni")

# Round variable
datos$FAF_discrete <- round(datos$FAF)
datos$FAF_discrete <- as.factor(datos$FAF_discrete)

# Contingency table
tabla_contingencia <- table(datos$MTRANS, datos$FAF_discrete)
print(tabla_contingencia)

# Chi-squared
chi_res <- chisq.test(tabla_contingencia, correct = FALSE)
print(chi_res)

# To see the expected values
chi_res$expected

# -------------------------------------------------------------------------
# Predictive Analysis - Multiple Linear Regression
# Predictive analysis - predicting weight

datos <- read.csv("ObesityDataSet.csv")

# Train/validation data split (80% / 20%)
set.seed(21)
n_rows <- nrow(datos)
train_indices <- sample(1:n_rows, size = 0.8 * n_rows)
train_data <- datos[train_indices, ]
test_data <- datos[-train_indices, ]

# Train the linear regression model
model_of_weight <- lm(Weight ~ . - NObeyesdad - SMOKE - SCC, data = train_data)

# Model summary and multicollinearity check
summary(model_of_weight)
library(car)

print("VIF Values:")
vif(model_of_weight)

# Make predictions on test data
predictions <- predict(model_of_weight, newdata = test_data)

# Calculate prediction errors (RMSE and MAE)
errors <- test_data$Weight - predictions
rmse <- sqrt(mean(errors^2))
mae <- mean(abs(errors))

cat("RMSE:", round(rmse, 2), "kg\n")
cat("MAE:", round(mae, 2), "kg\n")

# Confidence intervals and residual diagnostics
confint(model_of_weight)

par(mfrow = c(1, 1))
plot(model_of_weight, which = 2, col = "skyblue", pch = 16,
     main = "Normal Q-Q Plot of the Residuals")