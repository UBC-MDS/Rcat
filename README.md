
<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="img/r_logo.jpg" width="200" align = "right">

# Rcat

*R package to simplify and ease EDA process*

*Creators: Netanel Barasch, Eithar Elbasheer, Yingping Qian, Hanying
Zhang*

<!-- badges: start -->

[![R build
status](https://github.com/UBC-MDS/Rcat/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/Rcat/actions)
<!-- badges: end -->

[![codecov](https://codecov.io/gh/UBC-MDS/Rcat/branch/master/graph/badge.svg)](https://codecov.io/gh/UBC-MDS/Rcat)

Package page: <https://ubc-mds.github.io/Rcat>  
Package Vigenette:
<https://ubc-mds.github.io/Rcat/articles/Rcat-vignette.html>

### Project Overview

`Rcat` is a package that provides a collection of convenient functions
for Exploratory Data Analysis (EDA). In the early stage of a data
science project, EDA is a crucial stage to perform an initial
investigation on the dataset and inspire valuable research questions.
This package simplifies the process of detecting and dealing with
missing and suspicious values, as well as finding the relevant features.

### Functions

The following 4 functions are included in our package.

1.  `misscat`: This function drops the rows which has missing values that exceeded the minimum missing values threshold

2.  `suscat`: Datasets could include erroneous values such as outliers.
    This function detects suspected erroneous numeric data in
    user-chosen columns.

3.  `repwithna`: Datasets could include uninformative strings, such as
    strings with only punctuations or blank strings. This function
    replaces these strings with `NA` so they can be removed as missing
    values.

4.  `topcorr`: This function calculates the correlation between the
    columns and generates a list of top-correlated features in the
    dataset.

### How `Rcat` fit in the R ecosystem

There are several existing packages in R that implement similar
functionality.

  - [SmartEDA](https://cran.r-project.org/web/packages/SmartEDA/index.html)  
    This package generates descriptive statistics and visualisations for
    data frames. A HTML EDA report is also avaliable.

  - [DataExplorer](https://cran.r-project.org/web/packages/DataExplorer/index.html)  
    This package can analyze and visualize each variable in a data
    frame. It also includes common data processing methods for
    wrangling.

  - [inspectdf](https://cran.r-project.org/web/packages/inspectdf/index.html)  
    This package offers columnwise summary, comparison and visualisation
    of data frames.

These packages all provide functions reporting missing values and
correlations. Only `SmartEDA` has a function that runs univariate
outlier analysis. And to deal with missing values, only `DataExplorer`
has a function to set all missing values to indicated value.

Thus in R ecosystem, there are many well-defined packages with useful
functions for EDA, but there is yet no package containing these
different EDA methods. With our package, we hope to incorporate these
functions to help the users deal with missing values, outliers and
correlations with one simplest way when they are exploring the data set.

## Installation

You can install the development version of Rcat from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/Rcat")
```

## Usage

The examples used below are based on `iris` from R’s build in datasets.
For demo purpose, we will insert some missing and erroneous values into
this dataset.

``` r
iris_df <- head(iris, 5)
iris_df[1, 1:3] <- NA
iris_df[5, 2] <- NA
levels(iris_df$Species) <- c(levels(iris_df$Species), "")
iris_df[3, 5] <- ""
```

The example dataframe is shown below:

| Sepal.Length | Sepal.Width | Petal.Length | Petal.Width | Species |
| ------------ | ----------- | ------------ | ----------- | ------- |
| NA           | NA          | NA           | 0.2         | setosa  |
| 4.9          | 3.0         | 1.4          | 0.2         | setosa  |
| 4.7          | 3.2         | 1.3          | 0.2         |         |
| 4.6          | 3.1         | 1.5          | 0.2         | setosa  |
| 5.0          | NA          | 1.4          | 0.2         | setosa  |

### 1\. misscat

**Arguments**

  - `df`, the input data frame (data.frame)
  - `threshold`, ratio of minimum missing values to drop the row (numeric)

**Returns**

  - a dataframe after dropping rows (data.frame)

**Examples**

``` r
library(Rcat)
misscat(df=iris_df, threshold=0.5)
```

The expected output is shown below:

| Sepal.Length | Sepal.Width | Petal.Length | Petal.Width | Species |
| ------------ | ----------- | ------------ | ----------- | ------- |
| 4.9          | 3.0         | 1.4          | 0.2         | setosa  |
| 4.7          | 3.2         | 1.3          | 0.2         |         |
| 4.6          | 3.1         | 1.5          | 0.2         | setosa  |
| 5.0          | NA          | 1.4          | 0.2         | setosa  |

### 2\. suscat

suscat(df, columns, n = 1, num = ‘percent’)

**Arguments**

  - `df`, the input data frame (data.frame)
  - `columns`, vector like with names of columns to test (vector)
  - `n`, an integer value for amount of suspected values to return
  - `num`, the optional parameter specifies the whether n is a number of
    rows or percentage

**Returns**

  - list of named vectors containing row numbers per column

**Examples**

``` r
library(Rcat)
suscat(iris, c("Sepal.Length"))
```

The expected output is shown below:

$Sepal.Length \[1\] 9 14 39 43 132

### 3\. repwithna

**Arguments**

  - `df`, the input data frame (data.frame)

**Returns**

  - a dataframe after replacing uninformative string with NA
    (data.frame)

**Examples**

``` r
library(Rcat)
repwithna(df=iris_df)
```

The expected output is shown below:

| Sepal.Length | Sepal.Width | Petal.Length | Petal.Width | Species |
| ------------ | ----------- | ------------ | ----------- | ------- |
| NA           | NA          | NA           | 0.2         | setosa  |
| 4.9          | 3.0         | 1.4          | 0.2         | setosa  |
| 4.7          | 3.2         | 1.3          | 0.2         | NA      |
| 4.6          | 3.1         | 1.5          | 0.2         | setosa  |
| 5.0          | NA          | 1.4          | 0.2         | setosa  |

### 4\. topcorr

**Arguments**

  - `df`, the input data frame (data.frame)
  - `k`, the number of feature pairs to return (intger or string,
    default: “all”)

**Returns**

  - a sorted pearson correlation data frame with top k correlated
    feature pairs (data.frame)

**Examples**

``` r
library(Rcat)
topcorr(df=iris, 2)
```

*Note: Some columns in iris\_df have zero standard deviation. We will
use the full iris dataset for demostration.*

The expected output is shown below:

| Feature 1    | Feature 2    | Absolute Correlation |
| ------------ | ------------ | -------------------- |
| Petal.Width  | Petal.Length | 0.9629               |
| Petal.Length | Sepal.Length | 0.8718               |
