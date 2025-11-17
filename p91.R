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
  cat("ADF p-value:", adf_test$p.value, "\n")
  if (adf_test$p.value > 0.05) {
    ts_data <- diff(ts_data)
    plot(ts_data, main = paste(dataset_name, "Differenced"))
  }
  model <- auto.arima(ts_data, seasonal = FALSE)
  print(summary(model))
  f <- forecast(model, h = 12)
  plot(f, main = paste(dataset_name, "ARIMA Forecast"))
  return(model)
}

fit_sarima <- function(ts_data, dataset_name) {
  cat("Fitting SARIMA for", dataset_name, "\n")
  model <- auto.arima(ts_data, seasonal = TRUE)
  print(summary(model))
  f <- forecast(model, h = 12)
  plot(f, main = paste(dataset_name, "SARIMA Forecast"))
  return(model)
}

compare_models <- function(arima_model, sarima_model, ts_data) {
  cat("Comparing ARIMA and SARIMA\n")
  h <- min(12, length(ts_data))
  f1 <- forecast(arima_model, h = h)
  f2 <- forecast(sarima_model, h = h)
  actual <- ts_data[(length(ts_data) - h + 1):length(ts_data)]
  arima_acc <- accuracy(f1$mean, actual)
  sarima_acc <- accuracy(f2$mean, actual)
  print(arima_acc)
  print(sarima_acc)
}

plot_forecast_comparison <- function(actual, f1, f2, time_points) {
  rmse1 <- sqrt(mean((f1 - actual)^2))
  rmse2 <- sqrt(mean((f2 - actual)^2))
  col1 <- ifelse(rmse1 < rmse2, "green", "red")
  col2 <- ifelse(rmse1 < rmse2, "red", "green")
  plot(time_points, actual, type = "o", col = "blue", pch = 16, xlab = "Time", ylab = "Values",
       main = "Forecast Comparison")
  lines(time_points, f1, col = col1, lty = 2, lwd = 2)
  lines(time_points, f2, col = col2, lty = 3, lwd = 2)
  legend("topright",
         legend = c("Actual", paste("ARIMA (RMSE =", round(rmse1, 2), ")"),
                    paste("SARIMA (RMSE =", round(rmse2, 2), ")")),
         col = c("blue", col1, col2), lty = c(1, 2, 3), lwd = c(1, 2, 2), pch = c(16, NA, NA))
}

data("AirPassengers")
air_data <- AirPassengers

perform_eda(air_data, "AirPassengers")
decompose_ts(air_data, "AirPassengers")
arima_air <- fit_arima(air_data, "AirPassengers")
sarima_air <- fit_sarima(air_data, "AirPassengers")
compare_models(arima_air, sarima_air, air_data)

h_air <- 12
air_actual <- air_data[(length(air_data) - h_air + 1):length(air_data)]
air_arima_f <- forecast(arima_air, h = h_air)$mean
air_sarima_f <- forecast(sarima_air, h = h_air)$mean
time_air <- time(air_data)[(length(air_data) - h_air + 1):length(air_data)]

plot_forecast_comparison(air_actual, air_arima_f, air_sarima_f, time_air)
