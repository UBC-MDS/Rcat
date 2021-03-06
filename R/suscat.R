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

  # test inputs in helper function
  suscat_input_test(df = df, column = column, n = n, num = num)

  # defining alpha based on designation of num type
  alpha <- ((n+1)/(nrow(df)+1))*(num == 'number') + (n/100)*(num == 'percent')

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


#' Test suscat inputs suspected erroneous numeric data in user chosen columns
#' @noRd
#'
suscat_input_test  <- function(df, column = NULL, n = 5, num = 'percent'){
  #test df type
  if (!is.data.frame(df)){
    stop('df should be Dataframe object')
  }
  # test vector type of column
  if(!is.character(column)){
    stop('column should be a vector of column names')
  }
  # test type of n
  if(!is.numeric(n)){
    stop('n should be an numeric')
  }
  # test num value
  if(!(num %in% c("number",'percent'))){
    stop('num should have one of the following values: "number","percent"')
  }
  # test num and n interaction
  if((num == 'percent') && (n > 100)){
    stop('percents should be between 0 and 100')
  }
  if((num == 'number') &&(n > nrow(df))){
    stop('Cannot return more then nrow(df) suspected outliers')
  }
  if((num == 'number') &&(n%%1!=0)){
    stop('Number of rows must be an integer')
  }
}
