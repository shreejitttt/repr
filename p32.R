library(dplyr)
library(ggplot2)
library(moments)
library(palmerpenguins)

data(penguins)

print("----- Palmer Penguins Dataset Analysis -----")

penguins_clean <- na.omit(penguins)

calc_mode <- function(x) {
  as.numeric(names(sort(table(x), decreasing = TRUE))[1])
}

penguins_mean <- sapply(penguins_clean[, 3:6], mean, na.rm = TRUE)
print(penguins_mean)

penguins_median <- sapply(penguins_clean[, 3:6], median, na.rm = TRUE)
print(penguins_median)

penguins_mode <- sapply(penguins_clean[, 3:6], calc_mode)
print(penguins_mode)

penguins_variance <- sapply(penguins_clean[, 3:6], var, na.rm = TRUE)
print(penguins_variance)

penguins_sd <- sapply(penguins_clean[, 3:6], sd, na.rm = TRUE)
print(penguins_sd)

penguins_skewness <- sapply(penguins_clean[, 3:6], skewness, na.rm = TRUE)
print(penguins_skewness)

penguins_kurtosis <- sapply(penguins_clean[, 3:6], kurtosis, na.rm = TRUE)
print(penguins_kurtosis)

adelie <- subset(penguins_clean, species == "Adelie")$flipper_length_mm
gentoo <- subset(penguins_clean, species == "Gentoo")$flipper_length_mm
t_test_penguins <- t.test(adelie, gentoo)
print(t_test_penguins)

ggplot(penguins_clean, aes(x = flipper_length_mm)) +
  geom_histogram(binwidth = 3, fill = "green", color = "black") +
  ggtitle("Histogram of Flipper Length in Palmer Penguins Dataset")

ggplot(penguins_clean, aes(x = species, y = flipper_length_mm, fill = species)) +
  geom_boxplot() +
  ggtitle("Boxplot of Flipper Length by Species in Palmer Penguins Dataset")
