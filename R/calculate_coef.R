#' Calculate coeficients
#'
#' @param country country to estimate
#' @param df data frame in gapminder format
#' @param sleep time to sleep
#'
#' @return data frame
#' @export
#'
#' @examples
#' calculate_coef('New Zealand')
calculate_coef <- function(country=NULL, df=gapminder::gapminder, sleep=0) {

  if(!is.null(country)) {
    df <- df %>% dplyr::filter(country == !!country)
  }

  results <- slow_lm(df, sleep = sleep) %>%
    broom::tidy()

  country_info <- df %>%
    dplyr::distinct(continent, country) %>%
    dplyr::mutate_all(as.character)

  stopifnot(nrow(country_info) == 1)

  country_info %>%
    tidyr::crossing(results)
}
