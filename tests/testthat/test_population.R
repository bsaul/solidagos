
test_that("population generator work", {
  # Generate a single species
  x <- generate_matern_population(traits = speciesA$traits, 
                                  area  = example_study_area[[1]],
                                  scale = .05, 
                                  nsim  = 1)
  expect_is(x, "list")
  
  # Make sure the doesn't change
  expect_equal(x$window$xrange, example_study_area[[1]]$window$xrange)
  expect_equal(x$window$yrange, example_study_area[[1]]$window$yrange)
})

test_that("population generators work", {
  # Generate a list of species
  x <- generate_matern_populations(list(speciesA, speciesB), 
                                   area  = example_study_area[[1]],
                                   scale = .05)
  # a list for now, might be different class/structure later
  expect_is(x, "list") 
})

test_that("generating study area", {
  
  spec <- list(speciesA, speciesB)
  
  z <-purrr::map(
    .x = example_study_area[1:10],
    .f = ~ generate_matern_populations(spec, area  = .x, scale = .05)
  )

  # a list for now, might be different class/structure later
  expect_is(z, "list") 
})