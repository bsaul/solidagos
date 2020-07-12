#' Create a function for simulating a single species
#' 
#' @param FUN a data generating function
#' @param ... arguments to curry out 
#' @param trait_map a named character vector whose names are names of arguments 
#'     in \code{FUN} and whose elements are names of \link{species_traits}.
#' @return a \code{function(traits, ...)} where \code{traits} is a list of species
#'   traits and \code{...} are passed as  additional arguments to \code{FUN}.
#' @examples 
#' \dontrun{
#'   g <- create_generator(rMatClust, win = owin(c(0, 1), c(0, .25)),
#'                         trait_map = matern_traitmap)
#'   segments <- g(traits = speciesA$traits, scale = 0.05, nsim = 100)
#' }
# @export
create_population_simulator <- function(FUN, ..., trait_map){
  fixed_args <- list(...)
  function(traits, area,...){
    names(traits)[which(trait_map == names(traits))] <- names(trait_map)
    f <- match.fun(FUN)
    traits <- traiterator(traits)(area)
    
    args <- c(fixed_args, traits, list(win = area$window), list(...))
    pop  <- do.call(f, args = args)
    
    c(pop, list(properties = area$properties))
  }
}

#' Matern trait mapping 
#'
matern_traitmap <- c("kappa" = "rarity", "mu" = "clumping")

#' Generate a single species population from a Matern Cluster Process
#' 
#' Generates a population in a \code{\link{standard_segment}} using 
#' \code{\link[spatstat]{rMatClust}}.
#' @export
generate_matern_population <- create_population_simulator(
  spatstat::rMatClust,
  # win = standard_segment,
  trait_map = matern_traitmap)

#' Collect species within a spatial area
#' 
#' @importFrom tibble tibble
#' @importFrom dplyr bind_rows
collect_area_populations <- function(x, y){
  
  list(
    window  = x$window,
    properties = x$properties,
    total_n = sum(x$n, y$n),
    n       = c(x$n, y$n),
    x       = c(x$x, y$x),
    y       = c(x$y, y$y),
    species = c(x$species, y$species),
    color   = c(x$color, y$color)
  )
}

#' @importFrom purrr map reduce
#' @importFrom magrittr "%>%"
create_population_generator <- function(generator){
  f <- force(generator)
  
  function(area, species_list, ...){
    dots <- list(...)
    
    purrr::map(
      .x = species_list,
      .f = ~ {
        .args <- c(list(traits = traiterator(.x$traits)(area),
                        area   = area,
                        nsim   = 1L),
                        dots)
        
        sim <- do.call(f, args = .args)
        sim$species <- rep(.x$name, length(sim$x))
        sim$color   <- rep(.x$aes$color, length(sim$x))
        sim
      }
      
    ) %>%
      purrr::reduce(collect_area_populations)
  }
}

#' Generate a multiple species populations from a Matern Cluster Process
#' 
#' Generates mulitple populations in a \code{\link{standard_segment}} using 
#' \code{\link[spatstat]{rMatClust}}.
#' @export
generate_matern_populations <- create_population_generator(generate_matern_population)