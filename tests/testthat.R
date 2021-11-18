library(testthat)
library(analyzeBehaviorspace)

appdir <- system.file("abs_app", package="analyzeBehaviorspace")
appdir <- normalizePath(appdir, winslash = "/")
message("appdir = ", appdir)

os_type <- stringr::str_split(utils::osVersion, " ")[[1]][1]
message("OS version = ", os_type)

test_check("analyzeBehaviorspace", reporter = "summary")
