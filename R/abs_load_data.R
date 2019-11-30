library(dplyr)
library(purrr)
library(tidyr)
library(readr)
library(stringr)
library(janitor)

is_bs_table <- function(text, skip_lines) {
  df <- read_csv(text, skip = skip_lines + 1, col_names = FALSE)
  message("X1 = ", class(df$X1))
  return(is.numeric(df$X1))
}

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
  dep_vars <-  utils::tail(nn, -tick)
  list(ind_vars = ind_vars, dep_vars = dep_vars)
}


#' Load output from a NetLogo Behaviorspace experiment
#'
#' \code{load_bs_table} loads the table output from a NetLogo Behaviorspace
#' experiment.
#'
#' This function loads and decodes table output from a NetLogo Behaviorspace
#' experiment. It can take either a filename or the text contents of such a
#' file.
#'
#' @param filename The name of a Behaviorspace table output file (\code{.csv}
#'   format).
#' @param text Text contents of a Behaviorspace table output file (\code{.csv}
#'   format).
#' @param quiet Logical value indicating whether to run quietly or report
#'   progress messages.
#' @return A named list with elements:
#' * \code{data}: a data frame containing the experiment data.
#' * \code{ind_vars}: a character vector with the names of the independent
#'   variables.
#' * \code{dep_vars}: a character vector with the names of the dependent
#'   variables.
#' * \code{mapping}: a data frame mapping columns in \code{data} to variable
#'   names. By default, this just maps column names to themselves.
#' * \code{success}: A logical variable indicating success or failure.
#' * \code{cause}: A character variable indicating the cause of failure.
#' @examples
#' \dontrun{
#'   load_bs_table(
#'     system.file("test_data/butterfly_small-experiment-table.csv",
#'       "analyzeBehaviorspace", mustWork = TRUE)
#'     )
#' }
#' @export
load_bs_table <- function(filename, text = NULL, quiet = TRUE) {
  if (! missing(filename)) {
    text <- read_file(filename)
  }
  ret_fail <- list(data = NULL, ind_vars = NULL, dep_vars = NULL,
                   mapping = NULL, success = FALSE,
                   cause = character(0))

  text_lines <- text %>%  str_split('\n') %>% simplify()

  if (! quiet) {
    message("File length = ", str_length(text), ": Split into ", length(text_lines), " lines.")
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

  if (!quiet) {
    message("Names = (", str_c(names(d), collapse = ", "), ")")
  }

  num_vars <- d %>% map_lgl(is.numeric) %>% keep(~.x) %>% names()
  factor_vars <- d %>% map_lgl(is.numeric) %>% discard(~.x) %>% names()

  if (!quiet) {
    message("numeric columns = ", paste(num_vars, collapse = ", "))
    message("factor columns = ", paste(factor_vars, collapse = ", "))
  }

  #d <- d %>% select_(.dots = num_vars) %>%
  f <- function(x) { ! is.numeric(x)}
  if (length(factor_vars) > 0) {
    d <- d %>% mutate_if(f, funs(factor(.data$.)))
  }
  d <- d %>% arrange(.data$run, .data$tick)
  names(d) <- str_replace_all(names(d), '\\.+','.')
  num_vars <- d %>% map_lgl(is.numeric) %>% keep(~.x) %>% names()
  factor_vars <- d %>% map_lgl(is.numeric) %>% discard(~.x) %>% names()

  if (!quiet) {
    message("numeric columns = ", paste(num_vars, collapse = ", "))
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
