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
    stop("`label` should be a single named character string or NULL.", 
         call. = FALSE)
  if (!is.character(txt) || length(txt) > 1)
    stop("`label` should be a single named character string or NULL.", 
         call. = FALSE)
  if(length(names(txt)) != 1)
    stop("`label` should be a single named character string or NULL.", 
         call. = FALSE)
  invisible(txt)
}


