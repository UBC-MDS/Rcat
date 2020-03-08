# data for testing
df <- data.frame('x' = c(1, 2, 11, 22, 8), 'y' = c(100, 110, 155, 200, 540))


# test incorrect dataframe type
testthat::test_that("Error is raised for incorrect df type", {
        testthat::expect_error(suscat(c(1,2,3)))
})

# test incorrect column type
testthat::test_that("Error is raised for incorrect column type", {
        testthat::expect_error(suscat(df,c(1,2,3)))
})

# test when n is of wrong type
testthat::test_that("n should be an integer", {
        testthat::expect_error(suscat(test_df, c('x','y'),n='a'))
        testthat::expect_error(suscat(test_df, c('x','y'),n=0.2))
})

# test when num input is wrong
testthat::test_that("num should be one of the following: 'percent', 'number'", {
        testthat::expect_error(suscat(test_df, c('x','y'),n=2, num=''))

})

#testing output type
testthat::test_that("Output of wrong type",{
        testthat::expect_type(suscat(df,c('x')),"list")
})

#testing output
testthat::test_that("Output unexpectedly wrong",{
        #checking indicies per column
        testthat::expect_equal(length(suscat(df,c('x'))$'x'),2)
        #checking number of columns
        testthat::expect_equal(length(suscat(df,c('x'),n=0)),1)
        # check values of indicies returned
        testthat::expect_gte(min(suscat(df,c('x'))$'x'),0)
        testthat::expect_lte(max(suscat(df,c('x'))$'x'),nrow(df))
        testthat::expect_equal(suscat(df,c('x','y'))$'x',suscat(df,c('x'))$'x')
})



