dplyr_pre_1.0.0 <- function() {
  utils::packageVersion("dplyr") <= "0.8.5"
}


# Registered in `.onLoad()`
mutate_parameters <- function(.data, ...) {
  out <- NextMethod()
  parameters_maybe_reconstruct(out, .data)
}

# Registered in `.onLoad()`
arrange_parameters <- function(.data, ...) {
  out <- NextMethod()
  parameters_maybe_reconstruct(out, .data)
}

# Registered in `.onLoad()`
filter_parameters <- function(.data, ...) {
  out <- NextMethod()
  parameters_maybe_reconstruct(out, .data)
}

# Registered in `.onLoad()`
rename_parameters <- function(.data, ...) {
  out <- NextMethod()
  parameters_maybe_reconstruct(out, .data)
}

# Registered in `.onLoad()`
select_parameters <- function(.data, ...) {
  out <- NextMethod()
  parameters_maybe_reconstruct(out, .data)
}

# Registered in `.onLoad()`
slice_parameters <- function(.data, ...) {
  out <- NextMethod()
  parameters_maybe_reconstruct(out, .data)
}
