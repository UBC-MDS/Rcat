# helper data for testing
test_df <- data.frame('x' = c(1, 2), 'y' = c(3, 4))

# test incorrect dataframe type
test_that("Error is raised for incorrect df type", {
        expect_error(topcorr(1))
})

# test incorrect k type
test_that("Error is raised for incorrect k type", {
        expect_error(topcorr(test_df, "d"))
})

# test when k is larger than number of feature pairs
test_that("Error is raised for incorrect k type", {
        expect_error(topcorr(test_df, 3))
})

# test when k is a negative number
test_that("Error is raised for incorrect k type", {
        expect_error(topcorr(test_df, -1))
})

# test when k is zero
test_that("Error is raised for incorrect k type", {
        expect_error(topcorr(test_df, 0))
})


