library(dplyr)
library(tidyr)
library(palmerpenguins)
library(ggplot2)


write.csv(penguins, "data/penguins.csv", row.names = FALSE)

penguins <- penguins_data

head(penguins)
str(penguins)

new_object <- penguins_data %>%
  head()

new_object

# Subseting data

# Select

penguins_locations <- penguins_data |>
  select(species, island)

penguins_locations

pwnguin_mm_measurements <- penguins_data |>
  select(ends_with("mm"))

# Filter operates on rows

adelie_penguins <- penguins_data |>
  filter(species == "Adelie")

# Adding or modifying columns - "mutate"

penguins_ratio <- penguins_data |>
  mutate(bill_length_depth_ratio = bill_length_mm / bill_depth_mm)

penguins_rounded <- penguins_data |>
  mutate(bill_length_mm_rounded = round(bill_length_mm))

penguins_rounded <- penguins_data |>
  mutate(across(ends_with("mm"), round))

penguins_rounded <- penguins_data |>
  mutate(across(ends_with("mm"), round, .names = "{.col}_round"))

# Split-apply-combine

penguins_species_total <- penguins_data|>
  group_by(species, island) |>
  summarize(total_penguins = n(),
            total_penguins_biomass = sum(body_mass_g, na.rm = TRUE))
ungroup()

##### Split-apply-combine #####

penguin_summary <- penguins |>
  group_by(island, species) |>
  summarize(total_penguins = n(),
            total_penguin = sum(body_mass_g)) |>
  ungroup()

penguin_totals <- penguins |>
  group_by(island, species) |>
  summarize(total_penguins = n(),
            total_penguin = sum(body_mass_g, na.rm = T)) |>
  ungroup()

penguin_summary <- penguins |>
  group_by(island, species, sex) |>
  summarize(across(ends_with("mm"), mean)) |>
  ungroup()


##### Reshaping #####

penguins_site_by_species <- penguin_totals |>
  select(species, island, total_penguins)

penguins_site_by_species <- penguin_totals |>
  select(species, island, total_penguins) |>
  tidyr::pivot_wider(id_cols = island,
                     names_from = species,
                     values_from = total_penguins)

penguins_site_by_species <- penguin_totals |>
  select(species, island, total_penguins) |>
  tidyr::pivot_wider(
    id_cols = island,
    names_from = species,
    values_from = total_penguins,
    values_fill =  0
  )

penguins_back_to_totals <- penguins_site_by_species |>
  tidyr::pivot_longer(-island, names_to = "Species", values_to = "Abundance")

##### joins + advanced joins #####

island_coordinates <- data.frame(
  island = c("Biscoe", "Dream", "Torgersen"),
  latitude = c(-65.433, -64.733, -64.766),
  longitude = c(-65.5, -64.344, -64.083)
)

ggplot(island_coordinates, aes(latitude, longitude)) +
  geom_point() +
  geom_text(aes(label = island), nudge_x = .07)

penguins_coords <- left_join(penguins, island_coordinates)

ggplot(penguins_coords, aes(longitude, body_mass_g, color = species)) +
  geom_jitter() +
  scale_color_viridis_d(option = "mako", begin = .2, end = .8)

