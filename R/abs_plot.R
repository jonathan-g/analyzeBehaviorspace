
#' Get data frame for plotting from an experiment
#'
#' From an experiment, extract a data frame suitable for plotting with
#' `ggplot()`. Select the relevant columns for plotting, using an x-variable,
#' a y-variable, and an optional grouping variable. If `last_tick` is `TRUE`,
#' then only include data for the last tick of each run. Otherwise, include all
#' ticks.
#'
#' @param experiment An experiment object, returned by [load_bs_file()],
#'  [load_bs_table()], or [load_bs_spreadsheet()].
#' @param x_var The name of the independent variable for the x-axis
#' @param y_var The name of the dependent variable for the y-axis.
#' @param group_var The name of the variable to use for grouping.
#' @param last_tick Logical: plot only the last tick (as opposed to plotting all
#'  ticks).
#'
#' @return A data frame suitable for plotting with `ggplot()`.
#' @export
#'
get_plot_data <- function(experiment, x_var, y_var, group_var, last_tick){
  exp_data <- experiment$data
  mapping <- experiment$mapping

  pv <- get_plot_vars(experiment, x_var = x_var, y_var = y_var)
  gv <- get_group_vars(experiment, x_var = x_var, y_var = y_var)

  if (x_var == '' || y_var == '') {
    return(NULL)
  }

  # message("plot_data: Data = ", class(exp_data))
  if (is.null(exp_data) || is.null(mapping)) {
    # message("plot_data: empty data")
    return(NULL)
  }
  if (! all(pv$col %in% names(exp_data))) {
    # message("Variable mismatch")
    return(NULL)
  }
  # message("Checking plotting variables")
  if (! all(c(x_var, y_var) %in% names(exp_data))) {
    # message("Bad plotting variables")
    return(NULL)
  }
  if (group_var != '') {
    # message("Checking group variable")
    if (! group_var %in% names(exp_data)) {
      message("Bad group variable ", group_var)
    }
  }

  message("Plot vars = ", paste0(pv, collapse = ', '))
  message("Group vars = ", paste0(gv, collapse = ', '))

  if (last_tick || (! 'tick' %in% c(x_var, y_var))) {
    message("Processing for last tick")
    # exp_data <- exp_data %>% extract_last_tick(experiment$ind_vars)
    exp_data <- exp_data %>% extract_last_tick()
  }

  message(paste0(names(gv), collapse = ", "))
  message("g_var = ", group_var, ", gv = (", paste0(gv, collapse = ", "), "),
          grouping = ", (group_var %in% gv))

  if (length(pv) >= 1) {
    if (group_var %in% gv$col) {
      vv <- c(x_var, group_var)
    } else {
      vv <- c(x_var)
    }
    if (!last_tick) vv <- c('tick', vv)
    grouping <- unique(vv)
    grouping <- grouping %>% discard(~.x == y_var)

    message("Summarizing ", tx_col(y_var, mapping), " by ",
            paste(map_chr(grouping, tx_col, mapping), collapse=", "))
    message("Grouping")
    g_syms <- syms(grouping)
    y_sym = sym(y_var)
    sum_expr <- quos(mean(), sd()) %>%
      map(~rlang::call_modify(.x, y_sym, na.rm = TRUE)) %>%
      set_names(str_c(y_var, c("mean", "sd"), sep = "_"))
    ren_expr <- set_names(str_c(y_var, "mean", sep = "_"), y_var)
    exp_data <- exp_data %>% group_by(!!!g_syms) %>%
      summarize(!!!sum_expr, .groups = "drop") %>%
      rename(!!!ren_expr)
    message("Ungrouped: names = ", paste0(names(exp_data), collapse = ', '))
  }
  exp_data
}


#' Get an aesthetic mapping suitable for use in `ggplot()`
#'
#' Create a `ggplot` aesthetic mapping from a BehaviorSpace experiment object,
#' based on chosen x-variable, y-variable, and optional grouping variable.
#' Optionally, include a mapping for error bars or an error ribbon.
#'
#' @param experiment A BehaviorSpace experiment object, as returned from
#'  [load_bs_file()], [load_bs_table()], or [load_bs_experiment()].
#' @param plot_data Plot data returned from [get_plot_data()].
#' @param x_var The name of an x-variable for the plot.
#' @param y_var The name of an x-variable for the plot.
#' @param group_var The name of an x-variable for the plot.
#' @param error_bars The kind of error bars to use. Legal values are
#'   "none", "error bars", or "bands"
#'
#' @return A named list with an aesthetic mapping, A label specification for
#'  the axes, and a legend specification.
#' @export
#'
get_plot_mapping <- function(experiment, plot_data, x_var, y_var, group_var,
                         error_bars){
  mapping <- experiment$mapping
  if (x_var == "" || y_var == "") return(NULL)
  if (is.null(mapping)) return(NULL)
  gv <- get_group_vars(experiment, x_var = x_var, y_var = y_var)
  # message("Mapping")
  p_map_args = c(x = x_var, y = y_var)
  plot_legend <- NULL
  if (! is.null(group_var) && group_var != "" && group_var %in% gv$col) {
    p_map_args <- c(p_map_args,
                    colour = paste0("ordered(", group_var,")"),
                    fill = paste0("ordered(", group_var,")")
    )
    plot_legend <- tx_col(group_var, mapping)
  }
  sd_name <- paste0(y_var, "_sd")
  if (! is.null(error_bars) && error_bars != 'none' &&
      sd_name %in% names(plot_data)) {
    p_map_args <- c(p_map_args,
                    ymin = paste0(y_var, " - ", sd_name),
                    ymax = paste0(y_var, " + ", sd_name)

    )
  }
  p_map_list <- rlang::parse_exprs(p_map_args)
  pm_x <- p_map_list$x
  pm_y <- p_map_list$y
  p_map_list <- purrr::list_modify(p_map_list, x= NULL, y = NULL)
  p_map <- aes(x = !!pm_x, y = !!pm_y, !!!p_map_list)
  plot_labs <- labs(x = tx_col(x_var, mapping), y = tx_col(y_var, mapping))
  rval <- list(mapping = p_map, labels = plot_labs, legend = plot_legend)
  # message("plot_mapping: rval = ", rval)
  rval
}


#' Make a ggplot from a BehaviorSpace experiment
#'
#' Make a ggplot plot from a BehaviorSpace experiment, using a chosen x-variable,
#' y-variable, and optional grouping variable. In addition, the user may
#' specify error bars for the plot, and may choose to plot all ticks, or only
#' the last tick of each run.
#'
#' @param experiment A BehaviorSpace experiment object, as returned from
#'  [load_bs_file()], [load_bs_table()], or [load_bs_experiment()].
#' @param points Logical: plot points.
#' @param lines Logical: plot lines.
#' @param x_var The name of the x-variable.
#' @param y_var The name of the y-variable.
#' @param group_var Optionally, the name of a grouping variable.
#' @param error_bars The kind of error bars to use. Legal values are
#'   "none", "error bars", or "bands"
#' @param last_tick Logical: Plot only the last tick from each run.
#'
#' @return A ggplot object.
#' @export
#'
make_plot <- function(experiment, points, lines, x_var, y_var, group_var,
                     error_bars = 'none', last_tick = FALSE) {
  if (x_var == '' || y_var == '') {
    message("no variables selected to plot")
    return(NULL)
  } else {
    message("x = ", x_var, ", y = ", y_var, " group = ", group_var,
            ", error bars = ", error_bars, ", last_tick = ", last_tick)
  }
  df <- get_plot_data(experiment, x_var, y_var, group_var, last_tick)
  p_map <- get_plot_mapping(experiment, df, x_var, y_var, group_var, error_bars)
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
  message("Plotting...")
  p <- ggplot(df, pm_mapping)
  message("lines = ", lines)
  if (lines) {
    p <- p + geom_line()
  }
  message("sd name = ", sd_name)
  if (sd_name %in% names(df)) {
    message("error bars = ", error_bars)
    if (error_bars == 'error bars') {
      p <- p + geom_errorbar()
    } else if (error_bars == 'bands') {
      p <- p + geom_ribbon(alpha = 0.3)
    }
  }
  message("points = ", points)
  if (points) {
    message("points")
    p <- p + geom_point()
  }
  if (! is.null(pm_legend)) {
    message("legend")
    # message("adding legend ", pm_legend)
    p <- p + scale_colour_discrete(guide = guide_legend(pm_legend, reverse = TRUE))
    p <- p + scale_fill_discrete(guide = guide_legend(pm_legend, reverse = TRUE))
  }
  message("Labs = ",
          str_c(names(pm_labs), pm_labs, sep = ": ", collapse = ", "))
  p <- p + pm_labs
  p <- p + theme_bw(base_size = 20)
  message("Done making plot")
  p
}
