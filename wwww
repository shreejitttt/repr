library(forecast)
library(ggplot2)
library(TSA)
library(tseries)

perform_eda <- function(ts_data, dataset_name) {
  cat("EDA for", dataset_name, "\n")
  print(summary(ts_data))
  plot(ts_data, main = paste(dataset_name, "Time Series"), ylab = "Values", xlab = "Time")
  acf(ts_data, main = paste("ACF of", dataset_name))
  pacf(ts_data, main = paste("PACF of", dataset_name))
}

decompose_ts <- function(ts_data, dataset_name) {
  cat("Decomposing", dataset_name, "\n")
  d <- decompose(ts_data)
  plot(d)
  return(d)
}

fit_arima <- function(ts_data, dataset_name) {
  cat("Fitting ARIMA for", dataset_name, "\n")
  adf_test <- adf.test(ts_data, alternative = "stationary")
  if (adf_test$p.value > 0.05) {
    ts_data <- diff(ts_data)
    plot(ts_data, main = paste(dataset_name, "Differenced"))
  }
  model <- auto.arima(ts_data, seasonal = FALSE)
  f <- forecast(model, h = 12)
  plot(f, main = paste(dataset_name, "ARIMA Forecast"))
  return(model)
}

fit_sarima <- function(ts_data, dataset_name) {
  cat("Fitting SARIMA for", dataset_name, "\n")
  model <- auto.arima(ts_data, seasonal = TRUE)
  f <- forecast(model, h = 12)
  plot(f, main = paste(dataset_name, "SARIMA Forecast"))
  return(model)
}

compare_models <- function(arima_model, sarima_model, ts_data) {
  cat("Comparing models\n")
  h <- min(12, length(ts_data))
  f1 <- forecast(arima_model, h = h)
  f2 <- forecast(sarima_model, h = h)
  actual <- ts_data[(length(ts_data) - h + 1):length(ts_data)]
  print(accuracy(f1$mean, actual))
  print(accuracy(f2$mean, actual))
}

plot_forecast_comparison <- function(actual, f1, f2, time_points) {
  rmse1 <- sqrt(mean((f1 - actual)^2))
  rmse2 <- sqrt(mean((f2 - actual)^2))
  col1 <- ifelse(rmse1 < rmse2, "green", "red")
  col2 <- ifelse(rmse1 < rmse2, "red", "green")
  plot(time_points, actual, type = "o", col = "blue", pch = 16,
       main = "Forecast Comparison", xlab = "Time", ylab = "Values")
  lines(time_points, f1, col = col1, lty = 2, lwd = 2)
  lines(time_points, f2, col = col2, lty = 3, lwd = 2)
}

data(milk)
milk_data <- milk

perform_eda(milk_data, "Milk Production")
decompose_ts(milk_data, "Milk Production")
arima_milk <- fit_arima(milk_data, "Milk Production")
sarima_milk <- fit_sarima(milk_data, "Milk Production")
compare_models(arima_milk, sarima_milk, milk_data)

h_milk <- 12
milk_actual <- milk_data[(length(milk_data) - h_milk + 1):length(milk_data)]
milk_arima_f <- forecast(arima_milk, h = h_milk)$mean
milk_sarima_f <- forecast(sarima_milk, h = h_milk)$mean
time_milk <- time(milk_data)[(length(milk_data) - h_milk + 1):length(milk_data)]

plot_forecast_comparison(milk_actual, milk_arima_f, milk_sarima_f, time_milk)
