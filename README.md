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
