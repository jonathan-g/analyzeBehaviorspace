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
