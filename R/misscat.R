#' Dropping Missing Values
#'
#' Drops rows or columns containing missing values if the number of the missing values exceeds a threshold
#'
#' @param df the input tibble
#' @param k threshold (ratio of missing values to drop the row or column)
#'
#' @return data frame
#' @export
#'
#' @examples
#' missing(df, 0.2)
missing <- function(df, k) {
}
