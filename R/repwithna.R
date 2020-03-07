#' Replacing uninformative strings with NAs
#'
#' Replace uninformative strings (eg. empty strings like '') in the data frame with NAs,
#' so they can be removed as missing values.
#' By default, empty strings will be replaced. If 'rmvpunc' is set to 'True', strings
#' containing only punctuations will also be replaced. If 'format' is set with a regular
#' expression, the function will replace all the strings of non-compliant formats with NAs.
#'
#' @param df the input data frame
#' @param rmvpunc The default value is False. If True, remove all the strings containing only punctuations
#' @param format A regular expression representing the format of the string value in the data frame
#'
#' @return data frame
#' @export
#'
#' @examples
#' repwithna(data.frame("Name" = c("  ", ",.;"), "Age" = c(21,15)), rmvpunc=True)
repwithna <- function(df, rmvpunc=FALSE, format=NULL) {
        # check input
        if (!is.data.frame(df)){
                stop('A data frame should be passed.')
        }

        if (!is.logical(rmvpunc)){
                stop('The `rmvpun` parameter should be a logical value.')
        }

        if (!is.null(format) & !(is.character(format) & length(format) == 1)){
                stop("The format should be a regular expression.")
        }


        if (is.null(format)){
                # replace empty string as NAs
                toberep <- "^[[:blank:]]*$"
                # replace strings with only punctuations (if it is asked) as NAs
                if (rmvpunc) {
                        toberep <- paste0(toberep, "|^[[:punct:]]*$")
                }
        } else {
                # replace strings that are not in the format as NAs
                toberep <- format
        }

        df <- dplyr::mutate_all(df, funs(stringr::str_replace(., toberep, "tobereplaced")))
        df <- naniar::replace_with_na_all(df, condition = ~.x == "tobereplaced")

        return(df)
}

