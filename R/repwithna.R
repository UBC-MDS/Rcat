#' Replacing uninformative strings with NAs
#'
#' Replace uninformative strings (eg. empty strings like '') in the data frame with NAs,
#' so they can be removed as missing values.
#' By default, empty strings will be replaced. If 'rmvsym' is set to 'True', strings
#' containing only symbols will also be replaced. If 'format' is set with a regular
#' expression, the function will replace all the strings of non-compliant formats with NAs.
#'
#' @param df the input data frame
#' @param rmvsym The default value is False. If True, remove all the strings containing only symbols
#' @param format A regular expression representing the format of the string value in the data frame
#'
#' @return data frame
#' @export
#'
#' @examples
#' repwithna(data.frame("Name" = c("  ", ",.;"), "Age" = c(21,15)), rmvsym=TRUE)
repwithna <- function(df, rmvsym=FALSE, format=NULL) {
        # check input
        if (!is.data.frame(df)){
                stop('A data frame should be passed.')
        }

        if (!is.logical(rmvsym)){
                stop('The `rmvpun` parameter should be a logical value.')
        }

        if (!is.null(format) & !(is.character(format) & length(format) == 1)){
                stop("The format should be a regular expression.")
        }


        if (is.null(format)){
                # replace empty string as NAs
                toberep <- "^[[:blank:]]*$"
                # replace strings with only symbols (if it is asked) as NAs
                if (rmvsym) {
                        toberep <- paste0(toberep, "|^[[:punct:]]*$")
                }
        } else {
                # replace strings that are not in the format as NAs
                toberep <- paste0('^(?!', format, ').*$')
        }

        df[sapply(df, function(x) !is.numeric(x))] <- dplyr::mutate_all(df[sapply(df, function(x) !is.numeric(x))], list(~stringr::str_replace(., toberep, "NA")))
        df[sapply(df, function(x) !is.numeric(x))] <- naniar::replace_with_na_all(df[sapply(df, function(x) !is.numeric(x))], condition = ~.x == "NA")

        return(df)
}

