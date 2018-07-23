#!/usr/bin/env r

library(RProtoBuf)
library(grpc)

source(sys.getenv('BMI_MODULE'))

spec <- '/opt/walrus-bmi/bmi.proto'

impl <- read_services(spec)

impl$initialize$f <- function(request) {
  bmi_initialize(request$config_file)
  new(bmi.Empty)
}

impl$updateUntil$f <- function(request) {
    bmi_updateUntil(request$until)
    new(bmi.Empty)
}

impl$getTimeUnits$f <- function() {
    units <- bmi_getTimeUnits()
    new(bmi.GetTimeUnitsResponse, units=units)
}

impl$getTimeStep$f <- function() {
    interval <- bmi_getTimeStep()
    new(bmi.GetTimeStepResponse, interval=interval)
}

impl$getStartTime$f <- function() {
    time <- bmi_getStartTime()
    new(bmi.GetTimeResponse, time=time)
}

impl$getEndTime$f <- function() {
    time <- bmi_getEndTime()
    new(bmi.GetTimeResponse, time=time)
}

start_server(impl, paste("0.0.0.0", sys.getenv('BMI_PORT'))
