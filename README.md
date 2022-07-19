# analyzeBehaviorspace

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check with
{renv}](https://github.com/jonathan-g/analyzeBehaviorspace/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jonathan-g/analyzeBehaviorspace/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

This is a shiny app to analyze table output from NetLogo BehaviorSpace
experiments.

NetLogo outputs `.csv` files from BehaviorSpace runs that are very
annoying to analyze in Excel because of the limited functionality of
Excel pivot tables. This application reads in a `.csv` file from a
BehaviorSpace run (use the *table* option for output, not *spreadsheet*)
and allows the user to summarize the output by up to two variables, and
generate plots and summary tables, both of which can be exported.

To use the app, you need R version 3.3 or later.

To install `analyzeBehaviorspace`, start R and type the following lines:

    if (!require(devtools)) install.packages(devtools)
    devtools::install_github('jonathan-g/analyzeBehaviorspace')

after you have done that once, you can run `analyzeBehaviorspace` by
starting R and typing the following:

    library(analyzeBehaviorspace)
    launch_abs()

The app should start running, and open the `analyzeBehaviorspace` app in
your web browser. When the app is running, load a `.csv` file containing
the table output from a BehaviorSpace run. Then you will see a table of
values for all the control and output variables at each tick of each
BehaviorSpace run. You can generate summary plots and tables by choosing
variables for the *x* and *y* axes and a grouping variable (if you
choose a grouping variable, each different value of that variable will
be represented by a different color in the plots).

The graph will plot the mean value of the *y* variable for each value of
the *x* variable (grouped by each value of the grouping variable if one
is chosen). You can select whether to show points, lines, or both, and
whether to just show the mean values of the *y* variable or to show
error bars as well (error bars show plus and minus one standard
deviation of the *y* variable).

If you check the `Summary table` box, the table will show the mean value
and standard deviation of the *y* variable for each combination of the
*x* and grouping variables.

You can download the plots (as `.png` images) and the summary table (as
`.csv` files).
