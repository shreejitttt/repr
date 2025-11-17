library(MASS)
library(ggplot2)
library(caret)
library(car)
library(pROC)
library(dplyr)
library(corrplot)

data("Boston")
head(Boston)

sum(is.na(Boston))
summary(Boston)

boxplot(Boston$medv)
Boston <- Boston %>% filter(medv < 50)

cor_matrix <- cor(Boston)
corrplot(cor_matrix, method = "circle")

simple_model <- lm(medv ~ lstat, data = Boston)
summary(simple_model)

multiple_model <- lm(medv ~ lstat * rm, data = Boston)
summary(multiple_model)

adjusted_R2 <- summary(multiple_model)$adj.r.squared
AIC_value <- AIC(multiple_model)
BIC_value <- BIC(multiple_model)

cat("Adjusted R^2:", adjusted_R2, "\n")
cat("AIC:", AIC_value, "\n")
cat("BIC:", BIC_value, "\n")

plot(multiple_model, which = 1)
plot(multiple_model, which = 2)

set.seed(123)
train_control <- trainControl(method = "cv", number = 10)
cv_model <- train(
  medv ~ lstat * rm,
  data = Boston,
  method = "lm",
  trControl = train_control
)
print(cv_model)

Boston$medv_class <- ifelse(Boston$medv >= 25, 1, 0)

logistic_model <- glm(medv_class ~ lstat * rm,
                      data = Boston,
                      family = "binomial")
summary(logistic_model)

pred_probs <- predict(logistic_model, type = "response")
roc_curve <- roc(Boston$medv_class, pred_probs)

plot(roc_curve, col = "blue")
abline(a = 0, b = 1, lty = 2, col = "red")
cat("AUC:", auc(roc_curve), "\n")
