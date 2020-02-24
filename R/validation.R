validate_params <- function(...) {
  param_quos <- quos(...)
  param_expr <- purrr::map_chr(param_quos, rlang::quo_text)
  if (length(param_quos) == 0) {
    rlang::abort("At least one parameter object is required.")
  }
  params <- map(param_quos, eval_tidy)
  is_param <- map_lgl(params, function(x) inherits(x, "param"))
  if (!all(is_param)) {
    rlang::abort(
      paste0(
        "These arguments must have class 'param': ",
        paste0("`", param_expr[!is_param], "`", collapse = ",")
      )
    )
  }
  bad_param <- has_unknowns(params)
  if (any(bad_param)) {
    bad_param <- names(bad_param)[bad_param]
    rlang::abort(
      paste0(
        "These arguments contains unknowns: ",
        paste0("`", bad_param, "`", collapse = ","),
        '. See the `finalize()` function.')
    )
  }
  invisible(NULL)
}
