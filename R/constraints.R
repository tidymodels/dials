#' Parameter constraints
#'
#' These helper functions can help manage constraints among parameters.
#' @inheritParams parameters
#' @name constraints
#' @return [has_constraint()] returns a logical, all others return parameter
#' sets.
#' @examples
#' library(dplyr)
#'
#' no_constr_prm <- parameters(lambda = penalty(), mixture(), num_terms(c(1, 10)))
#'
#' has_constraint(no_constr_prm)
#'
#' constr_prm <- add_parameter_constraint(no_constr_prm, lambda < 0.01)
#' constr_prm
#' has_constraint(constr_prm)
#'
#' remove_parameter_constraint(constr_prm)
#' update_parameter_constraint(constr_prm, log10(lambda) < -2 & mixture > 1 / 2)
#'
#' # Using an existing expression? Splice it in
#' is_even_exp <- quote(num_terms %% 2 == 0)
#' even_prm <- add_parameter_constraint(no_constr_prm, !!is_even_exp)
#' even_prm
#'
#' set.seed(1)
#' grid_random(even_prm, size = 100) %>% count(num_terms)
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
