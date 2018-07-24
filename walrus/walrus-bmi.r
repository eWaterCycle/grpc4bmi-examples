
library(WALRUS)
library(configr)
library(R6)
source('abstract-bmi.r')

hoursSince1970toDate = function(hours) {
   # hours since 1970
   seconds = hours * 3600 # convert to seconds since 1970
   date10digit = as.numeric(format(as.POSIXlt(seconds, origin='1970/01/01', tz='UTC'), '%Y%m%d%H'))
   return(date10digit)
}

WalrusBmi <- R6Class(
  inherit = AbstractBmi,
  private = list(
    config = NULL,
    data = NULL,
    forc = NULL,
    pars = NULL,
    mod = NULL,
    current = 1,
    vars = data.frame(
      label=c(
        'actual evapotranspiration', 'discharge', 'groundwater drainage/surface water infiltration', 'quickflow',
        'storage deficit', 'equilibrium storage deficit', 'groundwater depth', 'level quickflow reservoir',
        'surface water level', 'wetness index'
      ),
      name=c('ETact', 'Q', 'fGS', 'fQS', 'dV', 'dVeq', 'dG', 'hQ', 'hS', 'w'),
      type=rep('float32', 10),
      unit=c('mm/h', 'mm/h', 'mm/h', 'mm/h', 'mm', 'mm', 'mm', 'mm', 'mm', '-'),
      size=rep(8, 10)
    )
  ),
  public = list(
    bmi_initialize = function(config_file) {
      private$config = read.config(config_file)

      private$data = read.table(private$config$data, header=TRUE)

      startDate = hoursSince1970toDate(private$config$start)
      endDate = hoursSince1970toDate(private$config$end)
      # WALRUS_selectdates uses get(), which gives Error: object of type 'closure' is not subsettable
      # So switch to inline filter
      # private$forc = WALRUS_selectdates(private$data, startDate, endDate)
      private$forc = private$data[private$data$date >= startDate & private$data$date <= endDate ,]

      WALRUS_preprocessing(f=private$forc, dt=private$config$step)
      private$pars = data.frame(private$config$parameters)
      # TODO do not run here, but in update* methods
      private$mod <- WALRUS_loop(private$pars)
      private$current <- private$config$start
      return()
    },
    update = function() {
      private$current <- private$current + private$step
    },

    getComponentName = function() return('WALRUS'),
    getInputVarNameCount = function() return(0),
    getOutputVarNameCount = function() return(10),
    getInputVarNames = function() return(vector('character')),
    # TODO map to CSDMS Standard Names
    getOutputVarNames = function() return(private$vars$name),

    getTimeUnits = function() return('hours since 1970-01-01 00:00:00.0 00:00'),
    getTimeStep = function() return(private$config$step),
    getStartTime = function() return(private$config$start),
    getEndTime = function() return(private$config$end),
    getCurrentTime = function() {
        return(private$start + private$step * private$current)
    },

    getVarGrid = function(name) {
        return(which(private$vars$name == name))
    },
    getVarType = function(name) {
        grid_id = self$getVarGrid(name)
        return(private$vars$type[grid_id])
    },
    getVarItemSize = function(name) {
        grid_id = self$getVarGrid(name)
        return(private$vars$size[grid_id])
    },
    getVarUnits = function(name) {
        grid_id = self$getVarGrid(name)
        return(private$vars$unit[grid_id])
    },
    getVarNBytes = function(name) {
        # grid size is 1x1x1 so same as single value
        return(1 * self$getVarUnits(name));
    },

    getValue = function(name) {
        return(private$mod[private$current, name])
    },
    # Skip getValuePtr, getValueAtIndices and setValue*, model does not support it

    getGridSize = function(grid_id) return(1),
    getGridType = function(grid_id) return('uniform_rectilinear'),
    getGridRank = function(grid_id) return(0),
    getGridShape = function(grid_id) return(c(1))

    # Skip rest of getGrid*, model grid rank is scalar
  )
)
