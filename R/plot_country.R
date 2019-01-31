#' Plot data for one or more countries
#'
#' @param df gapminder data frame
#' @param country character vector of countries
#'
#' @return ggplot2 object
#' @export
#' @import ggplot2
#' @importFrom magrittr %>%
#'
#' @examples
#' NULL
plot_country <- function(country=NULL, df=gapminder::gapminder) {

  if(!is.null(country)) {
    df <- df %>% dplyr::filter(country %in% !!country)
  }

  df %>%
    ggplot(., aes(x=year, y=lifeExp, group=country, color=continent)) +
      geom_line(alpha=0.3) + theme_bw()
}
