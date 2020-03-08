#' Dropping Missing Values
#'
#' Drops rows or columns containing missing values if the number of the missing values exceeds a threshold
#'
#' @param df the input tibble
#' @param threshold threshold (ratio of missing values to drop the row or column)
#'
#' @return data frame
#' @export
#'
#' @examples
#' missing(df, 0.2)
misscat <- function(df, threshold) {

        if (!is.data.frame(df)){
                stop('Every column in your dataframe must be numeric.')
        }

        if (typeof(threshold) != "double")
                stop("Threshold must be a number")
        if(threshold < 0 | threshold > 1)
                stop("threshold is a ratio between 0 and 1")

        rows <- apply(df, 1, function(x) mean(is.na(x))) < threshold
        df <- df[rows, ]
        return(df)

}
