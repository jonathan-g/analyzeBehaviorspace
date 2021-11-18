context("app-file")
test_that("analyzeBehaviorspace works", {
  skip_on_cran()

  appdir <- system.file("abs_app", package="analyzeBehaviorspace")
  appdir <- normalizePath(appdir, winslash = "/")
  message("appdir = ", appdir)
  os_type <- stringr::str_split(utils::osVersion, " ")[[1]][1]
  message("OS version = ", os_type)
  expect_true(dir.exists(appdir), info = "app dir exists.")
  resdir <- file.path(appdir, "tests", "shinytest",
                      stringr::str_c("test_abs-expected-", os_type))
  expect_true(
    dir.exists(resdir), info = "expected test results directory exists.")
  if (require(shinytest)) {
    expect_pass(
      testApp(appdir, suffix = os_type, quiet = TRUE,
              compareImages = FALSE, interactive = FALSE),
      info = "shinytest passes."
    )
  }
})
