
test_that("species traits work", {

  traits <- purrr::map(
    .x = speciesA$traits,
    .f = ~ .x(example_study_area[[1]]$properties)
  )

  pop <- generate_matern_population(
    traits = traits,
    area  = example_study_area[[1]],
    scale = 0.05
  )

  expect_is(pop, "list")

})
