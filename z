# Load necessary libraries
library(dplyr)           # data manipulation
library(ggplot2)         # visualization
library(moments)         # skewness and kurtosis
library(palmerpenguins)  # penguins dataset

# Load datasets
data(iris)
data(penguins)

# Function to calculate mode
calc_mode <- function(x) {
  return(as.numeric(names(sort(table(x), decreasing = TRUE))[1]))
}

# ---------------------------------------------------------
#               IRIS DATASET ANALYSIS
# ---------------------------------------------------------

print("----- Iris Dataset Analysis -----")

# Mean
iris_mean <- sapply(iris[, 1:4], mean, na.rm = TRUE)
print("Mean of Iris dataset:")
print(iris_mean)

# Median
iris_median <- sapply(iris[, 1:4], median, na.rm = TRUE)
print("Median of Iris dataset:")
print(iris_median)

# Mode
iris_mode <- sapply(iris[, 1:4], calc_mode)
print("Mode of Iris dataset:")
print(iris_mode)

# Variance
iris_variance <- sapply(iris[, 1:4], var, na.rm = TRUE)
print("Variance of Iris dataset:")
print(iris_variance)

# Standard Deviation
iris_sd <- sapply(iris[, 1:4], sd, na.rm = TRUE)
print("Standard Deviation of Iris dataset:")
print(iris_sd)

# Skewness
iris_skewness <- sapply(iris[, 1:4], skewness, na.rm = TRUE)
print("Skewness of Iris dataset:")
print(iris_skewness)

# Kurtosis
iris_kurtosis <- sapply(iris[, 1:4], kurtosis, na.rm = TRUE)
print("Kurtosis of Iris dataset:")
print(iris_kurtosis)

# T-test (Setosa vs Versicolor)
setosa <- subset(iris, Species == "setosa")$Sepal.Length
versicolor <- subset(iris, Species == "versicolor")$Sepal.Length
t_test_iris <- t.test(setosa, versicolor)
print(t_test_iris)

# Histogram
ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = 0.3, fill = "blue", color = "black") +
  ggtitle("Histogram of Sepal Length in Iris Dataset")

# Boxplot
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot() +
  ggtitle("Boxplot of Sepal Length by Species in Iris Dataset")


# ---------------------------------------------------------
#          PALMER PENGUINS DATASET ANALYSIS
# ---------------------------------------------------------

print("----- Palmer Penguins Dataset Analysis -----")

penguins_clean <- na.omit(penguins)

# Mean
penguins_mean <- sapply(penguins_clean[, 3:6], mean, na.rm = TRUE)
print("Mean of Palmer Penguins dataset:")
print(penguins_mean)

# Median
penguins_median <- sapply(penguins_clean[, 3:6], median, na.rm = TRUE)
print("Median of Palmer Penguins dataset:")
print(penguins_median)

# Mode
penguins_mode <- sapply(penguins_clean[, 3:6], calc_mode)
print("Mode of Palmer Penguins dataset:")
print(penguins_mode)

# Variance
penguins_variance <- sapply(penguins_clean[, 3:6], var, na.rm = TRUE)
print("Variance of Palmer Penguins dataset:")
print(penguins_variance)

# Standard deviation
penguins_sd <- sapply(penguins_clean[, 3:6], sd, na.rm = TRUE)
print("Standard Deviation of Palmer Penguins dataset:")
print(penguins_sd)

# Skewness
penguins_skewness <- sapply(penguins_clean[, 3:6], skewness, na.rm = TRUE)
print("Skewness of Palmer Penguins dataset:")
print(penguins_skewness)

# Kurtosis
penguins_kurtosis <- sapply(penguins_clean[, 3:6], kurtosis, na.rm = TRUE)
print("Kurtosis of Palmer Penguins dataset:")
print(penguins_kurtosis)

# T-test (Adelie vs Gentoo)
adelie <- subset(penguins_clean, species == "Adelie")$flipper_length_mm
gentoo <- subset(penguins_clean, species == "Gentoo")$flipper_length_mm
t_test_penguins <- t.test(adelie, gentoo)
print(t_test_penguins)

# Histogram (Flipper Length)
ggplot(penguins_clean, aes(x = flipper_length_mm)) +
  geom_histogram(binwidth = 3, fill = "green", color = "black") +
  ggtitle("Histogram of Flipper Length in Palmer Penguins Dataset")

# Boxplot
ggplot(penguins_clean, aes(x = species, y = flipper_length_mm, fill = species)) +
  geom_boxplot() +
  ggtitle("Boxplot of Flipper Length by Species in Palmer Penguins Dataset")
