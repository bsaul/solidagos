#' Create a detection function
#'
#' @param FUN a probability density (or mass) function whose first two arguments
#'       must be \code{x} and \code{y}.
#' @importFrom methods formalArgs
#' @importFrom stats rbinom
#' @return a \code{function(x, y, ...)} where \code{x} and {y} are positions of
#'       population specimens within a segment. The \code{FUN} is used to compute
#'       the probabity that a specimens is detected, that is (\eqn{Pr(D|x,y;\theta)}),
#'       \eqn{x,y} are a specimen's position and \eqn{\theta} are additional
#'       parameters for the pdf (\code{FUN}). This function returns a \code{0/1}
#'       vector of length \code{length(x)} (or \code{length(y)} if \code{x} is
#'       missing), indicating whether specimens were not detected (1) or not (0).

create_detector <- function(FUN){
  force(FUN)

  stopifnot(
    all(methods::formalArgs(FUN)[1:2] == c("x", "y"))
  )

  function(x = NULL, y = NULL, ...){

    if (!is.null(x) && !is.null(y)){
      stopifnot(length(x) == length(y))
    }

    if (is.null(x)){
      .n = length(y)
    } else {
      .n = length(x)
    }

    .probs <- do.call(FUN, args = c(list(x = x, y = y), list(...)) )

    stats::rbinom(n = .n, size = 1,  prob = .probs)
  }
}

#' Detection PDFs
#'
#' @name detection_pdfs
#' @param x x-coordinates for specimens
#' @param y y-coordinates for specimens
NULL

#' Half-Normal detection function
#'
#' Detects specimens with decaying probability with > y, irregardless of x.
#' @rdname detection_pdfs
#' @param theta mean parameter for half normal distribution
#' @references
#'  Clark RG (2016) Statistical Efficiency in Distance Sampling. PLoS ONE 11(3): e0149298.
#'     doi:10.1371/journal.pone.0149298

phnorm <- function(x, y, theta){
  exp( -(y^2)/(theta^2))
}

#' Detection Functions
#'
#' @name detection_funs
NULL

#' Oracle detector
#'
#' Detects specimens with probability 1
#' @rdname detection_funs
oracle_detector <- create_detector(
  function(x, y) 1
)

#' Half-Normal detection function
#'
#' Detects specimens with decaying probability with > y, irregardless of x.
#' @rdname detection_funs
half_norm_detector <- create_detector(phnorm)

