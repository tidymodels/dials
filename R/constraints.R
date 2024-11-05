#' Parameter constraints
#'
#' These helper functions can help manage constraints among parameters.
#' @inheritParams parameters
#' @name constraints
#' @return [has_constraint()] returns a logical, all others return parameter
#' sets.
#' @examples
#' no_prm <- parameters(lambda = penalty(), mixture())
#'
#' has_constraint(no_prm)
#'
#' constr_prm <- add_parameter_constraint(ex_prm, penalty < 0.01)
#' constr_prm
#' has_constraint(constr_prm)
#'
#' remove_parameter_constraint(constr_prm)
#' update_parameter_constraint(constr_prm, log10(penalty) < -2 & mixture > 1 / 2)
#' @export
has_constraint <- function(object) {
  if (any(names(attributes(object)) == "constraint")) {
    constr <- attr(object, "constraint")
    res <- rlang::is_quosure(constr) && !rlang::quo_is_null(constr)
  } else {
    res <- FALSE
  }
  res
}

#' @export
#' @rdname constraints
add_parameter_constraint <- function(object, .constraint = NULL) {
  check_parameters(object)
  if (has_constraint(object)) {
    cli::cli_abort("There is an existing constraint. Please use
                  {.fn update_constrain()} instead.")
  }

  .constraint <- rlang::enquo(.constraint)

  parameters_constr(
    name = object$name,
    id = object$id,
    source = object$source,
    object = object$object,
    component = object$component,
    component_id = object$component_id,
    constraint = .constraint
  )
}

#' @export
#' @rdname constraints
remove_parameter_constraint <- function(object) {
  check_parameters(object)

  .constraint <- rlang::quo(NULL)

  parameters_constr(
    name = object$name,
    id = object$id,
    source = object$source,
    object = object$object,
    component = object$component,
    component_id = object$component_id,
    constraint = .constraint
  )
}

#' @export
#' @rdname constraints
update_parameter_constraint <- function(object, .constraint = NULL) {
  check_parameters(object)

  .constraint <- rlang::enquo(.constraint)

  parameters_constr(
    name = object$name,
    id = object$id,
    source = object$source,
    object = object$object,
    component = object$component,
    component_id = object$component_id,
    constraint = .constraint
  )
}
