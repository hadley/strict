test_that("throw errors for scalar x", {
  expect_snapshot(strict_diag(5), error = TRUE)
  expect_snapshot(strict_sample(5), error = TRUE)
})
