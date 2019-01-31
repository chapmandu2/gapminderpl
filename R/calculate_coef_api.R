#' Calculate coefficients from the API
#'
#' @param country country to fit the model to
#' @param url URL of API server
#' @param path endpoint of API
#'
#' @return data frame
#' @export
#'
#' @examples
#' \dontrun{
#' calculate_coef_api('Algeria', url='http://localhost:8001/', path='model')
#' }
calculate_coef_api <- function(country=NULL, url='http://localhost:8001/', path='model') {

  stopifnot(!is.null(country), length(country) == 1)

  httr::GET(url, path=path, query=list(country=country)) %>%
    httr::content(as = 'text', encoding='UTF-8') %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    tibble::as_tibble()
}
