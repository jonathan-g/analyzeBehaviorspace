library(testthat)
library(analyzeBehaviorspace)

# appdir <- system.file("abs_app", package="analyzeBehaviorspace")
# appdir <- normalizePath(appdir, winslash = "/")
# message("appdir = ", appdir)

test_check("analyzeBehaviorspace", reporter = "summary")
