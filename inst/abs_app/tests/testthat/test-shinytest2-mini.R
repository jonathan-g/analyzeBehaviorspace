library(shinytest2)

test_that("{shinytest2-mini} recording: Mini test suite", {
  app <- AppDriver$new(variant = platform_variant(),
      seed = 12345678, height = 1009, width = 1167,
      wait = TRUE,
      screenshot_args = list(selector = ".plot", delay = 1.0),
      expect_values_screenshot_args = FALSE)
  app$upload_file(file1 = "../../../test_data/butterfly_small-experiment-table.csv")
  app$expect_values(name = "initial", screenshot_args = FALSE)
  app$set_inputs(ren_from = "corridor_width")
  app$set_inputs(ren_to = "Corridor width")
  app$click("rename")
  app$expect_values(name = "rename-cw", screenshot_args = FALSE)
  app$set_inputs(ren_from = "mean_elevation_of_turtles")
  app$set_inputs(ren_to = "Elevation")
  app$click("rename")
  app$expect_values(name = "rename-elev", screenshot_args = FALSE)
  app$set_inputs(x_var = "q")
  app$set_inputs(y_var = "corridor_width")
  app$set_inputs(points = TRUE)
  app$set_inputs(lines = TRUE)
  app$set_inputs(error_bars = "error bars")
  # app$expect_screenshot(delay = 1.0, selector=".plot", name="points-lines-error-bars")
  app$set_inputs(error_bars = "bands")
  # app$expect_screenshot(delay = 1.0, selector=".plot", name="points-lines-error-bands")
  app$set_inputs(x_var = "corridor_width")
  app$set_inputs(y_var = "mean_elevation_of_turtles")
  app$set_inputs(group_var = "q")
  app$set_inputs(summary_tab = TRUE)
  # app$expect_screenshot(delay = 1.0, selector=".plot", name="cw-vs-elev-by-q")
  app$expect_values(name="final-values", screenshot_args = FALSE)
})
