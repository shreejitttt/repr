library(dplyr)
library(ggplot2)
library(zoo)
library(nycflights13)

data("starwars")

starwars_filtered <- starwars %>%
  select(name, species, height, mass) %>%
  filter(!is.na(species) & !is.na(height) & height > 100) %>%
  arrange(desc(height))

head(starwars_filtered)

ggplot(starwars_filtered, aes(x = reorder(name, -height), y = height, fill = species)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Height of Star Wars Characters", x = "Character", y = "Height (cm)") +
  theme_minimal()

species_summary <- starwars %>%
  group_by(species) %>%
  summarize(
    avg_height = mean(height, na.rm = TRUE),
    avg_mass = mean(mass, na.rm = TRUE),
    count = n()
  ) %>%
  arrange(desc(count))

head(species_summary)

ggplot(species_summary, aes(x = reorder(species, -avg_height), y = avg_height, fill = species)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Average Height by Species", x = "Species", y = "Average Height (cm)") +
  theme_minimal()

starwars_classified <- starwars %>%
  mutate(height_category = ifelse(height > 180, "Tall", "Short"))

head(starwars_classified)

ggplot(starwars_classified, aes(x = height_category, fill = height_category)) +
  geom_bar() +
  labs(title = "Distribution of Height Categories", x = "Height Category", y = "Count") +
  theme_minimal()
