library(dplyr)
library(ggplot2)
library(zoo)
library(nycflights13)

data("flights")
data("airlines")

flights_inner_join <- flights %>%
  inner_join(airlines, by = "carrier")

flights_outer_join <- flights %>%
  full_join(airlines, by = "carrier")

head(flights_inner_join)
head(flights_outer_join)

flights_rolling <- flights %>%
  arrange(year, month, day) %>%
  mutate(
    arr_delay = ifelse(is.na(arr_delay), 0, arr_delay),
    rolling_avg_delay = rollmean(arr_delay, 5, fill = NA),
    cumulative_delay = cumsum(arr_delay)
  )

head(flights_rolling)

ggplot(flights_rolling, aes(x = day)) +
  geom_line(aes(y = rolling_avg_delay, color = "Rolling Average Delay")) +
  geom_line(aes(y = cumulative_delay / 1000, color = "Cumulative Delay (x1000)")) +
  labs(title = "Rolling Average and Cumulative Delay of Flights",
       x = "Day of the Month", y = "Delay (minutes)") +
  scale_color_manual(values = c("Rolling Average Delay" = "blue",
                                "Cumulative Delay (x1000)" = "red")) +
  theme_minimal()
