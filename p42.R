library(tidyverse)
library(dplyr)
library(caret)
library(ggcorrplot)

data <- read.csv("C:/Users/kalya/Music/Tutorial Workshop Amulya/adult/adult.data",
                 header = FALSE)

colnames(data) <- c("age","workclass","fnlwgt","education","education_num",
                    "marital_status","occupation","relationship","race","sex",
                    "capital_gain","capital_loss","hours_per_week","native_country",
                    "income")

data[data == "?"] <- NA

replace_mode <- function(x) {
  mode_value <- names(sort(table(x), decreasing = TRUE))[1]
  x[is.na(x)] <- mode_value
  return(x)
}

data <- data %>% mutate_if(is.character, replace_mode)
data <- data %>% mutate_if(is.numeric, ~ ifelse(is.na(.), median(., na.rm = TRUE), .))

numeric_columns <- sapply(data, is.numeric)

data_clean <- data %>%
  filter(!apply(as.data.frame(scale(data[, numeric_columns])), 1, function(row) any(abs(row) > 3)))

summary_before <- summary(
  read.csv("C:/Users/kalya/Music/Tutorial Workshop Amulya/adult/adult.data",
           header = FALSE)
)

summary_after <- summary(data_clean)

correlation_matrix <- cor(data_clean[, numeric_columns], use = "complete.obs")

write.csv(data_clean, "cleaned_adult_income_data.csv", row.names = FALSE)

print("Summary Before Cleaning:")
print(summary_before)

print("Summary After Cleaning:")
print(summary_after)

print("Correlation Matrix:")
print(correlation_matrix)

ggcorrplot(correlation_matrix, method = "circle", lab = TRUE,
           title = "Correlation Matrix of Adult Income Dataset")
