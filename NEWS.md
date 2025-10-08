# analyzeBehaviorspace 1.3.0

* Fix `load_bs_spreadsheet()` to work with spreadsheet output from
  NetLogo 6.4.0.

# analyzeBehaviorspace 1.2.0

* Update Shiny app structure to include `ui_fn()`, `server_fn()`, and
  `app_fn()` as parts of the package, rather than in free-standing 
  R scripts.
* Updated GitHub workflow to clean up name of R CMD check workflow.
  * Don't run shinytest2 tests with GitHub actions on Linux.
* Update lifecycle stage to stable.
* Clean up Roxygen metadata for package documentation

# analyzeBehaviorspace 1.1.0

* Add option to increase maximum upload file size.
* Migrate tests from shinytest to shinytest2.

# analyzebehaviorspace 1.0.0

* Add functions to package so they can be used outside the shiny app.

# analyzebehaviorspace 0.3.0

* Move a lot of functionality from Shiny server() function to regular R 
  functions to make debugging and testing easier.
* Add the ability to read data from a BehaviorSpace spreadsheet.
* Fix some breaking changes in dplyr.

# analyzebehaviorspace 0.2.0

* Updated to give an alert instead of crashing the app if a bad data file is 
  loaded (e.g., a spreadsheet instead of a table)
* Converted to use plotly via ggplotly for the graphic display.
* Updated DESCRIPTION to use component libraries from tidyverse instead of the 
  whole tidyverse. Added minimum version numbers.
* Added tests using shinytest and testthat.

# analyzeBehaviorspace 0.1.3

* Added a `NEWS.md` file to track changes to the package.
