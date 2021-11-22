test_that("directories exist", {
  skip_on_cran()

  if (require(shinytest)) {
    appdir <- system.file("abs_app", package="analyzeBehaviorspace")
    appdir <- normalizePath(appdir, winslash = "/")
    message("appdir = ", appdir)
    os_type <- osName()
    message("OS version = ", os_type)
    expect_true(dir.exists(appdir), info = "app dir exists.")
    resdir <- file.path(appdir, "tests", "shinytest",
                        stringr::str_c("test_abs-expected-", os_type))
    expect_true(
      dir.exists(resdir),
      info = "expected test results directory exists."
    )
  }
})

test_that("analyzeBehaviorspace works", {
  skip_on_cran()

  appdir <- system.file("abs_app", package="analyzeBehaviorspace")
  appdir <- normalizePath(appdir, winslash = "/")
  message("appdir = ", appdir)
  if (require(shinytest)) {
    os_type <- osName()
    message("OS version = ", os_type)
    expect_true(dir.exists(appdir), info = "app dir exists.")
    resdir <- file.path(appdir, "tests", "shinytest",
                        stringr::str_c("test_abs-expected-", os_type))
    expect_true(
      dir.exists(resdir), info = "expected test results directory exists.")
    expect_pass(
      testApp(appdir, suffix = os_type, quiet = TRUE,
              compareImages = FALSE, interactive = FALSE),
      info = "shinytest passes."
    )
  }
})
