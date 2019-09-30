#' Chicago Ridership Data
#'
#' @details These data are from Kuhn and Johnson (2020) and contain an
#'  _abbreviated_ training set for modeling the number of people (in thousands)
#'  who enter the Clark and Lake L station.
#'
#' The `date` column corresponds to the current date. The columns with station
#'  names (`Austin` through `California`) are a _sample_ of the columns used in
#'  the original analysis (for file size reasons). These are 14 day lag
#'  variables (i.e. `date - 14 days`). There are columns related to weather and
#'  sports team schedules.
#'
#' The station at 35th and Archer is contained in the column `Archer_35th` to
#' make it a valid R column name.
#'
#'
#' @name Chicago
#' @aliases Chicago stations
#' @docType data
#' @return \item{Chicago}{a tibble} \item{stations}{a vector of station names}
#'
#' @source Kuhn and Johnson (2020), _Feature Engineering and Selection_,
#' Chapman and Hall/CRC . \url{https://bookdown.org/max/FES/} and
#' \url{https://github.com/topepo/FES}
#'
#'
#' @keywords datasets
#' @examples
#' data(Chicago)
#' str(Chicago)
#' stations
NULL
