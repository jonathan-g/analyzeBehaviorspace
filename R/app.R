
#' Create a [`shinyApp`][shiny::shinyApp] object
#'
#' Create a `shinyApp` object for `analyzeBehaviorspace`
#'
#' @param ... Arguments to pass to [`shinyApp()`][shiny::shinyApp()]
#'
#' @return A [`shinyApp`][shiny::shinyApp] object.
#' @examples
#' # ADD_EXAMPLES_HERE
app_fn <- function(...) {
  shiny_file_size <- getOption("analyzeBehaviorspace.maxFileSize", default = 300)
  options(shiny.maxRequestSize = shiny_file_size * 1024^2)

  ui <- ui_fn()
  server <- server_fn()

  shinyApp(ui, server, ...)
}
