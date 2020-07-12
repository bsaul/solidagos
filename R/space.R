#' Study standard observation segment
#' 
#' The standard road segment size for this study in relative dimensions is
#' a 4:1 rectangle. See \code{\link[spatstat]{owin}}. The origin 
#' (\code{(x = 0, y = 0)}) is the bottom-left corner of the shape (this is where
#' \link{observers} should start.
#' 
#' @importFrom spatstat owin
#' @export
standard_segment <- spatstat::owin(c(0, 1), c(0, 0.25))


#' An example study area with a single property
#' 
#' @importFrom purrr map
#' @export
example_study_area <- purrr::map(
  .x = seq(0, 1, by = 0.001),
  .f = ~ list(window = standard_segment,
              properties = list(propA = .x))
)
