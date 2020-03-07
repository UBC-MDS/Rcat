#library(testthat)
#library(tidyverse)

#' Detect suspected erroneous numeric data in user chosen columns
#'
#' @param df A dataframe or matrix like object
#' @param col vector like with names of columns to test
#' @param n default to 1, integer number or percentage of suspected values to identify
#' @param num either "number" if n should be read as a number of rows or 'percentage' if a percentage of total rows
#'
#' @return list of named vectors containing row numbers per column
#' @export
#'
#' @examples
#' suscat(df, col = c(1,3,5), n = 10)
#' suscat(df, col = c(1,5,4,10), n = 2, num = 'number')
suscat  <- function(df, column = NULL, n = 5, num = 'percent'){

  #testing inputs
  if (!is.data.frame(df)){
      stop('df should be Dataframe object')
  }
  if(!is.character(column)){
      stop('column should be a vector of column names')
  }
  if(is.integer(n)){
      stop('n should be an integer')
  }
  if(!(num %in% c("number",'percent'))){
    stop('num should have one of the following values: "number","percent"')
  }

  if((num == 'percent') && (n > 100)){
    n <- 100
  }
  if((num == 'number') &&(n > nrow(df))){
    n <- nrow(df)
  }

  if(num =='percent'){
    alpha <- n/100
  } else if (num == 'number'){

  }
  output <- list()
  for(i in column){
    #isolate relavent column
    a <- df[[i]]
    print(a)
    # find upper and lower quantile values
    low <- quantile(a,probs = alpha/2 )
    print(low)
    high <- quantile(a,probs = 1-alpha/2 )
    print(high)
    #extract index of rows outside CI and combine
    temp <- c(which(a<low), which(a>high))
    print(temp)
    # filter unique and sort, add to named list
    output[[i]] <- sort(unique(temp))
  }




  return(output)
}
