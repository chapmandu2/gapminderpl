#' Testviz shiny UI
#'
#' Creates a shiny UI object for the test_viz shiny app
#'
#' @return shiny ui object
#' @import shiny
#' @export
#'
#' @examples
#' \dontrun{
#' library(shiny)
#'
#' shinyApp(ui = test_viz_ui(),
#'         server = function(input, output) {
#'           test_viz_server(input, output)
#'         }
#' )
#' }
test_viz_ui <- function() {

  fluidPage(
    titlePanel('Gapminder Shiny App'),
    sidebarPanel(
      selectInput('country', 'Select country', choices = c('United Kingdom', 'New Zealand', 'Afghanistan'))
    ),
    mainPanel(
      plotOutput('country_plot')
    )
  )

}


#' Testviz shiny server
#'
#' Creates a shiny server object for the test_viz shiny app
#'
#' @param input shiny input
#' @param output shiny output
#'
#' @return shiny server function
#' @export
#'
#' @examples
#' \dontrun{
#' library(shiny)
#'
#' shinyApp(ui = test_viz_ui(),
#'         server = function(input, output) {
#'           test_viz_server(input, output)
#'         }
#' )
#' }
test_viz_server <- function(input, output) {

  output$country_plot <- renderPlot({
    plot_country(input$country)
  })

}

#' Testviz shiny app
#'
#' Convenience function to run the test_viz shiny app within an R session.
#'
#' The test_viz shiny app allows the user to view gapminder data for a particular country.
#'
#' @return runs a shiny app
#' @export
#' @import shiny
#'
#' @examples
#' \dontrun{
#'
#' test_viz()
#'
#' }
test_viz <- function() {
  shinyApp(ui = test_viz_ui, server = test_viz_server)
}
