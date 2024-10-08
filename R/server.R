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

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

make_named_list <- function(x, as_list = TRUE) {
  y <- rlang::set_names(x$col, x$name)
  if (as_list) {
    y <- as.list(y)
  }
  invisible(y)
}

#' Create a [`shinyServer`][shiny::shinyServer] object.
#'
#' Create a [`shinyServer`][shiny::shinyServer] object to use in the
#' `analyzeBeahviorspace` [`shinyApp`][shiny::shinyApp].
#'
#' @return A [`shinyServer`][shiny::shinyServer] object.
#' @examples
#' \dontrun{
#' ui <- ui_fn()
#' server <- server_fn()
#' shinyApp(ui, server)
#' }
#'
#' @export
#'
server_fn <- function() {
  shiny::shinyServer(function(input, output, session) {

    shiny::snapshotPreprocessInput("table_state", function(value) {})

    cdata <- session$clientData

    expt_data <- shiny::reactiveValues(
      data = NULL,
      ind_vars = NULL,
      dep_vars = NULL,
      mapping = NULL
    )

    experiment <- shiny::reactive({
      list(data = expt_data$data,
           ind_vars = expt_data$ind_vars,
           dep_vars = expt_data$dep_vars,
           mapping = expt_data$mapping)
    })

    expt_vars <- shiny::reactive({
      message("expt_vars")
      vars <- analyzeBehaviorspace::get_expt_vars(experiment())
      message("expt_vars = (", paste(vars$name, vars$col, sep = " = ",
                                     collapse = ", "), ")")
      vars
    })

    expt_yvars <- shiny::reactive({
      message("expt_yvars")
      vars <- analyzeBehaviorspace::get_yvars(experiment(), input$x_var)
      message("expt_yvars = (", paste(vars$name, vars$col, sep = " = ",
                                      collapse = ", "), ")")
      vars
    })

    expt_group_vars <- shiny::reactive({
      message("expt_group_vars")
      vars <- analyzeBehaviorspace::get_group_vars(experiment(), input$x_var,
                                                   input$y_var)
      message("expt_group_ vars = (", paste(vars$name, vars$col, sep = " = ",
                                            collapse = ", "), ")")
      vars
    })

    expt_plot_vars <- shiny::reactive({
      message("expt_plot_vars")
      vars <- analyzeBehaviorspace::get_plot_vars(experiment(), input$x_var,
                                                  input$y_var)
      message("expt_plot_vars = (",
              paste(vars$name, vars$col, sep = " = ", collapse = ", "), ")")
      vars
    })

    bs_data <- shiny::reactive({
      # input$file1 will be NULL initially. After the user selects
      # and uploads a file, it will be a data frame with 'name',
      # 'size', 'type', and 'datapath' columns. The 'datapath'
      # column will contain the local filenames where the data can
      # be found.

      shiny::validate(
        need(! is.null(input$file1),
             "Please select a .csv file from a BehaviorSpace experiment.")
      )

      inFile <- input$file1
      if (is.null(inFile)) return(NULL)

      message("Reading input")
      text <- readr::read_file(inFile$datapath) %>%
        stringr::str_replace_all("\r\n", "\n") %>%
        stringr::str_replace_all("\r", "\n")
      dat <- analyzeBehaviorspace::load_bs_file(text = text, quiet = FALSE)
      message("returned from load_bs_file()")
      message("    success = ", dat$success)
      if (is.null(dat$data))
        message("    data = NULL")
      else
        message("    data dimensions (", stringr::str_c(dim(dat$data),
                                                        collapse = ", "),
                ")")
      if (! dat$success) {
        detail <- character(0)
        text <-
          "You must provide a .csv file containing the output of a NetLogo BehaviorSpace experiment in table format."
        if (dat$cause == "not_bs") {
          text <- "The file does not seem to be a BehaviorSpace experiment."
        } else if (dat$cause == "spreadsheet") {
          text <-
            "The file seems to be a BehaviorSpace experiment in spreadsheet format.\nYou need to choose \"table\" format for the BehaviorSpace output."
        }
        shinyalert::shinyalert(title="Bad file format", text = text,
                               type="error")
        return(NULL)
      }
      invisible(purrr::list_modify(dat, success = zap(), cause = zap()))
    })

    shiny::observeEvent(bs_data(), {
      message("New BehaviorSpace Data")
      expt <- bs_data()
      expt_data$data <- expt$data
      expt_data$ind_vars <- expt$ind_vars
      expt_data$dep_vars <- expt$dep_vars
      expt_data$mapping <- expt$mapping
      message("Experiment initialized")

      shiny::updateSelectInput(session, "ren_from", "", selected = "")
      shiny::updateSelectInput(session, "x_var", choices = "", selected = "")
      shiny::updateSelectInput(session, "y_var", choices = "", selected = "")
      shiny::updateSelectInput(session, "group_var", choices = "", selected = "")
    })

    shiny::observeEvent(expt_vars(), {
      message("expt_vars changed")
      xv <- input$x_var
      rv <- input$ren_from

      vars <- expt_vars() %>% make_named_list()
      if (! xv %in% vars) xv <- ''
      shiny::updateSelectInput(session, "x_var", choices = vars, selected = xv)
      message("Set x_var choices to (",
              paste(names(vars), vars, sep = " = ", collapse=", "),
              "), selection = ", xv)

      rvars <- expt_vars()%>% make_named_list()
      if (! rv %in% rvars) rv <- ''
      shiny::updateSelectInput(session, "ren_from", choices = rvars, selected = rv)
      message("Set rename_from choices to (",
              stringr::str_c(names(rvars), rvars, sep = " = ", collapse=", "),
              "), selection = ", rv)
    })

    shiny::observeEvent(expt_yvars(), {
      message("expt_yvars changed")
      yv <- input$y_var
      yvars <- expt_yvars() %>% make_named_list()
      if (! yv %in% yvars) yv <- ''
      shiny::updateSelectInput(session, "y_var", choices = yvars, selected = yv)
      message("Set y_var choices to (",
              stringr::str_c(names(yvars), yvars, sep = " = ", collapse=", "),
              "), selection = ", yv)
    })

    shiny::observeEvent(expt_group_vars(), {
      message("expt_group_vars changed")
      gv <- input$y_var
      gvars <- expt_group_vars() %>% make_named_list()
      if (! gv %in% gvars) gv <- ''
      shiny::updateSelectInput(session, "group_var", choices = gvars, selected = gv)
      message("Set group_var choices to (",
              stringr::str_c(names(gvars), gvars, sep = " = ", collapse=", "),
              "), selection = ", gv)
    })

    shiny::observeEvent(input$rename, {
      message("Rename")
      mapping <- expt_data$mapping
      ren_from <- input$ren_from
      ren_to <- input$ren_to
      vars <- expt_vars()
      if (nrow(mapping) == 0 || is.null(vars)) return()
      shiny::validate(
        need(! (ren_to %in% filter(mapping, col != ren_from)$name),
             paste("Variable name \"", ren_to, "\" already in use."))
      )

      mapping$name[mapping$col == ren_from] <- ren_to

      rvars <- expt_vars()%>% make_named_list()
      if (! ren_from  %in% rvars) ren_from <- ''
      shiny::updateSelectInput(session, "ren_from", choices = rvars,
                        selected = ren_from)
      shiny::updateTextInput(session, "ren_to", value = "")
      expt_data$mapping <- mapping
    })

    plot_data <- shiny::reactive({
      message("plot_data")
      data <-  analyzeBehaviorspace::get_plot_data(experiment(), input$x_var,
                                                   input$y_var, input$group_var,
                                                   input$last_tick)
      data
    })

    plot_mapping <- shiny::reactive({
      message("plot_mapping")
      plt_map <- analyzeBehaviorspace::get_plot_mapping(experiment(),
                                                        plot_data(),
                                                        input$x_var,
                                                        input$y_var,
                                                        input$group_var,
                                                        input$error_bars)
      plt_map
    })

    makeplot <- shiny::reactive({
      message("makeplot")
      p <- analyzeBehaviorspace::make_plot(experiment(), input$points, input$lines,
                                           input$x_var, input$y_var,
                                           input$group_var, input$error_bars,
                                           input$last_tick)
      message("Done making plot")
      p
    })

    maketable <- shiny::reactive({
      message("making table")
      tab_data <- expt_data$data
      if (is.null(tab_data)) return(NULL)
      new_names <- expt_data$mapping %>% make_named_list(FALSE)
      if (input$summary_tab) {
        tab_data <- plot_data()
      } else {
        if (input$last_tick) {
          # expt_data <- expt_data %>% extract_last_tick(expt_data$ind_vars)
          tab_data <- tab_data %>% extract_last_tick()
        }
      }
      new_names <- new_names %>% keep(~.x %in% names(expt_data)) %>% syms()
      if (length(new_names) > 0) {
        tab_data <- tab_data %>% rename(!!!new_names)
      }
      message("done making table")
      return(tab_data)
    })

    output$plot <- plotly::renderPlotly({
      p <- makeplot()
      if (is.null(p))
        return(NULL)
      plotly::ggplotly(p, width = cdata$output_plot_width,
                       height = cdata$output_plot_height)
    })

    output$table <- DT::renderDataTable(
      maketable(),
      server = TRUE, options = list(lengthChange = FALSE, bFilter = FALSE)
    )

    get_filename <- shiny::reactive({
      if (is.null(input$file1)) return(NULL)
      fname <- input$file1$name
      message("Fixing up filename ", fname)
      fname <- fname %>%
        stringr::str_replace(stringr::regex("\\.csv$", ignore_case = TRUE),
                             '') %>%
        stringr::str_replace_all('[ .]+', '_')
      message("Returning filename ", fname)
      fname
    })

    output$save_plot <- downloadHandler(
      filename <- function() {
        mapping <- expt_data$mapping
        if (is.null(mapping) || is.null(plot_data())) return()
        fname <- get_filename()
        suffix <- paste0('_', tx_col(input$x_var, mapping),
                         '_', tx_col(input$y_var, mapping))
        if (input$group_var != '')
          suffix <- paste0(suffix, '_', tx_col(input$group_var, mapping))
        message("fname = ", fname, ", suffix = ", suffix)
        suffix2 <- ''
        if (input$points) suffix2 <- paste0(suffix2, 'p')
        if (input$lines) suffix2 <- paste0(suffix2, 'l')
        if (input$error_bars == 'error bars') suffix2 <- paste0(suffix2, 'e')
        if (input$error_bars == 'bands') suffix2 <- paste0(suffix2, 'b')
        if (input$last_tick) suffix2 <- paste0(suffix2, 't')
        message("suffix2 = ", suffix2)
        if (suffix2 != '') suffix <- paste0(suffix, '_', suffix2)
        message("suffix = ", suffix)
        fname <- paste0(fname, suffix, '.png')
        fname
      },
      content = function(file) {
        message("Saving plot to file ", file)
        ggplot2::ggsave(filename = file, plot = makeplot(), device = "png",
               width = 800 / 72, height = 600 / 72, dpi = 72, units = "in")
      }
    )

    output$save_table <- shiny::downloadHandler(
      filename = function() {
        if (is.null(expt_data$data)) return()
        if (input$summary_tab) {
          suffix <- 'summary'
        } else {
          suffix <- 'data'
        }
        fname <- get_filename() %>% paste0(suffix, '.csv')
        fname
      },
      content = function(file1) {
        message("Writing to file ", file1)
        readr::write_csv(maketable(), file1)
      }
    )

    shiny::observeEvent(input$quit_button, {
      message("Quit pressed")
      stopApp()
    })

  })
}
