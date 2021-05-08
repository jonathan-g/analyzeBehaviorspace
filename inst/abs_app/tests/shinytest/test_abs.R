app <- ShinyDriver$new("../../")
app$snapshotInit("test_abs")

app$snapshot()

app$uploadFile(file1 = "../../../test_data/butterfly_small-experiment-table.csv") # <-- This should be the path to the file, relative to the app's tests/shinytest directory
app$snapshot()

app$setInputs(last_tick = TRUE)
app$setInputs(x_var = "corridor_width", wait_ = FALSE, values_ = FALSE)
app$setInputs(y_var = "mean_elevation_of_turtles", wait_ = FALSE, values_ = FALSE)
app$setInputs(group_var = "q", wait_ = FALSE, values_ = FALSE)
app$setInputs(lines = TRUE, wait_ = FALSE, values_ = FALSE)
app$setInputs(points = TRUE)
app$snapshot()

app$setInputs(ren_from = "corridor_width", wait_ = FALSE, values_ = FALSE)
app$setInputs(ren_to = "corridor width", wait_ = FALSE, values_ = FALSE)
app$setInputs(rename = "click", wait_ = FALSE, values_ = FALSE)
app$setInputs(ren_from = "mean_elevation_of_turtles", wait_ = FALSE, values_ = FALSE)
app$setInputs(ren_to = "elevation", wait_ = FALSE, values_ = FALSE)
app$setInputs(rename = "click", wait_ = FALSE, values_ = FALSE)
app$setInputs(group_var = "q", wait_ = FALSE, values_ = FALSE)
app$setInputs(summary_tab = TRUE)
app$snapshot()
