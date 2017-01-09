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

library(shiny)
library(shinyjs)

jscode <- "shinyjs.closewindow = function() { window.open('','_self').close(); }"

shinyUI(fluidPage(
  useShinyjs(),
  extendShinyjs(text = jscode),

  titlePanel("Analyze BehaviorSpace Experiments"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv',
                         'text/comma-separated-values,text/plain',
                         '.csv')),
      tags$hr(),
      selectInput('x_var', label = "x axis", choices = c("")),
      selectInput('y_var', label = "y axis", choices = c("")),
      selectInput('group_var', "Group by", choices = c("")),
      checkboxInput('points', 'points', value = TRUE),
      checkboxInput('lines', 'lines', value = FALSE),
      checkboxInput('error_bars', 'error bars', value = FALSE),
      checkboxInput('last_tick', 'Only show last tick', value = FALSE),
      tags$hr(),
      checkboxInput('summary_tab','Summary table?', FALSE),
      tags$hr(),
      fluidRow(
        downloadButton("save_plot", "Save Plot"),
        downloadButton("save_table", "Save Table"),
        actionButton("quit_button", "Quit")
      ),
      tags$hr(),
      h3("Rename variables"),
      selectInput('ren_from', label = "from", choices = c("")),
      textInput('ren_to', label = "to"),
      actionButton("rename", "Rename")
    ),
    mainPanel(
      plotOutput('plot'),
      DT::dataTableOutput('table')
    )
  )
))
