#' Load output from a NetLogo BehaviorSpace experiment
#'
#' Loads the output from a NetLogo BehaviorSpace zexperiment.
#'
#' This function loads and decodes table output from a NetLogo BehaviorSpace
#' experiment. It can take either a filename or the text contents of such a
#' file.
#'
#' @param filename The name of a BehaviorSpace table output file (`.csv`
#'   format).
#' @param text Text contents of a BehaviorSpace table output file (`.csv`
#'   format).
#' @param quiet Logical value indicating whether to run quietly or report
#'   progress messages.
#' @return A named list with elements:
#' * `data`: a data frame containing the experiment data.
#' * `ind_vars`: a character vector with the names of the independent
#'   variables.
#' * `dep_vars`: a character vector with the names of the dependent
#'   variables.
#' * `mapping`: a data frame mapping columns in `data` to variable
#'   names. By default, this just maps column names to themselves.
#' * `success`: A logical variable indicating success or failure.
#' * `cause`: A character variable indicating the cause of failure.
#' @examples
#' \dontrun{
#'   load_bs_file(
#'     system.file("test_data/butterfly_small-experiment-table.csv",
#'       "analyzeBehaviorspace", mustWork = TRUE)
#'     )
#' }
#'
#' @export
#'
load_bs_file <- function(filename = NULL, text = NULL, quiet = TRUE) {
  if (! (missing(filename) || is.null(filename) || is.na(filename))) {
    text <- read_file(filename)
  }
  ret_fail <- list(data = NULL, ind_vars = NULL, dep_vars = NULL,
                   mapping = NULL, success = FALSE,
                   cause = character(0))

  text_lines <- text %>%  str_split('\n') %>% simplify()

  if (! quiet) {
    message("File length = ", str_length(text), ": Split into ",
            length(text_lines), " lines.")
  }

  skip_lines <- which(str_detect(text_lines, '^"?\\[run number\\]"?'))
  if (length(skip_lines) == 0) {
    ret_fail$cause = "not_bs"

    return(ret_fail)
  }

  skip_lines = skip_lines[1] - 1

  if (!quiet) {
    message("Skip lines = ", skip_lines)
  }

  if (is_bs_table(text, skip_lines)) {
    message("Loading BehaviorSpace Table")
    return(load_bs_table(text = text, quiet = quiet)) # nolint
  } else {
    message("Loading BehaviorSpace Spreadsheet")
    return(load_bs_spreadsheet(text = text, quiet = quiet)) # nolint
  }
}

#' Determine whether a csv file is a BehaviorSpace experiment table
#'
#' Given the text from a .csv file, determine whether it corresponds to a
#' the table format for a BehaviorSpace experiment
#'
#' @param text The contents of the .csv file.
#' @param skip_lines The number of lines to skip before starting to read the
#' data.
#'
#' @return Logical: `TRUE` means it is in the table format.
#' @export
#'
is_bs_table <- function(text, skip_lines) {
  df <- read_csv(text, skip = skip_lines + 1, col_names = FALSE)
  message("X1 = ", class(df$X1))
  return(is.numeric(df$X1))
}


#' Classify BehaviorSpace experiment variables into independent and dependent.
#'
#' Classify variables in a BehaviorSpace experiment data frame into
#' dependent and independent. This function uses the fact that BehaviorSpace
#' puts the independent variable columns before the `[steps]` column, and the
#' dependent variables after.
#'
#' @param df The data frame from a BehaviorSpace experiment.
#'
#' @return A named list containing character vectors of independent and
#' dependent variables.
#' @export
#'
classify_vars <- function(df) {
  message("classify_vars")
  n <- colnames(df)
  nn <- df %>%
    dplyr::select(tidyselect::vars_select_helpers$where(is.numeric)) %>%
    names()
  run <- which(n == 'run')
  tick <- which(n == 'tick')
  ind_vars <- character(0)
  if (tick > run + 1) {
    ind_vars <- n[(run + 1):(tick - 1)]
  }
  tick2 <- which(nn == 'tick')
  dep_vars <-  utils::tail(nn, -tick2)
  list(ind_vars = ind_vars, dep_vars = dep_vars)
}


