test_that("misscat() drops rows based on threshold of NAs", {

        x <- data.frame(x = c(1, 2, NaN), y = c(NA, 2, NA))

        testthat::expect_error(misscat(0.3, 0.3), 'Every column in your dataframe must be numeric.')

        testthat::expect_error(misscat(x, "0.3"), 'Threshold must be a number')

        testthat::expect_error(misscat(x, 3), 'threshold is a ratio between 0 and 1')

        testthat::expect_equal(nrow(misscat(x, 0.5)), 1)
})
