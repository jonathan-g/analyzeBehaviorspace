.onAttach <- function(...) {
  ver <- utils::packageVersion("analyzeBehaviorspace")
  msg <- paste0("\nThis is analyzeBehaviorspace version ", ver, "\n")
  packageStartupMessage(msg)
}

.onLoad <- function(libname, pkgname) {
  op <- options()
  op.analyze_behaviorspace <- list(
    analyze_behaviorspace.rstudio = FALSE
  )
  set_ops <- !(names(op.analyze_behaviorspace) %in% names(op))
  if (any(set_ops)) options(op.analyze_behaviorspace[set_ops])
  invisible()
}

