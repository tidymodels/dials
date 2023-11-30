validate_params <- function(..., call = caller_env()) {
  param_quos <- quos(...)
  param_expr <- purrr::map_chr(param_quos, rlang::quo_text)
  if (length(param_quos) == 0) {
    cli::cli_abort("At least one parameter object is required.", call = call)
  }
  params <- map(param_quos, eval_tidy)
  is_param <- map_lgl(params, function(x) inherits(x, "param"))
  if (!all(is_param)) {
    offenders <- param_expr[!is_param]
    cli::cli_abort(
      "Th{?is/ese} argument{?s} must have class {.cls param}: \\
      {.arg {offenders}}.",
      call = call
    )
  }
  bad_param <- has_unknowns(params)
  if (any(bad_param)) {
    bad_param <- names(bad_param)[bad_param]
    cli::cli_abort(
      c(
        x = "Th{?is/ese} argument{?s} contain{?s/} unknowns: \\
            {.arg {bad_param}}.",
        i = "See the {.fn dials::finalize} function."
      ),
      call = call
    )
  }
  invisible(NULL)
}