#' @describeIn load_bs_file Load a BehaviorSpace experiment in table
#'   format.
#'
#' @export
#'
load_bs_table <- function(filename = NULL, text = NULL, quiet = TRUE) {
  if (! (missing(filename) || is.null(filename) || is.na(filename))) {
    text <- read_file(filename)
  }
  ret_fail <- list(data = NULL, ind_vars = NULL, dep_vars = NULL,
                   mapping = NULL, success = FALSE,
                   cause = character(0))

  text_lines <- text %>%  str_split('\n') %>% simplify()

  if (! quiet) {
    message("File length = ", str_length(text), ": Split into ",
            length(text_lines), " lines.")
  }

  skip_lines <- which(str_detect(text_lines, '^"?\\[run number\\]"?'))
  if (length(skip_lines) == 0) {
    ret_fail$cause = "not_bs"

    return(ret_fail)
  }

  skip_lines = skip_lines[1] - 1

  if (!quiet) {
    message("Skip lines = ", skip_lines)
  }

  if (! is_bs_table(text, skip_lines)) {
    ret_fail$cause = "spreadsheet"
    return(ret_fail)
  }

  if (!quiet) {
    message("File is a BS table")
  }

  d <- read_csv(text, skip = skip_lines, n_max = 100)

  nm <- names(d) %>% make_clean_names(case = "snake") %>%
    str_replace_all(c('^_+' = '', '_+$' = '')) %>%
    str_replace_all(c('^run_number$' = 'run', '^step$' = 'tick'))
  nc <- length(nm)
  spec <- rep_len('?', length(nm))
  spec <- str_c(spec, collapse = '')

  d <- read_csv(text, skip = skip_lines + 1,
                col_names = nm, col_types = spec,
                guess_max = round(length(text_lines) / 2))
  if (any(duplicated(names(d)))) {
    d <- d[,-which(duplicated(names(d)))]
  }
  ret <- process_bs_data(d, quiet)
  invisible(ret)
}

#' Process data from a BehaviorSpace `.csv` file.
#'
#' `process_bs_data()` takes a data frame read from a `.csv` file with
#' BehaviorSpace output and organizes it into an R representation of
#' a BehaviorSpace experiment.
#'
#' This function is generally not run by the user, but is called internally
#' by [load_bs_file()], [load_bs_table()], or [load_bs_spreadsheet()].
#'
#' @param d A data frame read from a BehaviorSpace .csv file.
#' @param quiet Suppress informational messages.
#'
#' @param quiet Logical value indicating whether to run quietly or report
#'   progress messages.
#' @return A named list with elements:
#' * `data`: a data frame containing the experiment data.
#' * `ind_vars`: a character vector with the names of the independent
#'   variables.
#' * `dep_vars`: a character vector with the names of the dependent
#'   variables.
#' * `mapping`: a data frame mapping columns in `data` to variable
#'   names. By default, this just maps column names to themselves.
#' * `success`: A logical variable indicating success or failure.
#' * `cause`: A character variable indicating the cause of failure.
#' @seealso [load_bs_file()], [load_bs_table()], and [load_bs_spreadsheet()].
#' @export
#'
process_bs_data <- function(d, quiet = TRUE) {
  if (!quiet) {
    message("Names = (", str_c(names(d), collapse = ", "), ")")
  }

  num_vars <- d %>% keep(is.numeric) %>% names()
  lgl_vars <- d %>% keep(is.logical) %>% names()
  factor_vars <- d %>% discard(~is.numeric(.x) | is.logical(.x)) %>% names()

  if (!quiet) {
    message("numeric columns = ", paste(num_vars, collapse = ", "))
    message("logical columns = ", paste(lgl_vars, collapse = ", "))
    message("factor columns = ", paste(factor_vars, collapse = ", "))
  }

  if (length(factor_vars) > 0) {
    d <- d %>% mutate(across(all_of(factor_vars), factor))
  }
  d <- d %>% arrange(.data$run, .data$tick)
  names(d) <- str_replace_all(names(d), '\\.+','.')
  num_vars <- d %>% keep(is.numeric) %>% names()
  lgl_vars <- d %>% keep(is.logical) %>% names()
  factor_vars <- d %>% discard(~is.numeric(.x) | is.logical(.x)) %>% names()

  if (!quiet) {
    message("numeric columns = ", paste(num_vars, collapse = ", "))
    message("logical columns = ", paste(lgl_vars, collapse = ", "))
    message("factor columns = ", paste(factor_vars, collapse = ", "))
  }

  vars <- classify_vars(d)

  if (!quiet) {
    message("ind_vars = ", paste(vars$ind_vars, collapse = ", "))
    message("dep_vars = ", paste(vars$dep_vars, collapse = ", "))
    message("Done loading data: ", nrow(d), " rows.")
  }

  invisible(list(data = d, ind_vars = vars$ind_vars, dep_vars = vars$dep_vars,
                 mapping = tibble(col = names(d), name = names(d)),
                 success = TRUE, cause = character(0)))

}

