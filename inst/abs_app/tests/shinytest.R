library(tidyverse)
library(shinytest)
os_type = osName()
message("OS version = ", os_type)
shinytest::testApp("..", suffix = os_type)

