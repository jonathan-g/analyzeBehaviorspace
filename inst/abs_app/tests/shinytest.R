library(tidyverse)
library(shinytest)
os_type = stringr::str_split(utils::osVersion, " ")[[1]][1]
message("OS version = ", os_type)
shinytest::testApp("../", suffix = os_type)
