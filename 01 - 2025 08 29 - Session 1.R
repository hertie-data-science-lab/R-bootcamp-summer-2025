# 29.08.2025
# R Bootcamp @ Hertie School
# Jackson M. Luckey

### First, install the tidyverse packages.

install.packages("tidyverse")
library(tidyverse)

### Using R as a calculator

2 +2 
2 * 2
2 + 2 == 2 * 2
2 != 2

# Exercises
#   1. Calculate the number of hours in a year
365 *24 # 8,760

#   2. Calculate the population density of Berlin (3,897,145 persons in 891.3 km2)
3897145/891.3 # 4,372.428

#   Turning into objects

days_in_year <- 365
hours_in_day <- 24
hours_in_year <- days_in_year * hours_in_day

berlin_pop <- 3897145
berlin_area <- 891.3
berlin_density <- berlin_pop/berlin_area

# A single equal sign (=) can be used as an assignment operator (eg, <-).

### Vectors

# Vectors are objects that represent an ordered collection of information.
years <- c(2020, 2021, 2022, 2023, 2024, 2025)
cities <- c("Berlin", "Paris", "London", "Beijing", "Tokyo")

# Vectors are always one-dimensional objects.
# Vectors can be combined.
# You can manipulate vectors just like individual numbers.

# Excercise: calculate the number of seconds since 1970

secs_since_1970 <- (years - 1970) * hours_in_year * 3600
secs_since_1970

# Population of Berlin in 1980, 1990, 2000, 2010, 2020
years      <- c(1980,    1990,    2000,    2010,    2020)
berlin_pop <- c(3048759, 3433695, 3382169, 3460725, 3664088)

berlin_den <- berlin_pop / 891.3
names(berlin_den) <- years
berlin_den

# You can access elements inside a vector using []. For example, to get the first
# element in "cities", do:

cities[1]

# Get the population density of Berlin in 2020:
berlin_den[5]

### Functions

# If you type "?" before the name of the function, R will display the corresponding
# documentation ("help").

?length

# Using min() and max(), find the lowest and highest population density in Berlin
# between 1980 and 2020.

min(berlin_pop) / berlin_area
max(berlin_pop) / berlin_area #or

min(berlin_pop / berlin_area)
max(berlin_pop / berlin_area)

# Study tip: think of different ways to deliver the same task.

### Dataframes

# R has several dataframes, inluding "penguins", built in. We can load penguins
# into R with:

penguins <- penguins
View(penguins) #or

penguins <- datasets::penguins
View(penguins) #or

install.packages("palmerpenguins")
library(palmerpenguins)

# For more datasets, use install.packages("dataframes")
?datasets

# You can access dataframe columns as vectors using `$`.
# For example, we can get `body_mass` from `penguins` with:

penguins$body_mass

### Introduction to Data Visualization with R

# "ggplot" is the most common approach for creating data visualizations with R.

ggplot(penguins, aes(x = body_mass, y = flipper_len)) +
  geom_point()

ggplot(penguins, aes(x = body_mass, y = flipper_len, color = species)) +
  geom_point()

ggplot(penguins, aes(x = body_mass, y = flipper_len, color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) # linear regression
ggplot(penguins, aes(x = body_mass, y = flipper_len)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) # linear regression
ggplot(penguins, aes(x = body_mass, y = flipper_len, color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship Between Body Mass and Flipper Length of Penguins",
    x = "Body Mass (grams)",
    y = "Flipper Length (mm)",
    color = "Species",
    caption = "Body mass and flipper length are positively correlated for all three species of penguin"
  ) +
  theme_minimal() +
  theme(panel.grid.minor = element_blank())

### Explore the data

library(scales)
penguins <- penguins

penguins %>%
  filter(!is.na(sex)) %>%
  filter(species == "Adelie") %>%
  ggplot(aes(x = body_mass, fill = sex)) + 
    geom_density(alpha = 0.5) + 
    scale_y_continuous(labels = label_number()) + 
    theme_minimal() + 
    labs(
      title = "Penguins' body mass density",
      subtitle = "Species: Adelie",
      x = "Body mass (g)",
      y = "Density"
    )

# "scale_y_continuous(labels = label_number())" changes Density labels to
# scientific notation.

# When aesthetic mappings are defined in ggplot(), at the global level, they’re
# passed down to each of the subsequent geom layers of the plot. However, each
# geom function in ggplot2 can also take a mapping argument, which allows for
# aesthetic mappings at the local level that are added to those inherited from
# the global level. For example:

ggplot(
  data = penguins,
  aes(x = flipper_len, y = body_mass)) +
  geom_point(aes(color = species)) +
  geom_smooth(method = "lm")

# Change shape of markers, make it specific for each species.

ggplot(
  data = penguins,
  aes(x = flipper_len, y = body_mass)) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

# We can improve the color palette to be colorblind safe with the
# scale_color_colorblind() function from the ggthemes package:

install.packages("ggthemes")
library(ggthemes)

ggplot(
  data = penguins,
  aes(x = flipper_len, y = body_mass)) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  scale_color_colorblind()

# Add labels:

ggplot(
  data = penguins,
  mapping = aes(x = flipper_len, y = body_mass)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()