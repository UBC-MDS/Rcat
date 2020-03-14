#' Detect suspected erroneous numeric data in user chosen columns
#'
#' @param df A dataframe or matrix like object
#' @param column vector like with names of columns to test
#' @param n default to 1, integer number or percentage of suspected values to identify
#' @param num either "number" if n should be read as a number of rows or 'percentage' if a percentage of total rows
#'
#' @return list of named vectors containing row numbers per column
#' @export
#'
#' @examples
#' suscat(iris, col = c('Sepal.Width', 'Petal.Width'))
suscat  <- function(df, column = NULL, n = 5, num = 'percent'){

  #testing inputs
  if (!is.data.frame(df)){
      stop('df should be Dataframe object')
  }
  if(!is.character(column)){
      stop('column should be a vector of column names')
  }
  if(!is.numeric(n)){
      stop('n should be an numeric')
  }
  if(!(num %in% c("number",'percent'))){
    stop('num should have one of the following values: "number","percent"')

  }
  if((num == 'percent') && (n > 100)){
    stop('percents should be between 0 and 100')
  }
  if((num == 'number') &&(n > nrow(df))){
    stop('Cannot return more then nrow(df) suspected outliers')
  }
  if((num == 'number') &&(n%%1!=0)){
    stop('Number of rows must be an integer')
  }
  if(num =='percent'){
    alpha <- n/100

  } else if (num == 'number'){
    alpha <- (n+1)/(nrow(df)+1)
  }

  output <- list()
  for(i in column){
    #isolate relavent column
    a <- df[[i]]
    # find upper and lower quantile values
    low <- stats::quantile(a,probs = alpha/2 )
    high <- stats::quantile(a,probs = 1-alpha/2 )
    #extract index of rows outside CI and combine
    temp <- c(which(a<low), which(a>high))
    # filter unique and sort, add to named list
    output[[i]] <- sort(unique(temp))
  }
  return(output)
}
