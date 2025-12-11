library(dplyr)
library(ggplot2)
library(moments)
library(palmerpenguins)

data(iris)

calc_mode <- function(x) {
  as.numeric(names(sort(table(x), decreasing = TRUE))[1])
}

print("----- Iris Dataset Analysis -----")

iris_mean <- sapply(iris[, 1:4], mean, na.rm = TRUE)
print(iris_mean)

iris_median <- sapply(iris[, 1:4], median, na.rm = TRUE)
print(iris_median)

iris_mode <- sapply(iris[, 1:4], calc_mode)
print(iris_mode)

iris_variance <- sapply(iris[, 1:4], var, na.rm = TRUE)
print(iris_variance)

iris_sd <- sapply(iris[, 1:4], sd, na.rm = TRUE)
print(iris_sd)

iris_skewness <- sapply(iris[, 1:4], skewness, na.rm = TRUE)
print(iris_skewness)

iris_kurtosis <- sapply(iris[, 1:4], kurtosis, na.rm = TRUE)
print(iris_kurtosis)

setosa <- subset(iris, Species == "setosa")$Sepal.Length
versicolor <- subset(iris, Species == "versicolor")$Sepal.Length
t_test <- t.test(setosa, versicolor)
print(t_test)

ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = 0.3, fill = "blue", color = "black") +
  ggtitle("Histogram of Sepal Length in Iris Dataset")

ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot() +
  ggtitle("Boxplot of Sepal Length by Species in Iris Dataset")
