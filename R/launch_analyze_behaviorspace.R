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
#' @param rstudio Only relevant for RStudio users. The default (`FALSE`) is
#'   to launch the app in the user's default web browser rather than RStudio's
#'   pop-up Viewer. Users can change the default to `TRUE` by setting the
#'   global option `options(analyze_behaviorspace.rstudio = TRUE)`.
#' @param maxFileSize The maximum file size that can be uploaded to the shiny
#'   app (in megabytes). The default can be changed by setting the global option
#'   `analyze_behaviorspace.maxFileSize`
#'   (`options(analyze_behaviorspace.maxFileSize = 1000)`).
#' @param ... Optional arguments passed to [shiny::runApp()].
#'
#' @return Nothing is returned
#'
#'
#' @examples
#' \dontrun{
#' launch_abs()
#' }
#'
launch_abs <- function(rstudio = getOption("analyze_behaviorspace.rstudio",
                                           default = FALSE),
                       maxFileSize =
                         getOption('analyze_behaviorspace.maxFileSize',
                                               default = 300),
                       ...) {
  message("\nLaunching analyzeBehaviorspace interface.")
  invisible(launch(rstudio, maxFileSize, ...))
}

#' Internal launch function
#' @param rstudio launch in rstudio viewer instead of web browser?
#' @param ... passed to shiny::runApp
#' @noRd
#'
launch <- function(rstudio = FALSE, maxFileSize = NULL, ...) {
  launch.browser <- {
    if (!rstudio)
      TRUE
    else
      getOption("shiny.launch.browser", interactive())
  }

  if (! is.null(maxFileSize)) {
    mfs = maxFileSize * 1024^2
    options(shiny.maxRequestSize = mfs,
            analyze_behaviorspace.maxFileSize = mfs)
  }

  app <- app_fn(...)
  runApp(app)
  invisible(NULL)
}
