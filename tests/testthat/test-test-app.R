context("app-file")
test_that("analyzeBehaviorspace works", {
  skip_on_cran()

  appdir <- system.file("abs_app", package="analyzeBehaviorspace")
  # appdir <- "../../inst/abs_app"
  appdir <- normalizePath(appdir, winslash = "/")
  message("appdir = ", appdir)
  # expect_equal(appdir, "D:/JG_Documents/programming/Teaching/teaching_projects/analyzeBehaviorspace/inst/abs_app")
  expect_true(dir.exists(appdir))
  if (require(shinytest)) {
    os_type = stringr::str_split(utils::osVersion, " ")[[1]][1]
    message("OS version = ", os_type)
    expect_pass(testApp(appdir, compareImages = FALSE, interactive = FALSE,
                        suffix = os_type))
  }
})
