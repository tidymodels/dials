#' Parameters for neural network learning rate schedulers
#
#' These parameters are used for constructing neural network models.
#'
#' @inheritParams Laplace
#' @param values A character string of possible values. See `values_scheduler`
#'  in examples below.
#' @details
#' These parameters are often used with neural networks via
#' `parsnip::mlp(engine = "brulee")`.
#'
#' The details for how the \pkg{brulee} schedulers change the rates:
#'
#' * `schedule_decay_time()`: \eqn{rate(epoch) = initial/(1 + decay \times epoch)}
#' * `schedule_decay_expo()`: \eqn{rate(epoch) = initial\exp(-decay \times epoch)}
#' * `schedule_step()`: \eqn{rate(epoch) = initial \times reduction^{floor(epoch / steps)}}
#' * `schedule_cyclic()`: \eqn{cycle = floor( 1 + (epoch / 2 / step size) )},
#'  \eqn{x = abs( ( epoch / step size ) - ( 2 * cycle) + 1 )}, and
#'  \eqn{rate(epoch) = initial + ( largest - initial ) * \max( 0, 1 - x)}
#'
#' @name scheduler-param
#' @export
rate_initial <- function(range = c(-3, -1), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(rate_initial = "Initial Learning Rate"),
    finalize = NULL
  )
}

#' @rdname scheduler-param
#' @export
rate_largest <- function(range = c(-1, -1 / 2), trans = transform_log10()) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(rate_largest = "Maximum Learning Rate"),
    finalize = NULL
  )
}


#' @rdname scheduler-param
#' @export
rate_reduction <- function(range = c(1 / 5, 1), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(rate_reduction = "Learning Rate Reduction"),
    finalize = NULL
  )
}


#' @rdname scheduler-param
#' @export
rate_steps <- function(range = c(2, 10), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(rate_steps = "Epochs Until Reduction"),
    finalize = NULL
  )
}

#' @rdname scheduler-param
#' @export
rate_step_size <- function(range = c(2, 20), trans = NULL) {
  new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(rate_step_size = "Half-Size of Cycle"),
    finalize = NULL
  )
}

#' @rdname scheduler-param
#' @export
rate_decay <- function(range = c(0, 2), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(rate_decay = "Learning Rate Decay"),
    finalize = NULL
  )
}

#' @rdname scheduler-param
#' @export
rate_schedule <- function(values = values_scheduler) {
  new_qual_param(
    type = "character",
    values = values,
    label = c(rate_schedule = "Learning Rate Scheduler"),
    finalize = NULL
  )
}

#' @rdname scheduler-param
#' @export
values_scheduler <- c("none", "decay_time", "decay_expo", "cyclic", "step")
