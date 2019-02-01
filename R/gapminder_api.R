#' Gapminder Pipeline API
#'
#' @param port Define port to serve API on - default is 8001
#'
#' @return deploys a plumber API on port 8001
#' @export
#'
#' @examples
#' NULL
gapminder_api <- function(port=8001) {

  pr <- plumber::plumber$new()

  pr$handle('GET', '/get_data', function(country = 'New Zealand') {
    gapminder::gapminder %>% dplyr::filter(country == !!country)
  })

  pr$handle('GET', '/plot_country',  function(country = 'New Zealand') {
    p <- plot_country(country)
    p_fn <- file.path(tempdir(), 'out.png')
    ggsave(p_fn, p)
    readBin(p_fn, 'raw', n=file.info(p_fn)$size)
  }, serializer = plumber::serializer_content_type('image/png'))

  pr$handle('GET', '/model', function(country = 'New Zealand') {
    calculate_coef(country)
  })

  pr$run(host='0.0.0.0', port=port)

}
