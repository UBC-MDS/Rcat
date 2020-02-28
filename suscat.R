
#' Detect suspected erroneous numeric data in user chosen columns
#'
#' @param df A dataframe or matrix like object
#' @param col list like with numbers of columns to test 
#' @param n number or percentage of suspected values to identify
#' 
#' @return list of named lists containing row numbers 
#' @export
#'
#' @examples
#' suscat(df, col = c(1,3,5), n = 10)
#' suscat(df, col = c(1,5,4,10), n = 0.02)
suscat  <- function(df, col = NULL, n = 0.01){
  
  
  return()
}