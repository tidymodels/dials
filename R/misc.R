### For printing

format_range_val <- function(val, ukn = "?", digits = 3) {
  if (!is_unknown(val)) {
    txt <- format(val, digits = digits)
  } else
    txt <- ukn
  txt
}

format_bounds <- function(bnds) {
  res <- c("(", ")")
  if (bnds[1])
    res[1] <- "["
  if (bnds[2])
    res[2] <- "]"
  res
}

### Check functions

check_label <- function(txt) {
  if (is.null(txt))
    return(invisible(txt))
  if (!is.character(txt) || length(txt) > 1)
    stop("`label` should be a single character string.", call. = FALSE)
  invisible(txt)
}


