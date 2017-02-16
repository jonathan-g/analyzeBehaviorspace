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

library(shiny)
library(tidyverse)
library(stringr)

options(shiny.maxRequestSize = 300 * 1024^2)

#instaoptions(warn = 2)

count_unique <- function(col_names, df) {
  lapply(as.character(col_names), function(x) {
    length(unique(df[,x])) > 1
   }) %>%
  unlist()
}

extract_last_tick <- function(df, vars) {
  # max_tick <- max(exp_data$tick, na.rm=T)
  # message("Filtering to last tick: ", max_tick)
  #exp_data <- exp_data %>% filter(tick == max_tick)
  lt_vars <- c('run', vars) %>% discard(~.x == 'tick')
  message("lt_vars = ", paste(lt_vars, collapse = ', '))
  df %>% group_by_(.dots = lt_vars) %>%
    top_n(1, tick) %>%
    ungroup() %>%
    invisible()
}

shinyServer(function(input, output, session) {
  experiment <- reactiveValues(
    data = NULL,
    ind_vars = NULL,
    dep_vars = NULL,
    mapping = NULL
  )

  tx_name <- function(var_name, mapping) {
    mapping$col[mapping$name == var_name]
  }

  tx_col <- function(var_col, mapping) {
    mapping$name[mapping$col == var_col]
  }

  expt_vars <- reactive({
    message("expt_vars")
    df <- experiment$data
    vars <- experiment$mapping
    if (is.null(df) || is.null(vars)) return(NULL)
    message("data = ", class(df))
    message("mapping = ", paste(names(vars), collapse = ", "))
    vars <- vars %>% filter(!(name %in% c('run')))
    vars <- vars %>% filter( (col %>% as.character() %>%
              lapply(function(x) {
                (df %>% select_(x) %>% distinct() %>% nrow()) > 1
                }) %>% unlist())
      )
    message("expt_vars = (", paste(vars$name, vars$col, sep = " = ", collapse = ", "), ")")
    vars
  })

  expt_yvars <- reactive({
    message("expt_yvars")
    x_var <- input$x_var
    vars <- expt_vars()
    if (is.null(vars)) return(NULL)
    vars <- vars %>% filter(col != x_var)
    message("expt_yvars = (", paste(vars$name, vars$col, sep = " = ", collapse = ", "), ")")
    vars
  })

  expt_group_vars <- reactive({
    message("expt_group_vars")
    vars <- expt_yvars()
    y_var <- input$y_var
    ind_vars <- experiment$ind_vars
    if (any(is.null(vars), is.null(y_var), is.null(ind_vars))) return(NULL)
    vars <- vars %>% filter(col != y_var & col %in% ind_vars)
    message("expt_group_ vars = (", paste(vars$name, vars$col, sep = " = ", collapse = ", "), ")")
    vars
  })

  expt_plot_vars <- reactive({
    message("expt_plot_vars")
    y_var <- input$y_var
    ind_vars <- experiment$ind_vars
    dep_vars <- experiment$dep_vars
    vars <- expt_yvars()
    if (any(is.null(y_var), is.null(ind_vars), is.null(dep_vars), is.null(vars)))
      return(NULL)
    vars <- vars %>% filter(name != y_var & col %in% c(ind_vars, dep_vars))
    message("expt_plot_vars = (", paste(vars$name, vars$col, sep = " = ", collapse = ", "), ")")
    vars
  })

  classify_vars <- function(df) {
    message("classify_vars")
    n <- colnames(df)
    nn <- df %>% map_lgl(is.numeric) %>% keep(~.x) %>% names()
    run <- which(n == 'run')
    tick <- which(n == 'tick')
    ind_vars <- character(0)
    if (tick > run + 1) {
      ind_vars <- n[(run + 1):(tick - 1)]
    }
    tick2 <- which(nn == 'tick')
    dep_vars <-  tail(nn, -tick)
    list(ind_vars = ind_vars, dep_vars = dep_vars)
  }

  bs_data <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.

    validate(
      need(! is.null(input$file1), "Please select a .csv file from a BehaviorSpace experiment.")
    )

    inFile <- input$file1
    if (is.null(inFile)) return(NULL)

    message("Reading input")
    text <- read_file(inFile$datapath)
    text_lines <- str_split(text, '\n') %>% simplify()
    message("File length = ", str_length(text), ": Split into ", length(text_lines), " lines.")
    skip_lines <- which(str_detect(text_lines, '^"\\[run number\\]"'))
    if (length(skip_lines) > 0) skip_lines = skip_lines[1] - 1


    d <- read_csv(text, skip = skip_lines, n_max = 100)

      nm <- names(d) %>% str_replace_all('[^a-zA-Z0-9]+','.') %>%
      str_replace_all(c('^\\.+' = '', '\\.+$' = '')) %>%
      str_replace_all(c('^run\\.number$' = 'run', '^step' = 'tick'))
    nc <- length(nm)
    spec <- rep_len('?', length(nm))
    spec <- paste(spec, collapse = '')

    d <- read_csv(text, skip = skip_lines + 1,
                  col_names = nm, col_types = spec,
                  guess_max = round(length(text_lines) / 2))
    if (any(duplicated(names(d)))) {
      d <- d[,-which(duplicated(names(d)))]
    }

    message("Names = (", paste0(names(d), collapse = ", "), ")")
    num_vars <- d %>% map_lgl(is.numeric) %>% keep(~.x) %>% names()
    factor_vars <- d %>% map_lgl(is.numeric) %>% discard(~.x) %>% names()
    message("numeric columns = ", paste(num_vars, collapse = ", "))
    message("factor columns = ", paste(factor_vars, collapse = ", "))
    #d <- d %>% select_(.dots = num_vars) %>%
    f <- function(x) { ! is.numeric(x)}
    if (length(factor_vars) > 0) {
    d <- d %>% mutate_if(f, funs(factor(.)))
    }
    d <- d %>% arrange(run, tick)
    names(d) <- str_replace_all(names(d), '\\.+','.')
    num_vars <- d %>% map_lgl(is.numeric) %>% keep(~.x) %>% names()
    factor_vars <- d %>% map_lgl(is.numeric) %>% discard(~.x) %>% names()
    message("numeric columns = ", paste(num_vars, collapse = ", "))
    message("factor columns = ", paste(factor_vars, collapse = ", "))
    vars <- classify_vars(d)
    message("ind_vars = ", paste(vars$ind_vars, collapse = ", "))
    message("dep_vars = ", paste(vars$dep_vars, collapse = ", "))
    message("Done loading data: ", nrow(d), " rows.")
    invisible(list(data = d, ind_vars = vars$ind_vars, dep_vars = vars$dep_vars,
                   mapping = data.frame(col = names(d), name = names(d),
                                        stringsAsFactors = F)))
  })

  observeEvent(bs_data(),
               {
                 message("New Behaviorspace Data")
                 expt <- bs_data()
                 experiment$data <- expt$data
                 experiment$ind_vars <- expt$ind_vars
                 experiment$dep_vars <- expt$dep_vars
                 experiment$mapping <- expt$mapping
                 message("Experiment initialized")

                 updateSelectInput(session, "ren_from", "", selected = "")
                 updateSelectInput(session, "x_var", choices = "", selected = "")
                 updateSelectInput(session, "y_var", choices = "", selected = "")
                 updateSelectInput(session, "group_var", choices = "", selected = "")
               })

  observeEvent(expt_vars(), {
    message("expt_vars changed")
    xv <- input$x_var
    rv <- input$ren_from

    vars <- expt_vars() %>% {set_names(.$col, .$name)} %>% as.list()
    if (! xv %in% vars) xv <- ''
    updateSelectInput(session, "x_var", choices = vars, selected = xv)
    message("Set x_var choices to (", paste(names(vars), vars, sep = " = ", collapse=", "), "), selection = ", xv)

    rvars <- expt_vars()%>% {set_names(.$col, .$name)} %>% as.list()
    if (! rv %in% rvars) rv <- ''
    updateSelectInput(session, "ren_from", choices = rvars, selected = rv)
    message("Set rename_from choices to (", paste(names(rvars), rvars, sep = " = ", collapse=", "), "), selection = ", rv)
  })

  observeEvent(expt_yvars(), {
    message("expt_yvars changed")
    yv <- input$y_var
    yvars <- expt_yvars() %>% {set_names(.$col, .$name)} %>% as.list()
    if (! yv %in% yvars) yv <- ''
    updateSelectInput(session, "y_var", choices = yvars, selected = yv)
    message("Set y_var choices to (", paste(names(yvars), yvars, sep = " = ", collapse=", "), "), selection = ", yv)
  })

  observeEvent(expt_group_vars(), {
    message("expt_group_vars changed")
    gv <- input$y_var
    gvars <- expt_group_vars() %>% {set_names(.$col, .$name)} %>% as.list()
    if (! gv %in% gvars) gv <- ''
    updateSelectInput(session, "group_var", choices = gvars, selected = gv)
    message("Set group_var choices to (", paste(names(gvars), gvars, sep = " = ", collapse=", "), "), selection = ", gv)
  })

  observeEvent(input$rename, {
    message("Rename")
    mapping <- experiment$mapping
    ren_from <- input$ren_from
    ren_to <- input$ren_to
    vars <- expt_vars()
    if (nrow(mapping) == 0 || is.null(vars)) return()
    validate(
      need(! (ren_to %in% filter(mapping, col != ren_from)$name),
           paste("Variable name \"", ren_to, "\" already in use."))
    )

    mapping$name[mapping$col == ren_from] <- ren_to

    rvars <- expt_vars()%>% {set_names(.$col, .$name)} %>% as.list()
    if (! ren_from  %in% rvars) ren_from <- ''
    updateSelectInput(session, "ren_from", choices = rvars, selected = ren_from)
    updateTextInput(session, "ren_to", value = "")
    experiment$mapping <- mapping
  })

  plot_data <- reactive({
    message("plot_data")
    x_var <- input$x_var
    y_var <- input$y_var
    g_var <- input$group_var
    last_tick <- input$last_tick
    exp_data <- experiment$data
    mapping <- experiment$mapping

    if (x_var == '' || y_var == '') {
      return(NULL)
    }

    # message("plot_data: Data = ", class(exp_data))
    if (is.null(exp_data) || is.null(mapping)) {
      # message("plot_data: empty data")
      return(NULL)
    }
    if (! all(expt_plot_vars()$col %in% names(exp_data))) {
      # message("Variable mismatch")
      return(NULL)
    }
    # message("Checking plotting variables")
    if (! all(c(x_var, y_var) %in% names(exp_data))) {
      # message("Bad plotting variables")
      return(NULL)
    }
    if (g_var != '') {
      # message("Checking group variable")
      if (! g_var %in% names(exp_data)) {
        message("Bad group variable ", g_var)
      }
    }

    pv <- expt_plot_vars()
    gv <- expt_group_vars()
    # message("Plot vars = ", paste0(pv, collapse = ', '))
    # message("Group vars = ", paste0(gv, collapse = ', '))

    if (last_tick || (! 'tick' %in% c(x_var, y_var))) {
      exp_data <- exp_data %>% extract_last_tick(experiment$ind_vars)
    }

    # message(paste0(names(gv), collapse = ", "))
    # message("g_var = ", g_var, ", gv = (", paste0(gv, collapse = ", "), "), grouping = ", (g_var %in% gv))

    if (length(pv) >= 1) {
      if (g_var %in% gv$col) {
        grouping <- unique(c('tick', x_var, g_var))
      } else {
        grouping <- unique(c('tick', x_var))
      }
      grouping <- grouping %>% discard(~.x == y_var)

      # message("Summarizing ", tx_col(y_var, mapping), " by ",
      #         paste(map_chr(grouping, tx_col, mapping), collapse=", "))
      dots <- setNames(paste0(c("mean","sd"), "(", y_var, ")"),
                       c(paste0(y_var, "_mean"), paste0(y_var, "_sd")))
      # message("dots = ", paste0(dots, collapse = ", "))
      # message("Grouping")
      exp_data <- exp_data %>% group_by_(.dots = grouping) %>%
        summarize_(.dots = dots) %>%
        rename_(.dots = setNames(list(paste0(y_var, "_mean")), y_var)) %>%
        ungroup()
      # message("Ungrouped: names = ", paste0(names(exp_data), collapse = ', '))
    }
    exp_data
  })

  plot_mapping <- reactive({
    message("plot_mapping")
    x_var <- input$x_var
    y_var <- input$y_var
    g_var <- input$group_var
    err_bars <- input$error_bars
    mapping <- experiment$mapping
    if (x_var == "" || y_var == "") return(NULL)
    if (is.null(mapping)) return(NULL)
    gv <- expt_group_vars()
    plt_data <- plot_data()
    # message("Mapping")
    p_map_list = list(x = x_var, y = y_var)
    plot_legend <- NULL
    if (g_var %in% gv$col) {
      p_map_list <- c(p_map_list,
                      colour = paste0("ordered(", g_var,")"),
                      fill = paste0("ordered(", g_var,")")
                      )
      plot_legend <- tx_col(g_var, mapping)
    }
    sd_name <- paste0(y_var, "_sd")
    if (err_bars != 'none' && sd_name %in% names(plt_data)) {
      p_map_list <- c(p_map_list,
                      ymin = paste0(y_var, " - ", sd_name),
                      ymax = paste0(y_var, " + ", sd_name)
      )
    }
    p_map <- do.call(aes_string, p_map_list)
    plot_labs <- labs(x = tx_col(x_var, mapping), y = tx_col(y_var, mapping))
    rval <- list(mapping = p_map, labels = plot_labs, legend = plot_legend)
    # message("plot_mapping: rval = ", rval)
    rval
  })


  makeplot <- reactive({
    message("makeplot")
    points <- input$points
    lines <- input$lines
    y_var <- input$y_var
    err_bars <- input$error_bars
    if (input$x_var == '' || input$y_var == '') {
      message("no variables selected to plot")
      return(NULL)
    }
    p_map <- plot_mapping()
    df <- plot_data()
    if (is.null(p_map) || is.null(df)) {
      message("no data to plot")
      return(NULL)
    }
    message("Plotting ", nrow(df), " rows of data")
    sd_name <- paste0(y_var, "_sd")
    # message("plot: variables = (", paste(names(df), collapse = ", "), ")")
    # message("plot: mapping = ", p_map)
    pm_mapping <- p_map$mapping
    pm_labs <- p_map$labels
    pm_legend <- p_map$legend
    # message("Plotting")
    p <- ggplot(df, pm_mapping)
    if (lines) p <- p + geom_line()
    if (sd_name %in% names(df)) {
      if (err_bars == 'error bars') {
        p <- p + geom_errorbar()
      } else if (err_bars == 'bands') {
        p <- p + geom_ribbon(alpha = 0.3)
      }
    }
    if (points) p <- p + geom_point()
    if (! is.null(pm_legend)) {
      # message("adding legend ", pm_legend)
      p <- p + scale_colour_discrete(guide = guide_legend(pm_legend, reverse = TRUE))
      p <- p + scale_fill_discrete(guide = guide_legend(pm_legend, reverse = TRUE))
    }
    # message("Labs = ", pm_labs)
    p <- p + pm_labs
    p <- p + theme_bw(base_size = 20)
    message("Done making plot")
    p
  })


  maketable <- reactive({
    message("making table")
    if (is.null(experiment$data)) return(NULL)
    dots <- experiment$mapping %>% {set_names(.$col, .$name)}
    expt_data <- plot_data()
    if((! input$summary_tab) || is.null(expt_data)) {
      expt_data <- experiment$data
      if (input$last_tick) {
        expt_data <- expt_data %>% extract_last_tick(experiment$ind_vars)
      }
    }
    dots <- dots %>% keep(~.x %in% names(expt_data))
    expt_data <- expt_data %>% rename_(.dots = dots)
    message("done making table")
    return(expt_data)
  })

  output$plot <- renderPlot({
    makeplot()
  })

  output$table <- DT::renderDataTable(
    maketable(),
    server = TRUE, options = list(lengthChange = FALSE, bFilter = FALSE)
    )

  get_filename <- reactive({
    if (is.null(input$file1)) return(NULL)
    fname <- input$file1$name
    message("Fixing up filename ", fname)
    fname <- fname %>%
      str_replace(regex("\\.csv$", ignore.case = TRUE), '') %>%
      str_replace_all('[ .]+', '_')
    message("Returning filename ", fname)
    fname
  })

  output$save_plot <- downloadHandler(
    filename <- function() {
      mapping <- experiment$mapping
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
      if (input$error_bars == 'bands') suffic2 <- paste0(suffix2, 'b')
      if (input$last_tick) suffix2 <- paste0(suffix2, 't')
      if (suffix2 != '') suffix <- paste0(suffix, '_', suffix2)
      fname <- paste0(fname, suffix, '.png')
      fname
    },
    content = function(file) {
      message("Saving plot to file ", file)
      ggsave(filename = file, plot = makeplot(), device = "png",
             width = 800 / 72, height = 600 / 72, dpi = 72, units = "in")
    }
  )

  output$save_table <- downloadHandler(
    filename = function() {
      if (is.null(experiment$data)) return()
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
      write.csv(maketable(), file1)
    }
  )

  observeEvent(input$quit_button, {
    message("Quit pressed")
    stopApp()
  })

})
