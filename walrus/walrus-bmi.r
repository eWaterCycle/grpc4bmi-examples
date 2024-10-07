
library(WALRUS)
library(configr)
library(R6)
library(bmi)

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
    current = 0,
    vars = list(
      label=c(
        'actual evapotranspiration', 'discharge', 'groundwater drainage/surface water infiltration', 'quickflow',
        'storage deficit', 'equilibrium storage deficit', 'groundwater depth', 'level quickflow reservoir',
        'surface water level', 'wetness index'
      ),
      name=c('ETact', 'Q', 'fGS', 'fQS', 'dV', 'dVeq', 'dG', 'hQ', 'hS', 'w'),
      type=rep('float64', 10),
      unit=c('mm/h', 'mm/h', 'mm/h', 'mm/h', 'mm', 'mm', 'mm', 'mm', 'mm', '-'),
      size=rep(8L, 10)
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
      private$current <- private$current + private$config$step
    },
    update_until = function(time) {
      private$current <- time
    },
    get_component_name = function() return('WALRUS'),
    get_input_var_names = function() return(list()),
    # TODO map to CSDMS Standard Names
    get_output_var_names = function() return(private$vars$name),

    get_time_units = function() return('hours since 1970-01-01 00:00:00.0 00:00'),
    get_time_step = function() return(private$config$step),
    get_start_time = function() return(private$config$start),
    get_end_time = function() return(private$config$end),
    get_current_time = function() {
      return(private$current)
    },

    get_var_grid = function(name) {
      return(0L)
    },
    get_var_type = function(name) {
      return(private$vars$type[private$vars$name == name])
    },
    get_var_itemsize = function(name) {
      return(private$vars$size[private$vars$name == name])
    },
    get_var_units = function(name) {
      return(private$vars$unit[private$vars$name == name])
    },
    get_var_nbytes = function(name) {
      # grid size is 1x1 so same as single value
      return(self$get_var_itemsize(name));
    },
    get_var_location = function(name) {
      # All variables are in node location
      return('node');
    },
    get_value = function(name) {
      offset <- private$current - private$config$start
      return(private$mod[offset, name])
    },
    get_value_at_indices = function(name, indices) {
      offset <- private$current - private$config$start
      return(private$mod[offset, name])
    },
    get_grid_size = function(grid_id) return(1L),
    get_grid_type = function(grid_id) return('uniform_rectilinear'),
    get_grid_rank = function(grid_id) return(2L),
    get_grid_shape = function(grid_id) return(c(1L, 1L)),
    get_grid_spacing = function(grid_id) return(c(0L, 0L)),
    get_grid_origin = function(grid) return(c(private$config$centroid$lon, private$config$centroid$lat)),
    bmi_finalize = function() return()
    # Skip getValuePtr, getValueAtIndices, setValue* and others as model does not support them
    )
)
