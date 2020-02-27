# Rcat
### Overview
Exploratory data analysis (EDA) is an approach to investigate and summarize a given data set before any other analyses. `Rcat` is a package that provides necessary functions for EDA, and inspires valuable research questions.

#### Function description
Functions designed in this package will focus on several aspects: 

- Uninformative strings:  
Data frames sometimes include uninformative strings such as strings with only punctuations, or blank strings, which could be noises for the later analysis. This function replaces these strings with `NA` so they can be removed as missing values.

- Missing values:  
This function summarizes the missing values in the data frame. It also sets a threshold to drop the related rows or columns with overmuch missing values.

- Erroneous values:  
Data frames could include erroneous values such as outliers. This function detects and reports all the possible erroneous values.

- Feature correlation:  
This function identifies the features with highest correlations to the target, giving insights to the later analysis of the features.

#### Alignment with ecosystems
There are several existing packages in R that implement similar functionality. 
- [SmartEDA](https://cran.r-project.org/web/packages/SmartEDA/index.html)  
This package generates descriptive statistics and visualisations for data frames. A HTML EDA report is also avaliable.
- [DataExplorer](https://cran.r-project.org/web/packages/SmartEDA/index.html)  
This package can analyze and visualize each variable in a data frame. It also includes common data processing methods for wrangling.
- [inspectdf](https://cran.r-project.org/web/packages/inspectdf/index.html)  
This package offers columnwise summary, comparison and visualisation of data frames.
