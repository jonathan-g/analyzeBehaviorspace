
#' Identify the columns of a data frame with at least two different values
#'
#' From a data frame get the columns with more than one distinct value.
#'
#' @param df A data frame.
#' @param col_names A vector of column names to inspect.
#'
#' @return A named logical vector where `TRUE` means there is more than one
#'  distinct value in the column.
#' @export
#'
count_unique <- function(df, col_names = NULL) {
  if (! is.null(col_names)) {
    df <- df %>% select(all_of(col_names))
  }
  df %>% map_lgl(~length(unique(.x)) > 1)
}


#' Extract the rows of a data frame with the last tick from each run
#'
#' Extract the rows of a data frame with the last tick from each run.
#'
#' @param df The data frame.
#'
#' @return A data frame with one row for each run, corresponding to the last
#'  tick for that run.
#' @export
#'
extract_last_tick <- function(df) {
  # lt_vars <- c('run', vars) %>% discard(~.x == 'tick')
  # message("lt_vars = ", paste(lt_vars, collapse = ', '))
  # lt_syms <- syms(lt_vars)
  # df %>% group_by(!!!lt_syms) %>%
  df %>% dplyr::group_by(.data$run) %>%
    dplyr::slice_max(.data$tick, n = 1, with_ties = FALSE) %>%
    dplyr::ungroup() %>%
    invisible()
}


#' Make a BehaviorSpace experiment object.
#'
#' Make a BehaviorSpace experiment object.
#'
#' @param data A data frame.
#' @param ind_vars A character vector with the names of the independent
#'  variables.
#' @param dep_vars A character vector with the names of the dependent variables.
#' @param mapping A data frame with a mapping between column names in `data`
#'  and a name to use in the Shiny app and for plot axes.
#'
#' @return An experiment object. This is a named list with:
#' * `data`: a data frame,
#' * `ind_vars`: A character vector with the names of the independent variables.
#' * `dep_vars`: A character vector with the names of the dependent variables
#' * `mapping`: A data frame with a mapping between column names in `data` and
#'   names to use for plot axis labels, in the Shiny app, etc.
#' @export
#'
make_experiment <- function(data = NULL, ind_vars = NULL, dep_vars = NULL,
                            mapping = NULL) {
  experiment <- list(
    data = data,
    ind_vars = ind_vars,
    dep_vars = dep_vars,
    mapping = mapping
  )
  invisible(experiment)
}


#' Translate a text name to a column name in the experiment data frame
#'
#' Take a text name (e.g., something a variable has been renamed to in
#' AnalyzeBehaviorSpace) and translate it to a column name in the experiment
#' data frame.
#'
#' @param var_name The name of a variable.
#' @param mapping A mapping data frame from an experiment.
#'
#' @return The name of the data frame column corresponding to the variable name.
#' @export
#'
tx_name <- function(var_name, mapping) {
  mapping %>% dplyr::filter(.data$name == var_name) %>% dplyr::pull("col")
}

#' Translate a column name in the experiment data frame to text name.
#'
#' Take the name of a column in the experiment data frame and translate it to
#' a text name (e.g., something a variable has been renamed to in
#' AnalyzeBehaviorSpace) that can be used for labelling plots..
#'
#' @param var_col The name of a column in the experiment data frame.
#' @param mapping A mapping data frame from an experiment.
#'
#' @return The name of the variable corresponding to the chosen column.
#' @export
#'
tx_col <- function(var_col, mapping) {
  mapping %>% dplyr::filter(.data$col == var_col) %>% dplyr::pull("name")
}


#' Get the variables from an experiment
#'
#' Get the variables from a BehaviorSpace experiment.
#'
#' @param experiment An experiment object, returned by [load_bs_file()],
#'  [load_bs_table()], or [load_bs_spreadsheet()].
#'
#' @return A data frame with the names of the variables and the corresponding
#'   columns in the experiment data frame.
#' @export
#'
get_expt_vars <- function(experiment){
  df <- experiment$data
  vars <- experiment$mapping
  if (is.null(df) || is.null(vars)) return(NULL)
  message("data = ", stringr::str_c(class(df), collapse = ", "))
  message("mapping = ", stringr::str_c(names(vars), collapse = ", "))
  vars <- vars %>% dplyr::filter(!(.data$name %in% c('run')))
  vars <- vars %>%
    dplyr::filter( .data$col %>% as.character() %>%
                     purrr::map_lgl(~df %>% dplyr::pull(.x) %>% unique() %>%
                               length() > 1)
                   )
  message("expt_vars = (", stringr::str_c(vars$name, vars$col, sep = " = ",
                                          collapse = ", "), ")")
  vars
}

#' Get the possible y-variables from an experiment
#'
#' Given an x-variable to plot, get a list of the possible y-variables.
#'
#' @param experiment An experiment object, returned by [load_bs_file()],
#'  [load_bs_table()], or [load_bs_spreadsheet()].
#' @param x_var The name of the x-variable to use in the plot.
#'
#' @return A data frame with the names of the possible y-variables
#'   and the corresponding columns in the experiment data frame.
#' @export
#'
get_yvars <- function(experiment, x_var){
  vars <- get_expt_vars(experiment)
  if (is.null(vars)) return(NULL)
  vars <- vars %>% filter(col != x_var)
  message("expt_yvars = (", stringr::str_c(vars$name, vars$col, sep = " = ",
                                  collapse = ", "), ")")
  vars
}

#' Get the possible grouping variables from an experiment
#'
#' Given x- and y-variables to plot, get a list of the possible variables to
#' use in grouping the data for plotting. These variables are the independent
#' variables other than the y-variable.
#'
#' @param experiment An experiment object, returned by [load_bs_file()],
#'   [load_bs_table()], or [load_bs_spreadsheet()].
#' @param x_var  The name of the x-variable to use in the plot.
#' @param y_var  The name of the y-variable to use in the plot.
#'
#' @return A data frame with the names of the possible grouping variables
#'   and the corresponding columns in the experiment data frame.
#' @export
#'
get_group_vars <- function(experiment, x_var, y_var){
  vars <- get_expt_vars(experiment)
  ind_vars <- experiment$ind_vars
  if (any(is.null(vars), is.null(y_var), is.null(ind_vars))) return(NULL)
  vars <- vars %>% dplyr::filter(.data$col != y_var, .data$col %in% ind_vars)
  message("expt_group_ vars = (",
          stringr::str_c(vars$name, vars$col, sep = " = ",  collapse = ", "),
          ")")
  vars
}

#' Get the variables from an experiment that will not be used in a plot.
#'
#' Given x- and y-variables to plot, get a list of the other independent
#' variables that will not be used in the plot.
#'
#' @param experiment An experiment object, returned by [load_bs_file()],
#'  [load_bs_table()], or [load_bs_spreadsheet()].
#' @param x_var The name of the x-variable to use in the plot.
#' @param y_var The name of the x-variable to use in the plot.
#'
#' @return A data frame with the names of the independent variables that will
#'  not be plotted.
#' @export
#'
get_plot_vars <- function(experiment, x_var, y_var){
  ind_vars <- experiment$ind_vars
  dep_vars <- experiment$dep_vars
  vars <- get_yvars(experiment, x_var)
  if (any(is.null(y_var), is.null(ind_vars), is.null(dep_vars),
          is.null(vars)))
    return(NULL)
  vars <- vars %>% dplyr::filter(.data$name != y_var &
                                   .data$col %in% c(ind_vars, dep_vars))
  vars
}
