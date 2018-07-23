
library(WALRUS)
library(configr)

bmi_initialize <- function(config_file) {
    config <<- read.config(config_file)

    data <<- read.table(config$data, header=TRUE)
    forc <<- WALRUS_selectdates("data", config$start, config$end)
    WALRUS_preprocessing(f=forc, dt=config$step)
    pars = data.frame(config$parameters)
    return()
}

bmi_getTimeUnits <- function() {
    return('seconds since 1970-01-01')
}

bmi_getTimeStep <- function() {
    return(config$step)
}

bmi_getStartTime <- function() {
    return(config$start)
}

bmi_getEndTime <- function() {
    return(config$end)
}

bmi_getCurrentTime <- function() {
    if (exists('mod')) {
        return(config$end)
    } else {
        return(config$start)
    }
}

bmi_updateUntil <- function(until) {
    # TODO do not run till end but till until argument
    mod <<- WALRUS_loop(pars)
    return()
}
