#' Top correlated features
#'
#' Generates a data frame with the top k correlated pairs of features
#'
#' @param df data.frame, the input data frame
#' @param k int, The number of top correlated feature pairs
#'
#' @return data.frame, the sorted correlation data frame
#' @export
#'
#' @examples
#' topcorr(df, 2)
topcorr <- function(df, k=5) {
        # drop the non-numeric columns
        nums <- unlist(lapply(df, is.numeric))
        dfn <- df[, nums]

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

        return(head(c_df_sort, k))
}
