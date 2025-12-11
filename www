library(ggplot2)
library(cluster)
library(factoextra)
library(dplyr)

normalize <- function(data) {
  (data - min(data)) / (max(data) - min(data))
}

bc_data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data", header = FALSE)
bc_features <- bc_data[, -c(1, 2)]
bc_norm <- as.data.frame(lapply(bc_features, normalize))

bc_pca <- prcomp(bc_norm, scale. = TRUE)
bc_pca_data <- as.data.frame(bc_pca$x[, 1:2])

elbow_bc <- fviz_nbclust(bc_pca_data, kmeans, method = "wss")
print(elbow_bc)

silhouette_bc <- fviz_nbclust(bc_pca_data, kmeans, method = "silhouette")
print(silhouette_bc)

set.seed(123)
bc_kmeans <- kmeans(bc_pca_data, centers = 2, nstart = 25)

bc_pca_data$cluster <- as.factor(bc_kmeans$cluster)

p2 <- ggplot(bc_pca_data, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point(size = 3) +
  labs(title = "K-Means Clustering on Breast Cancer Dataset")
print(p2)

cat("Breast Cancer Clustering Results:\n")
cat("Cluster Sizes:", bc_kmeans$size, "\n")
