#' Top correlated features
#'
#' Generates a data frame with the top k correlated pairs of features
#'
#' @param df data.frame, the input data frame
#' @param k numeric or character, default at "all", the number of feature pairs to return
#'
#' @return data.frame, the sorted correlation data frame
#' @export
#'
#' @examples
#' topcorr(iris, 1)
#' |Feature 1|Feature 2|Correlation|
#' |---|---|---|
#' |Petal.Width|Petal.Length|0.9628654|
topcorr <- function(df, k='all') {
        # check the input of df
        if (!is.data.frame(df)) {
                stop("The input df should be a data frame!")
        }
        # check the type of k
        if (k != "all") {
                if (round(k) != k) {
                        stop("The input k should be 'all' or a positive integer!")
                }
        }

        # drop the non-numeric columns
        nums <- unlist(lapply(df, is.numeric))
        dfn <- df[, nums]
        n_features <- dim(dfn)[2]
        n_pairs <- (n_features^2 - n_features)/2

        # check the value of k
        if (k != 'all'){
                if (k < 0) {
                        stop("The input k should be a positive integer!")
                } else {
                        if (k > n_pairs) {
                                stop("The input k should be a positive integer less than number of pairs!")
                        }
                }
        }


        # get the correlation matrix and remove redundant pairs
        cmatrix <- cor(dfn)
        cmatrix[upper.tri(cmatrix, diag=TRUE)] <- NA
        c_df <- na.omit(reshape::melt(cmatrix))

        # sort by absolute values
        c_df_sort <- c_df[order(-abs(c_df$value)),]

        # format the output
        rownames(c_df_sort) <- NULL
        names(c_df_sort)[1] <- "Feature 1"
        names(c_df_sort)[2] <- "Feature 2"
        names(c_df_sort)[3] <- "Correlation"

        if (k == 'all') {
                return(c_df_sort)
        } else {
                return(head(c_df_sort, k))
        }
}
