# API for gapminder functions

# code for entire API
library(gapminderpl)
library(dplyr)

#' Get data for a specified country
#' @param country The country to get data for
#' @get /get_data
function(country="New Zealand"){
  gapminder::gapminder %>% dplyr::filter(country == !!country)
}

#' Plot data for a country
#' @png
#' @get /plot_country
function(country="New Zealand"){
  print(plot_country(country))
}

#' Fit a model for a country
#' @get /model
function(country="New Zealand"){
  calculate_coef(country)
}
