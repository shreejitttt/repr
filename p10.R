library(plotly)
library(gapminder)
library(dplyr)

data("gapminder")

scatter_plot <- gapminder %>%
  plot_ly(
    x = ~gdpPercap,
    y = ~lifeExp,
    color = ~continent,
    size = ~pop,
    hoverinfo = "text",
    text = ~paste("Country:", country, "<br>GDP per Capita:", gdpPercap),
    type = "scatter",
    mode = "markers"
  ) %>%
  layout(title = "GDP vs Life Expectancy by Continent")

bar_chart <- gapminder %>%
  filter(year == 2007) %>%
  plot_ly(
    x = ~country,
    y = ~lifeExp,
    type = "bar",
    hoverinfo = "text",
    text = ~paste("Country:", country, "<br>Life Expectancy:", lifeExp)
  ) %>%
  layout(title = "Life Expectancy by Country in 2007")

line_chart <- gapminder %>%
  filter(continent == "Asia") %>%
  plot_ly(
    x = ~year,
    y = ~lifeExp,
    color = ~country,
    type = "scatter",
    mode = "lines"
  ) %>%
  layout(title = "Life Expectancy Trend in Asia")

dashboard <- subplot(scatter_plot, bar_chart, line_chart, nrows = 1) %>%
  layout(title = "Gapminder Data Visualization")

dashboard
