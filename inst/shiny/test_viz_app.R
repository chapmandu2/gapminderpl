# to use copy to a directory served by shiny server and rename as app.R

library(shiny)
library(gapminderpl)

shinyApp(ui = test_viz_ui(),
         server = function(input, output) {
           test_viz_server(input, output)
         }
)
