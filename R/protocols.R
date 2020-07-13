#' Protocols
#'
#' A protocol is a function that takes a segment and returns a list of (x, y)
#' pairs from which \code{\link{observers}} will use their \code{\link{detectors}}.
#' That is, a protocol defines the path by which \code{\link{observers}} traverse
#' a segment and take observations.
#'
#' @name protocols
#' @param segment a study segment
NULL

#' @describeIn protocols observe the entire segment
#' @export
cover_segment <- function(segment){
  segment$prop_area_covered <- 1
  segment
}

#' @describeIn protocols observe 5 smaller quadrats within a segment
#' @export
systematic <- function(segment){
  points <- purrr::map(
    .x = seq(segment$window$xrange[1] + 0.1, segment$window$xrange[2] - 0.1, by = .2),
    .f = ~ list(x = .x, y = segment$window$yrange[2]/2)
  )

  observable <- purrr::map2_lgl(
    .x = segment$x,
    .y = segment$y,
    .f = ~ {
      x.u <- .x; y.u <- .y;
      any(purrr::map_lgl(points, ~ { (.x$x - 0.025) <= x.u && x.u <= .x$x + 0.025 })) &&
      any(purrr::map_lgl(points, ~ { (.x$y - 0.025) <= y.u && y.u <= .x$y + 0.025 }))
    }
  )

  segment$x <- segment$x[observable]
  segment$y <- segment$y[observable]
  segment$species <- segment$species[observable]
  segment$color   <- segment$color[observable]
  tot_area <- segment$window$xrange[2]*segment$window$yrange[2]
  cov_area <- 0.05^2 * length(points)
  segment$p_area_covered <- cov_area/tot_area

  segment
}
