library(dplyr)
library(ggplot2)
library(caret)
library(car)
library(pROC)
library(corrplot)

data("starwars")

starwars <- starwars %>% 
  filter(!is.na(height), !is.na(mass), !is.na(birth_year))

head(starwars)
sum(is.na(starwars))
summary(starwars)

boxplot(starwars$height)

numeric_sw <- starwars %>% select(where(is.numeric))
cor_sw <- cor(numeric_sw)
corrplot(cor_sw, method = "circle")

simple_model <- lm(height ~ mass, data = starwars)
summary(simple_model)

multiple_model <- lm(height ~ mass * birth_year, data = starwars)
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
  height ~ mass * birth_year,
  data = starwars,
  method = "lm",
  trControl = train_control
)
print(cv_model)

starwars$height_class <- ifelse(starwars$height >= median(starwars$height), 1, 0)

logistic_model <- glm(height_class ~ mass * birth_year,
                      data = starwars,
                      family = "binomial")
summary(logistic_model)

pred_probs <- predict(logistic_model, type = "response")
roc_curve <- roc(starwars$height_class, pred_probs)

plot(roc_curve, col = "blue")
abline(a = 0, b = 1, lty = 2, col = "red")
cat("AUC:", auc(roc_curve), "\n")