#' @describeIn load_bs_file Load a BehaviorSpace experiment in spreadsheet
#'   format.
#'
#' @export
#'
load_bs_spreadsheet <- function(filename = NULL, text = NULL, quiet = TRUE) {
  if (! (missing(filename) || is.null(filename) || is.na(filename))) {
    text <- read_file(filename)
  }
  ret_fail <- list(data = NULL, ind_vars = NULL, dep_vars = NULL,
                   mapping = NULL, success = FALSE,
                   cause = character(0))

  text_lines <- text %>% stringr::str_split('\n') %>% simplify()

  if (! quiet) {
    message("File length = ", stringr::str_length(text), ": Split into ",
            length(text_lines), " lines.")
  }

  skip_lines <- which(stringr::str_detect(text_lines, '^"?\\[run number\\]"?'))
  if (length(skip_lines) == 0) {
    ret_fail$cause = "not_bs"

    return(ret_fail)
  }

  skip_lines = skip_lines[1] - 1

  if (!quiet) {
    message("Skip lines = ", skip_lines)
  }

  if (is_bs_table(text, skip_lines)) {
    ret_fail$cause = "table"
    return(ret_fail)
  }

  if (!quiet) {
    message("File is a BS spreadsheet")
  }

  d <- read_csv(text, skip = skip_lines, col_names = FALSE,
                col_types = cols(.default = col_character())) %>%
    tidyr::pivot_longer(-"X1", names_to = "foo", values_to = "value") %>%
    tidyr::pivot_wider(names_from = "X1", values_from = "value") %>%
    janitor::clean_names() %>%
    dplyr::rename(run = "run_number", tick = "steps") %>%
    dplyr::relocate("tick", .after = last_col())
  dep_vars <- unique(d$initial_final_values) %>% na.omit() %>%
    janitor::make_clean_names("snake")
  d <- d %>%
    tidyr::pivot_wider(names_from = "initial_final_values",
                       values_from = "na") %>%
    janitor::clean_names() %>%
    dplyr::select(-"foo") %>%
    dplyr::group_by(.data$run, .data$tick) %>%
    dplyr::summarize(across(everything(), ~unique(na.omit(.x))),
                     .groups = "drop") %>%
    dplyr::mutate(across(everything(), parse_guess)) %>%
    dplyr::relocate("tick", any_of(dep_vars), .after = last_col())

  ret <- process_bs_data(d, quiet)
  invisible(ret)
}

