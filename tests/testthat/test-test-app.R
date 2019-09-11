context("app-file")
library(shinytest)
library(stringr)
test_that("analyzeBehaviorspace works", {
  skip_on_cran()

  appdir <- system.file(package="analyzeBehaviorspace", "analyzeBehaviorspace")
  expect_pass(testApp(appdir, compareImages = FALSE))
})
