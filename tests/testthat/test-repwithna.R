# helper data for testing
df <- data.frame("name" = c("  ", ",.;", "?mark:"), "Age" = c(21,15,12))
df_output_1 <- data.frame("name" = c(NA, ",.;", "?mark:"), "Age" = c(21, 15, 12), stringsAsFactors=FALSE)
df_output_2 <- data.frame("name" = c(NA, NA, "?mark:"), "Age" = c(21, 15, 12), stringsAsFactors=FALSE)
df_output_3 <- data.frame("name" = c(NA, ",.;", NA), "Age" = c(21, 15, 12), stringsAsFactors=FALSE)

# tests for incorrect inputs
test_that("Error is raised by passing a non-dataframe type as dataframe.", {
  expect_error(repwithna(c(1,2)))
})

test_that("Error is raised by passing a non-logical type to `rmvpunc` parameter.", {
        expect_error(repwithna(df, rmvpunc = 1))
})

test_that("Error is raised by passing a value that is not a string to `format` parameter.", {
        expect_error(repwithna(df, format = c('a', 'd')))
})

# test for replacing blank strings
test_that("Blank strings should be replaced.", {
        expect_equal(repwithna(df), df_output_1)
})

# test for replacing strings containing only punctuations
test_that("Blank strings and pure punctuation strings should be replaced.", {
        expect_equal(repwithna(df, rmvpunc = TRUE), df_output_2)
})

# test for replacing strings that don't follow the format given
test_that("Strings that do not follow the pattern should be replaced.", {
        expect_equal(repwithna(df, format = "^[,.;]+"), df_output_3)
})
