#' Trait generators 
#' 
#' @name species_traits
NULL

#' @rdname species_traits
#' @export
create_locally_uniform_rarity_trait <- function(kappa, property_map){
  force(kappa)
  function(properties){
    L   <- c(1, unlist(properties[property_map]))
    function(x, y){
      val <- drop(t(L) %*% kappa)
      rep(val, length(x))
    }
  }
}

#' @rdname species_traits
#' @export
create_locally_uniform_clumping_trait <- function(mu, property_map){
  force(mu)
  function(properties){
    L   <- c(1, unlist(properties[property_map]))
    function(x, y){
      val <- drop(t(L) %*% mu)
      rep(val, length(x))
    }
  }
}

# # @rdname species_traits
# create_early_bloomer <- function(){
#   function(x, y, t){
#     (t > 90 & t < 180) + (t <= 90 | t >= 180)*(t > 45 & t < 230)*0.5
#   }
# }
# 
# # @rdname species_traits
# create_late_bloomer <- function(){
#   function(x, y, t){
#     (t > 180 & t < 230) + (t <= 180 | t >= 230)*(t > 150 & t < 260)*0.5
#   }
# }

#' Species
#' 
#' In the context of this package, a `species` is an object with the following
#' elements: 
#' 
#' * name: the name of the species
#' * aes: a `list` of aesthetic elements for plotting (e;g. color)
#' * traits: a named `list` of functions that are used by [segment_generators]
#'    to produce populations of species within a segment. See [species_traits]
#'    for available traits
#' @name species
#' 
NULL

#' @rdname species
#' @export
speciesA <- list(
  name    = "A",
  aes     = list(color = "#e41a1c"),
  traits = list(
    rarity     = create_locally_uniform_rarity_trait(c(10, 5), "propA"),
    clumping   = create_locally_uniform_clumping_trait(c(10, 5), "propA")
  )
)

#' @rdname species
#' @export
speciesB <- list(
  name    = "B",
  aes     = list(color = "#984ea3"),
  traits = list(
    rarity     = create_locally_uniform_rarity_trait(c(1, 1), "propA"),
    clumping   = create_locally_uniform_clumping_trait(c(1, 1), "propA")
  )
)

#' @rdname species
#' @export
speciesC <- list(
  name    = "C",
  aes     = list(color = "#ff7f00"),
  traits = list(
    rarity     = create_locally_uniform_rarity_trait(c(20, -15), "propA"),
    clumping   = create_locally_uniform_clumping_trait(c(10, -8), "propA")
  )
)

#' TODO
#' @export
traiterator <- function(traits){
  function(area){
    purrr::map(
      .x = traits,
      .f = ~ .x(area$properties)
    )
  }
}
