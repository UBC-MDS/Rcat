testthat::test_that("misscat() drops rows based on threshold of NAs", {
        # Creating a testing dataframe
        x <- data.frame(x = c(1, 2, NaN), y = c(NA, 2, NA))
        # testing wrong input df
        testthat::expect_error(misscat(0.3, 0.3), 'Every column in your dataframe must be numeric.')
        # testing non numeric threshold
        testthat::expect_error(misscat(x, "0.3"), 'Threshold must be a number')
        # testing threshold greater than 1
        testthat::expect_error(misscat(x, 3), 'threshold is a ratio between 0 and 1')
        # testing threshold less than 0
        testthat::expect_error(misscat(x, -0.3), 'threshold is a ratio between 0 and 1')
        # testing droping the right rows
        testthat::expect_equal(nrow(misscat(x, 0.5)), 1)
})
