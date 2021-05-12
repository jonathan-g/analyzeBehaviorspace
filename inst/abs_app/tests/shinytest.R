library(shinytest)
shinytest::testApp(
  "../",
  suffix = stringr::str_split(utils::osVersion, " ")[[1]][1])
