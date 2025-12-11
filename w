library(dplyr)
library(ggplot2)
library(zoo)

data("mpg")

mpg_filtered <- mpg %>%
  select(manufacturer, model, cyl, displ, hwy, cty, year) %>%
  filter(hwy > 20, cyl >= 4) %>%
  arrange(desc(hwy))

head(mpg_filtered)

mpg_summary <- mpg %>%
  group_by(manufacturer) %>%
  summarize(
    avg_hwy = mean(hwy, na.rm = TRUE),
    avg_cty = mean(cty, na.rm = TRUE),
    count = n()
  ) %>%
  arrange(desc(count))

head(mpg_summary)

mpg_classified <- mpg %>%
  mutate(fuel_efficiency = ifelse(hwy > 25, "High", "Low"))

head(mpg_classified)

df1 <- mpg %>% select(manufacturer, model, hwy)
df2 <- mpg %>% select(model, cyl)

inner_join_df <- inner_join(df1, df2, by = "model")
left_join_df  <- left_join(df1, df2, by = "model")

head(inner_join_df)
head(left_join_df)

mpg_roll <- mpg %>%
  group_by(manufacturer) %>%
  summarize(avg_hwy = mean(hwy, na.rm = TRUE)) %>%
  arrange(manufacturer) %>%
  mutate(
    rolling_avg = rollmean(avg_hwy, k = 3, fill = NA, align = "right"),
    cumulative_sum = cumsum(avg_hwy)
  )

head(mpg_roll)
