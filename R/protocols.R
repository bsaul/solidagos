#' str(example_study_area[[1]]$window)
#'
#' pop <- generate_matern_populations(list(speciesA, speciesB),
#'                                  area  = example_study_area[[1]],
#'                                  scale = .05)
#'
#' pop$id <- 1:length(pop$x)
#'
#' prot <-
#' purrr::map(
#'   .x = seq(pop$window$xrange[1] + 0.1, pop$window$xrange[2] - 0.1, by = .2),
#'   .f = ~ {
#'     list(
#'       xrange = c(.x - 0.025, .x+ 0.025),
#'       yrange = c(.1, .15)
#'     )
#'   }
#' )
#' library(magrittr)
#' observables <-
#' purrr::map(
#'   .x = prot,
#'   .f = ~ {
#'
#'     which_units <-
#'       dplyr::between(pop$x, .x$xrange[1], .x$xrange[2]) &
#'       dplyr::between(pop$y, .x$yrange[1], .x$yrange[2])
#'
#'     list(
#'       id = pop$id[which_units],
#'       x = pop$x[which_units],
#'       y = pop$y[which_units],
#'       species = pop$species[which_units],
#'       color = pop$color[which_units]
#'     )
#'
#'   }
#' ) %>%
#'   purrr::pmap(list) %>%
#'   purrr::map(unlist)
#' #'
#' create_systematic_protocol <- function(window){
#'
#'   # Create a list of
#'   purrr::map(
#'     .x = seq(window$xrange[1] + 0.1, window$xrange[2] - 0.1, by = .2),
#'     .f = ~ {
#'       list(
#'         xrange = c(.x - 0.025, .x+ 0.025),
#'         yrange = c(.1, .15)
#'       )
#'     }
#'   )
#'
#'
#'   function(x, y){
#'
#'   }
#' }
