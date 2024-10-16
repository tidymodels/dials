#' Buffer size
#'
#' In equivocal zones, predictions are considered equivocal (i.e. "could
#' go either way") if their probability falls within some distance on either
#' side of the classification threshold. That distance is called the "buffer."
#'
#' A buffer of .5 is only possible if the classification threshold is .5.
#' In that case, all probability predictions are considered equivocal,
#' regardless of their value in \code{[0, 1]}.
#' Otherwise, the maximum buffer is `min(threshold, 1 - threshold)`.
#'
#' @inheritParams buffer
#' @seealso [threshold()]
#' @examples
#' buffer()
#' @export
buffer <- function(range = c(0, .5), trans = NULL) {
  new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(buffer = "buffer"),
    finalize = NULL
  )
}
