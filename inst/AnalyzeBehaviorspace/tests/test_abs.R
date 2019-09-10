app <- ShinyDriver$new("../")
app$snapshotInit("test_abs")

app$snapshot()
app$uploadFile(file1 = "../../test_data/butterfly_class_06a_vary-q-all-steps-table.csv") # <-- This should be the path to the file, relative to the app's tests/ directory
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(x_var = "tick", wait_=FALSE, values_=FALSE)
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$setInputs(y_var = "corridor_width", wait_=FALSE, values_=FALSE)
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$setInputs(points = FALSE, wait_=FALSE, values_=FALSE)
app$setInputs(lines = TRUE, wait_=FALSE, values_=FALSE)
app$setInputs(group_var = "q")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()
# Input '`plotly_hover-A`' was set, but doesn't have an input binding.
# Input '`plotly_hover-A`' was set, but doesn't have an input binding.
app$setInputs(ren_from = "corridor_width", wait_=FALSE, values_=FALSE)
app$setInputs(ren_to = "corridor width", wait_=FALSE, values_=FALSE)
app$setInputs(rename = "click")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$setInputs(ren_from = "mean_elevation_of_turtles", wait_=FALSE, values_=FALSE)
app$setInputs(ren_to = "elevation", wait_=FALSE, values_=FALSE)
app$setInputs(rename = "click")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$setInputs(x_var = "corridor_width", wait_=FALSE, values_=FALSE)
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$setInputs(y_var = "mean_elevation_of_turtles", wait_=FALSE, values_=FALSE)
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$setInputs(last_tick = TRUE)
app$setInputs(summary_tab = TRUE)
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$setInputs(points = TRUE)
app$setInputs(points = FALSE)
app$setInputs(group_var = "q", wait_=FALSE, values_=FALSE)
app$setInputs(points = TRUE)
app$setInputs(lines = FALSE)
app$snapshot()
