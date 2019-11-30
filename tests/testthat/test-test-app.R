context("app-file")
library(shinytest)
test_that("analyzeBehaviorspace works", {
  skip_on_cran()

  appdir <- system.file("abs_app", package="analyzeBehaviorspace")
  expect_true(dir.exists(!!appdir))
  expect_pass(testApp(appdir, compareImages = FALSE, interactive = FALSE))
})
