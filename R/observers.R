#' Create an observer
#'
#' An observer is a function that takes a \code{\link{segment}} and
#' returns observations -- indicators of whether a population unit was detected.
#' An observer is defined by both a \link{detection_funs} and a set of fixed
#' arguments for a given detection function.
#'
#' @name observers
#' @param detectionFUN a \link{detection_funs}
#' @param detectionARGS a \code{list} of arguments passed to \code{detectionFUN}
#' @export
create_observer <- function(protocol, detectionFUN, detectionARGs = list()){
  function(segment){
    segment <- protocol(segment)
    pos <- list(x = segment[["x"]], y = segment[["y"]])
    list(
      data         = segment,
      observations = do.call(detectionFUN, args = c(pos, detectionARGs))
    )
  }
}
