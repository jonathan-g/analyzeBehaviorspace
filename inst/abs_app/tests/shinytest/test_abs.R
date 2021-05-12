timeout <-  5
env_timeout <- Sys.getenv("_SHINY_APP_LOAD_TIMEOUT_") %>% stringr::str_trim()
if (env_timeout != "") {
  if (stringr::str_detect(env_timeout, "^[0-9]+$")) {
    timeout <- as.numeric(env_timeout)
    message("Timeout = ", timeout)
  }
}
timeout <- timeout * 1000
app <- ShinyDriver$new("../../", loadTimeout = timeout,
                       phantomTimeout = timeout)
app$snapshotInit("test_abs")

app$snapshot()

app$uploadFile(file1 = "../../../test_data/butterfly_small-experiment-table.csv") # <-- This should be the path to the file, relative to the app's tests/shinytest directory
app$snapshot()

app$setInputs(last_tick = TRUE)
app$setInputs(x_var = "corridor_width", wait_ = FALSE, values_ = FALSE)
app$setInputs(y_var = "mean_elevation_of_turtles", wait_ = FALSE,
              values_ = FALSE)
app$setInputs(group_var = "q", wait_ = FALSE, values_ = FALSE)
app$setInputs(lines = TRUE, wait_ = FALSE, values_ = FALSE)
app$setInputs(points = TRUE, wait_ = FALSE, values_ = FALSE)
app$setInputs(error_bars = "none", wait_ = TRUE, values_ = TRUE,
              timeout_ = timeout)
app$snapshot()

app$setInputs(ren_from = "corridor_width", wait_ = TRUE, values_ = TRUE)
app$setInputs(ren_to = "corridor width", wait_ = TRUE, values_ = TRUE)
app$setInputs(rename = "click", wait_ = TRUE, values_ = TRUE,
              timeout_ = timeout)
app$setInputs(ren_from = "mean_elevation_of_turtles", wait_ = TRUE,
              values_ = TRUE)
app$setInputs(ren_to = "elevation", wait_ = TRUE, values_ = TRUE)
app$setInputs(rename = "click", wait_ = TRUE, values_ = TRUE,
              timeout_ = timeout)
app$setInputs(group_var = "q", wait_ = TRUE, values_ = TRUE,
              timeout_ = timeout)
app$setInputs(summary_tab = TRUE, wait_ = TRUE, values_ = TRUE,
              timeout_ = timeout)
app$snapshot()
