# listSymbols

[![R - >= 4.1.0](https://img.shields.io/badge/R->=_4.1.0-2ea44f?logo=r&logoColor=white)](https://cran.r-project.org/bin/windows/base/old/)

### Introduction

The purpose of listSymbols is to identify the symbols used in the body of other functions, and then determine their definitions. 
listSymbols recognizes whether the symbols in a function are: its parameters, local variables, environment variables, temporary variables (for loops), functions from loaded packages, etc.
listSymbols works with both self-implemented functions and those already built in R, as long as their body is available for browsing.

### Technical notes

The function has been implemented using 100% basic R-packages, and does not require any additional packages. 
However, in order for it to detect correctly the symbols of other functions that come from external packages like `ggplot2`, you need to load the `ggplot2` library into your environment beforehand. 
Since the function uses the basic pipe operator, it should be used with an R version no older than 4.1.0.

### Usage

Here are some simple examples of using the listSymbols function.

```r
## function to check
g <- function(s, n) {
  x <- z <- 5
  d
  for (j in 1:n) {
    print(s)
  }
  ggplot() + geom_point()
  for( i in 1:2) {} 
}

## output
listSymbols(g)
       Symbol            Definition
1           {                  base
2          <-                  base
3         for                  base
4           :                  base
5       print                  base
6           +                  base
7      ggplot                ggplot
8  geom_point                ggplot
9           s                   arg
10          n                   arg
11          x       locally defined
12          z       locally defined
13          j           temp symbol
14          i           temp symbol
15          d can't find definition
```
