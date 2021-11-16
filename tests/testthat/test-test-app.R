context("app-file")
test_that("analyzeBehaviorspace works", {
  skip_on_cran()

  appdir <- system.file("abs_app", package="analyzeBehaviorspace")
  # appdir <- "../../inst/abs_app"
  appdir <- normalizePath(appdir, winslash = "/")
  message("appdir = ", appdir)
  os_type <- stringr::str_split(utils::osVersion, " ")[[1]][1]
  # expect_equal(appdir, "D:/JG_Documents/programming/Teaching/teaching_projects/analyzeBehaviorspace/inst/abs_app")
  expect_true(dir.exists(appdir))
  expect_true(
    dir.exists(file.path(appdir, "tests", "shinytest",
                         stringr::str_c("test_abs-expected-", os_type)))
    )
  if (require(shinytest)) {
    os_type = stringr::str_split(utils::osVersion, " ")[[1]][1]
    message("OS version = ", os_type)
    expect_pass(
      testApp(appdir, compareImages = FALSE, interactive = FALSE,
              suffix = os_type, quiet = TRUE)
    )
  }
})
