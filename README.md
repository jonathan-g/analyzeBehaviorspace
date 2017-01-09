# analyzeBehaviorspace

This is a shiny app to analyze table output from NetLogo BehaviorSpace 
experiments. 

NetLogo outputs `.csv` files from BehaviorSpace runs that are very annoying to
analyze in Excel because of the limited functionality of Excel pivot tables.
This application reads in a `.csv` file from a BehaviorSpace run (use the
_table_ option for output, not _spreadsheet_) and allows the user to summarize
the output by up to two variables, and generate plots and summary tables, 
both of which can be exported.

To use the app, install it in R:
```
devtools::install_github('jonathan-g/analyzeBehaviorspace')
```
and then from R, do:
```
library(analyzeBehaviorspace)
launch_abs()
```
