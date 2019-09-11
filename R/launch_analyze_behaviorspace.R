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

#' Launch the analyzeBehaviorspace app
#'
#' Launch the analyzeBehaviorspace app in the default web browser. RStudio
#' users also have the option of launching the app in RStudio's pop-up Viewer.
#'
#' @export
#' @param rstudio Only relevant for RStudio users. The default (\code{FALSE}) is
#'   to launch the app in the user's default web browser rather than RStudio's
#'   pop-up Viewer. Users can change the default to \code{TRUE} by setting the
#'   global option \code{options(shinystan.rstudio = TRUE)}.
#' @param ... Optional arguments passed to \code{\link[shiny]{runApp}}.
#'
#' @return Nothing is returned
#'
#'
#' @examples
#' \dontrun{
#' launch_abs()
#' }
#'
launch_abs <- function(rstudio = getOption("analyze_behaviorspace.rstudio"), ...) {
  message("\nLaunching analyzeBehaviorspace interface.")
  invisible(launch(rstudio, ...))
}

# Internal launch function
# @param rstudio launch in rstudio viewer instead of web browser?
# @param ... passed to shiny::runApp
launch <- function(rstudio = FALSE, ...) {
  launch.browser <- if (!rstudio)
    TRUE else getOption("shiny.launch.browser", interactive())

  shiny::runApp(system.file("abs_app", package = "analyzeBehaviorspace"),
                launch.browser = launch.browser, ...)
  invisible()
}
