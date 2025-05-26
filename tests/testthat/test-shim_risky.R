test_that("strict_drop detects when default ok", {
  expect_equal(strict_drop(c(TRUE, TRUE)), FALSE)
  expect_equal(strict_drop(1:5), FALSE)
  expect_equal(strict_drop(letters[1:2]), FALSE)
  expect_equal(strict_drop(), FALSE)
})

test_that("strict_drop errors instead of returning TRUE", {
  expect_snapshot(error = TRUE, {
    strict_drop(c(TRUE))
    strict_drop(1)
    strict_drop("a")
  })
})
