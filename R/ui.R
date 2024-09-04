# analyzeBehaviorspace is open-source software; you can redistribute it and/or
# modify it under the terms of the MIT License as published by the Open Source
# Initiative.
#
# analyzeBehaviorspace is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the MIT License for more details.
#
# You should have received a copy of the MIT License along with this program; if
# not, see <https://opensource.org/licenses/MIT>.

# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


#' Create a [`shinyUI`][shiny::shinyUI] object
#'
#' Create a [`shinyUI`][shiny::shinyUI] object to use in a
#' `analyzeBehaviorspace` [`shinyApp`][shiny::shinyApp].
#'
#' @return A [`shinyUI`][shiny::shinyUI] object.
#' @examples
#' \dontrun{
#' ui <- ui_fn()
#' server <- server_fn()
#' shinyApp(ui, server)
#' }
#'
#' @export
#'
ui_fn <- function() {
  shiny::shinyUI(
    shiny::fluidPage(
      # shinyalert::useShinyalert(),
      shiny::titlePanel("Analyze BehaviorSpace Experiments"),
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          shiny::fileInput('file1', 'Choose CSV File',
                           accept=c('text/csv',
                                    'text/comma-separated-values,text/plain',
                                    '.csv')),
          shiny::tags$hr(),
          shiny::selectInput('x_var', label = "x axis", choices = c("")),
          shiny::selectInput('y_var', label = "y axis", choices = c("")),
          shiny::selectInput('group_var', "Group by", choices = c("")),
          shiny::checkboxInput('points', 'points', value = TRUE),
          shiny::checkboxInput('lines', 'lines', value = FALSE),
          shiny::radioButtons('error_bars', 'Std. Dev.',
                              choices = c('none', 'error bars', 'bands'),
                              selected = 'none', inline = TRUE),
          shiny::checkboxInput('last_tick', 'Only show last tick', value = FALSE),
          shiny::tags$hr(),
          shiny::checkboxInput('summary_tab','Summary table?', FALSE),
          shiny::tags$hr(),
          shiny::fluidRow(
            shiny::downloadButton("save_plot", "Save Plot"),
            shiny::downloadButton("save_table", "Save Table"),
            shiny::actionButton("quit_button", "Quit")
          ),
          shiny::tags$hr(),
          shiny::h3("Rename variables"),
          shiny::selectInput('ren_from', label = "from", choices = c("")),
          shiny::textInput('ren_to', label = "to"),
          shiny::actionButton("rename", "Rename")
        ),
        shiny::mainPanel(
          plotly::plotlyOutput('plot'),
          DT::dataTableOutput('table')
        )
      )
    )
  )
}
