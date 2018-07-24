#!/usr/bin/env r

library(RProtoBuf)
library(grpc)

source(sys.getenv('BMI_MODULE'))

spec <- '/opt/walrus-bmi/bmi.proto'

model <- get(sys.getenv('BMI_CLASS'))$new()

impl <- read_services(spec)

impl$initialize$f <- function(request) {
  model$initialize(request$config_file)
  new(bmi.Empty)
}

impl$updateUntil$f <- function(request) {
    model$updateUntil(request$until)
    new(bmi.Empty)
}

impl$getTimeUnits$f <- function() {
    units <- model$getTimeUnits()
    new(bmi.GetTimeUnitsResponse, units=units)
}

impl$getTimeStep$f <- function() {
    interval <- model$getTimeStep()
    new(bmi.GetTimeStepResponse, interval=interval)
}

impl$getStartTime$f <- function() {
    time <- model$getStartTime()
    new(bmi.GetTimeResponse, time=time)
}

impl$getEndTime$f <- function() {
    time <- model$getEndTime()
    new(bmi.GetTimeResponse, time=time)
}

start_server(impl, paste("0.0.0.0", sys.getenv('BMI_PORT'))
