# helper data for testing
df <- data.frame("name" = c("  ", ",.;", "?mark:"), "Age" = c(21,15,12))
test_df_2 <- data.frame("col1" = c("P  un.ctua!stay;", "!!", "  "))
df_output_1 <- data.frame("name" = c(NA, ",.;", "?mark:"), "Age" = c(21, 15, 12), stringsAsFactors=FALSE)
df_output_2 <- data.frame("name" = c(NA, NA, "?mark:"), "Age" = c(21, 15, 12), stringsAsFactors=FALSE)
df_output_3 <- data.frame("name" = c(NA, ",.;", NA), "Age" = c(21, 15, 12), stringsAsFactors=FALSE)
df_output_4 <- data.frame("col1" = c("P  un.ctua!stay;", NA, NA), stringsAsFactors=FALSE)

# tests for incorrect inputs
testthat::test_that("Error is raised by passing a non-dataframe type as dataframe.", {
  testthat::expect_error(repwithna(c(1,2)))
})

testthat::test_that("Error is raised by passing a non-logical type to `rmvsym` parameter.", {
        testthat::expect_error(repwithna(df, rmvsym = 1))
})

testthat::test_that("Error is raised by passing a value that is not a string to `format` parameter.", {
       testthat::expect_error(repwithna(df, format = c('a', 'd')))
})

# test for replacing blank strings
testthat::test_that("Blank strings should be replaced.", {
        testthat::expect_equal(repwithna(df), df_output_1)
})

# test for replacing strings containing only symbols
testthat::test_that("Blank strings and pure symbol strings should be replaced.", {
        testthat::expect_equal(repwithna(df, rmvsym = TRUE), df_output_2)
})

# test for replacing strings that don't follow the format given
testthat::test_that("Strings that do not follow the pattern should be replaced.", {
        testthat::expect_equal(repwithna(df, format = "^[,.;]+"), df_output_3)
})

# test that spaces and symbols in the string won't be removed
testthat::test_that("Spaces and symbols in the string should not be removed.", {
        testthat::expect_equal(repwithna(test_df_2, rmvsym=TRUE), df_output_4)
})
