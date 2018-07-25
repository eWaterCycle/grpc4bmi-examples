#!/usr/bin/env r

library(RProtoBuf)
library(grpc)

source(Sys.getenv('BMI_MODULE'))

model <- get(Sys.getenv('BMI_CLASS'))$new()

# TODO replace with file path from package grpc4bmi package
spec <- 'bmi.proto'

impl <- read_services(spec)

impl$initialize$f <- function(request) {
  model$bmi_initialize(request$config_file)
  new(bmi.Empty)
}

impl$update$f <- function(request) {
  model$update()
  new(bmi.Empty)
}

impl$updateUntil$f <- function(request) {
  model$updateUntil(request$until)
  new(bmi.Empty)
}

impl$updateFrac$f <- function(request) {
  model$updateFrac(request$frac)
  new(bmi.Empty)
}

impl$finalize$f <- function(request) {
  model$bmi_finalize()
  new(bmi.Empty)
}

impl$runModel$f <- function(request) {
  model$runModel()
  new(bmi.Empty)
}

impl$getComponentName$f <- function(request) {
  name = model$getComponentName()
  new(bmi.GetComponentNameResponse, name=name)
}

impl$getInputVarNameCount$f <- function(request) {
  count = model$getInputVarNameCount()
  new(bmi.GetVarNameCountResponse, count=count)
}

impl$getOutputVarNameCount$f <- function(request) {
    count = model$getOutputVarNameCount()
    new(bmi.GetVarNameCountResponse, count=count)
}

impl$getInputVarNames$f <- function(request) {
    names = model$getInputVarNames()
    new(bmi.GetVarNamesResponse, names=names)
}

impl$getOutputVarNames$f <- function(request) {
    names = model$getOutputVarNames()
    new(bmi.GetVarNamesResponse, names=names)
}

impl$getTimeUnits$f <- function(request) {
    units <- model$getTimeUnits()
    new(bmi.GetTimeUnitsResponse, units=units)
}

impl$getTimeStep$f <- function(request) {
    interval <- model$getTimeStep()
    new(bmi.GetTimeStepResponse, interval=interval)
}

impl$getCurrentTime$f <- function(request) {
    time <- model$getCurrentTime()
    new(bmi.GetTimeResponse, time=time)
}

impl$getStartTime$f <- function(request) {
    time <- model$getStartTime()
    new(bmi.GetTimeResponse, time=time)
}

impl$getEndTime$f <- function(request) {
    time <- model$getEndTime()
    new(bmi.GetTimeResponse, time=time)
}

impl$getVarGrid$f <- function(request) {
   grid_id = model$getVarGrid(request$name)
   new(bmi.GetVarGridResponse, grid_id=grid_id)
}

impl$getVarType$f <- function(request) {
   type = model$getVarType(request$name)
   new(bmi.GetVarTypeResponse, type=as.character(type))
}

impl$getVarItemSize$f <- function(request) {
   size = model$getVarItemSize(request$name)
   new(bmi.GetVarItemSizeResponse, size=size)
}

impl$getVarUnits$f <- function(request) {
   units = model$getVarUnits(request$name)
   new(bmi.GetVarUnitsResponse, units=units)
}

impl$getVarNBytes$f <- function(request) {
   nbytes = model$getVarNBytes(request$name)
   new(bmi.GetVarNBytesResponse, nbytes=nbytes)
}

impl$getValue$f <- function(request) {
   values = model$getValue(request$name)
   # TODO determine type of values and set as values_int , values_float or values_double
   new(bmi.GetValueResponse, values=values, shape=dim(values))
}

impl$getValuePtr$f <- function(request) {
  model$getValuePtr(request$name)
  new(bmi.Empty)
}

impl$getValueAtIndices$f <- function(request) {
  values = model$getValueAtIndices(request$name, request$indices)
   # TODO determine type of values and set as values_int , values_float or values_double
  new(bmi.GetValueAtIndicesResponse, values, shape=dim(values))
}

impl$setValue$f <- function(request) {
  # TODO convert request$values_* to values
  model$setValue(request$name, request$values)
  new(bmi.Empty)
}

impl$setValuePtr$f <- function(request) {
  model$setValuePtr(request$name, request$ref)
  new(bmi.Empty)
}

impl$setValueAtIndices$f <- function(request) {
  # TODO convert request$values_* to values
  model$setValueAtIndices(request$name, request$indices, request$values)
  new(bmi.Empty)
}

impl$getGridSize$f <- function(request) {
  size = model$getGridSize(request$grid_id)
  new(bmi.GetGridSizeResponse, size=size)
}

impl$getGridType$f <- function(request) {
  type = model$getGridType(request$grid_id)
  new(bmi.GetGridTypeResponse, type=type)
}

impl$getGridRank$f <- function(request) {
  rank = model$getGridRank(request$grid_id)
  new(bmi.GetGridRankResponse, rank=rank)
}

impl$getGridShape$f <- function(request) {
  shape = model$getGridShape(request$grid_id)
  new(bmi.GetGridShapeResponse, shape=shape)
}

impl$getGridSpacing$f <- function(request) {
  spacing = model$getGridSpacing(request$grid_id)
  new(bmi.GetGridSpacingResponse, spacing=spacing)
}

impl$getGridOrigin$f <- function(request) {
  origin = model$getGridOrigin(request$grid_id)
  new(bmi.GetGridOriginResponse, origin=origin)
}

impl$getGridX$f <- function(request) {
  coordinates = model$getGridX(request$grid_id)
  new(bmi.GetGridPointsResponse, coordinates=coordinates)
}

impl$getGridY$f <- function(request) {
  coordinates = model$getGridY(request$grid_id)
  new(bmi.GetGridPointsResponse, coordinates=coordinates)
}

impl$getGridZ$f <- function(request) {
  coordinates = model$getGridZ(request$grid_id)
  new(bmi.GetGridPointsResponse, coordinates=coordinates)
}

impl$getGridCellCount$f <- function(request) {
  count = model$getGridCellCount(request$grid_id)
  new(bmi.GetCountResponse, count=count)
}

impl$getGridPointCount$f <- function(request) {
  count = model$getGridPointCount(request$grid_id)
  new(bmi.GetCountResponse, count=count)
}

impl$getGridVertexCount$f <- function(request) {
  count = model$getGridVertexCount(request$grid_id)
  new(bmi.GetCountResponse, count=count)
}

impl$getGridConnectivity$f <- function(request) {
  links = model$getGridConnectivity(request$grid_id)
  new(bmi.GetGridConnectivityResponse, links=links)
}

impl$getGridOffset$f <- function(request) {
  offsets = model$getGridOffset(request$grid_id)
  new(bmi.GetGridConnectivityResponse, offsets=offsets)
}

start_server(impl, paste("0.0.0.0", Sys.getenv('BMI_PORT'), sep=':'))

traceback()
