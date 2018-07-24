library(R6)

AbstractBmi <- R6Class(
  public = list(
    initialize = function(config_file) stop('Not implemented'),
    getTimeUnits <- function() stop('Not implemented'),
    getTimeStep <- function() stop('Not implemented'),
    getStartTime <- function() stop('Not implemented'),
    getEndTime <- function() stop('Not implemented'),
    getCurrentTime <- function() stop('Not implemented'),
    updateUntil <- function(until) stop('Not implemented'),
  )
)
