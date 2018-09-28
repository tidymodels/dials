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

# From parsnip:::check_installs
#' @importFrom utils installed.packages
check_installs <- function (x) {
  lib_inst <- rownames(installed.packages())
  is_inst <- x %in% lib_inst
  if (any(!is_inst)) {
    stop(
      "This engine requires some package installs: ",
      paste0("'", x[!is_inst], "'", collapse = ", "),
      call. = FALSE
    )
  }
}

# checking functions -----------------------------------------------------------

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

check_finalize <- function(x) {
  if (!is.null(x) & !is.function(x))
    stop("`finalize` should be NULL or a function.", .call = FALSE)
  invisible(x)
}
