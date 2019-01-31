#' Create analysis plan
#'
#' Function to create a drake plan for a basic analysis
#'
#' @param countries character vector of countries
#'
#' @return drake plan object
#' @export
#'
#' @examples
#'
#' \dontrun{
#' library(gapminder)
#' library(dplyr)
#' library(drake)
#'
#' my_plan <- gapminder %>%
#'   distinct(country) %>%
#'   unlist() %>% unname() %>%
#'   as.character() %>%
#'   analysis_plan()
#'
#' make(my_plan)
#'
#' readd(results)
#' readd(plot)
#' }
analysis_plan <- function(countries) {
  drake::drake_plan(
    results_par = drake::target(
      calculate_coef(country = country_val, sleep = 0),
      transform = map(country_val = !!countries)
    ),
    results = drake::target(
      dplyr::bind_rows(results_par),
      transform = combine(results_par)
    ),
    plot = results %>% dplyr::filter(term == 'year') %>% plot_coef(),
    trace=TRUE
  )
}
