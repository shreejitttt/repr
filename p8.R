library(rattle)
library(ggplot2)
library(cluster)
library(factoextra)

normalize <- function(data){
  return((data - min(data)) / (max(data) - min(data)))
}

wine <- wine
wine_data <- wine[, -1]
wine_norm <- as.data.frame(lapply(wine_data, normalize))

wine_pca <- prcomp(wine_norm, scale. = TRUE)
summary(wine_pca)

wine_pca_data <- as.data.frame(wine_pca$x[, 1:2])

elbow_wine <- fviz_nbclust(wine_pca_data, kmeans, method = "wss")
print(elbow_wine)

silhouette_wine <- fviz_nbclust(wine_pca_data, kmeans, method = "silhouette")
print(silhouette_wine)

set.seed(123)
wine_kmeans <- kmeans(wine_pca_data, centers = 3, nstart = 25)

wine_pca_data$cluster <- as.factor(wine_kmeans$cluster)

p1 <- ggplot(wine_pca_data, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point(size = 3) +
  labs(title = "K-Means Clustering on Wine Dataset")
print(p1)

cat("Wine Dataset Clustering Results:\n")
cat("Cluster Sizes:", wine_kmeans$size, "\n")

bc_data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data", header = FALSE)
bc_features <- bc_data[, -c(1, 2)]
bc_norm <- as.data.frame(lapply(bc_features, normalize))

bc_pca <- prcomp(bc_norm, scale. = TRUE)
summary(bc_pca)

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

cat("Breast Cancer Dataset Clustering Results:\n")
cat("Cluster Sizes:", bc_kmeans$size, "\n")
