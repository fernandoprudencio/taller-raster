library(tidyverse)
library(raster)
library(ncdf4)
library(Hmisc)

df <- tibble(
  date = seq(as.Date("1981-01-01"), as.Date("2016-12-01"), by = "1 month")
) %>%
  mutate(id = 1:n())

fun.clim <- function(month, years.omit, data) {
  grd.mt <- df %>%
    filter(
      str_sub(date, 6, 7) == month &
        str_sub(date, 1, 4) %nin% years.omit
    )
  
  data[[grd.mt$id]] %>% "*"(1) %>%
    mean(na.rm = T) %>%
    return()
}

grd.clim <- sapply(
  sprintf("%02d", 1:12),
  FUN = fun.clim,
  years.omit = c(2005, 2010, 2016),
  data = brick("data/raster/pp/pisco-pp.nc")
) %>% stack() %>% "*"(1)

writeRaster(grd.clim, "data/raster/pp/pisco-pp_clim.tif")

#' FORMATOS RASTER
#' .tif
#' .hdf4
#' .hdf5
#' .dat
#' .img
#' .nc
#' .grd
#' .bin
#' .txt

mtx <- data.frame(
  from = seq(0, 1000, 200),
  to = seq(0, 1000, 200) + 200
) %>%
  mutate(val = 1:n()) %>%
  as.matrix()

pp.reclass <- reclassify(grd.clim[[1]], mtx)