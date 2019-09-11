context("app-file")
library(shinytest)
library(stringr)
test_that("analyzeBehaviorspace works", {
  skip_on_cran()

  appdir <- system.file(package="analyzeBehaviorspace", "analyzeBehaviorspace")
  warning("appdir = ", appdir)
  warning("appdir contains [", str_c(list.files(appdir), collapse = ", "), "]")
  expect_pass(testApp(appdir, compareImages = FALSE))
})
