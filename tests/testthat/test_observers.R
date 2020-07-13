test_that("observers work", {
  x <- generate_matern_populations(list(speciesA, speciesB),
                                   area  = example_study_area[[1]],
                                   scale = .05)

  test1 <- creater_observer(cover_segment, oracle_detector)
  res1 <- test1(x)
  expect_is(res1, "list")
  expect_equal(res1$data$x, x$x)

  test2 <- creater_observer(systematic, oracle_detector)
  expect_is(test2(x), "list")

})
