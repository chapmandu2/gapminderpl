#' Create API analysis plan
#'
#' Function to create a drake plan for an analysis using the API
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
#' # note will have to have instantiated the API in another R process eg:
#' # gapminder_api(8000)
#'
#' my_plan <- gapminder %>%
#'   distinct(country) %>%
#'   unlist() %>% unname() %>%
#'   as.character() %>%
#'   analysis_plan_api()
#'
#' make(my_plan)
#'
#' readd(results)
#' readd(plot)
#' }
analysis_plan_api <- function(countries, url='http://localhost:8000/', path='model') {
  drake::drake_plan(
    results_par = drake::target(
      calculate_coef_api(country_val, url=!!url, path=!!path),
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
