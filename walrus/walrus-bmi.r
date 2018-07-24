
library(WALRUS)
library(configr)
library(R6)
source('abstract-bmi.r')

WalrusBmi <- R6Class(
  inherit = AbstractBmi,
  private = list(
    config = NULL,
    data = NULL,
    forc = NULL,
    pars = NULL,
    mod = NULL
    current = NULL
  ),
  public = list(
    initialize = function(config_file) {
      private$config <- read.config(config_file)

      private$data <- read.table(config$data, header=TRUE)
      private$forc <- WALRUS_selectdates("data", config$start, config$end)
      WALRUS_preprocessing(f=forc, dt=config$step)
      $private$pars <- data.frame(config$parameters)
      return()
    },
    getTimeUnits <- function() return('seconds since 1970-01-01'),
    getTimeStep <- function() return(private$config$step),
    getStartTime <- function() return(private$config$start),
    getEndTime <- function() return(private$config$end),
    getCurrentTime <- function() return(private$current),
    updateUntil <- function(until) {
      # TODO do not run till end but till until argument
      private$mod <- WALRUS_loop(private$pars)
      return()
    },
  )
)
