test_that("directories exist", {
  skip_on_cran()
  skip_if(Sys.getenv("CI") == "true" &&
            Sys.getenv("GITHUB_JOB") == "R-CMD-check" &&
            Sys.getenv("RUNNER_OS") == "Linux")

  if (require(shinytest2)) {
    appdir <- system.file("abs_app", package="analyzeBehaviorspace")
    appdir <- normalizePath(appdir, winslash = "/")
    plat_var <- shinytest2::platform_variant()
    expect_true(dir.exists(appdir), info = "app dir exists.")
    resdir <- file.path(appdir, "tests", "testthat", "_snaps", plat_var)
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
  if (require(shinytest2)) {
    plat_var <- shinytest2::platform_variant()
    expect_true(dir.exists(appdir), info = "app dir exists.")
    resdir <- file.path(appdir, "tests", "testthat", "_snaps", plat_var)
    if(isTRUE(dir.exists(resdir))) {
      shinytest2::test_app(appdir)
    }
  }
})
