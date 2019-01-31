#' Slow Linear Model fit
#'
#' @param df data in gapminder format
#' @param sleep
#'
#' @return lm fit object
#' @export
#'
#' @examples
#' gapminder::gapminder %>%
#'  dplyr::filter(country == 'New Zealand') %>%
#'  slow_lm()
slow_lm <- function(df, sleep=0) {
  Sys.sleep(sleep)
  stats::lm(lifeExp ~ year, df)
}
