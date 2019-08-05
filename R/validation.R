validate_params <- function(...) {
  param_quos <- quos(...)
  param_expr <- purrr::map_chr(param_quos, rlang::quo_text)
  if (length(param_quos) == 0) {
    stop("At least one parameter object is required.", call. = FALSE)
  }
  params <- map(param_quos, eval_tidy)
  is_param <- map_lgl(params, function(x) inherits(x, "param"))
  if (!all(is_param)) {
    stop("These arguments must have class 'param': ",
         paste0("`", param_expr[!is_param], "`", collapse = ","),
         call. = FALSE)
  }
  bad_param <- has_unknowns(params)
  if (any(bad_param)) {
    stop("These arguments contains unknowns: ",
         paste0("`", param_expr[bad_param], "`", collapse = ","),
         call. = FALSE)
  }
  invisible(NULL)
}
