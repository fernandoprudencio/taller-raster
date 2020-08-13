library(tidyverse)
library(raster)
library(ncdf4)
library(Hmisc)

ts <- seq(as.Date("2000-01-01"), as.Date("2000-12-31"), "1 day")

df <- tibble(
  date = seq(as.Date("2000-01-01"), as.Date("2020-12-31"), "1 day")
) %>%
  mutate(id = 1:n()) %>%
  filter(
    str_sub(date, 6, 7) %nin% c("02", "03") &
      str_sub(date, 1, 4) == "2001"
  )

tibble(
  a = 1:10,
  b = 10:19,
  c = 21:30
) %>%
  dplyr::select(-a)


head(df)
tail(df)
#' xts
#' zoo