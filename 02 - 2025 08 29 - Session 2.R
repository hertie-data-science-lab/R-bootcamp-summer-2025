# 30.08.2025
# R Bootcamp @ Hertie
# Session 2

# dplyr

# Working with 'World Population Data'

library(tidyverse)
pop <- read_csv("05-dplyr/data/World.csv")
pop

# With dplyr the first argument is always a data frame, the output is always
# a dataframe.

# Filter allows to subset rows in a dataframe.

age_25_29 <- pop |>
              filter(age =="25-29")

# Filter can have subset rows multiple ways by separating the filters with a comma.

# Exercise 1. Find rows were births are greater than deaths and there are more
#              person-years for men than for women.
ex_1 <- pop |>
          filter(births > deaths,
                 py.men > py.women)

ex_1 <- arrange(desc(deaths))

# distinct() returns unique rows in the dataframe. It optionally takes column 
# names as arguments.

pop |>
  distinct(period)

# Adding two or more variables shows all available combinations in the data.

pop |>
  distinct(period, age)

# Exercise 2. Count the number of rows in each time period where births exceed
# deaths and there are more person-years for men than women.

ex_2 <- pop|>
          filter(births > deaths,
                 py.men > py.women) |>
          count(period)
ex_2

# rename() renames columns in a dataframe.
# relocate() changes the order of columns. By default, it moves the named columns
#   to the front.
# mutate() is used to create new columns.

# Exercise 3. Calculate the crude birth rate (CBR) for each row, where:
# CBR = number of births / number of person-years.

ex_3 <- pop|>
          mutate(cbr = births / (py.men + py.women))
ex_3

# Exercise 4. What row hast eh highest CBR

ex_4 <- ex_3 |>
          arrange(desc(cbr))

# summarise() is used to calculate summary statistics for a dataframe.

pop |>
  summarise(min_births = min(births),
            mean_births = mean(births),
            max_births = max(births))

# If any values in a group are NA, then functions like min(), max(), and sum()
# will return NA by default. We can disable this behavior by including 
# 'na.rm = TRUE' in the functions.

