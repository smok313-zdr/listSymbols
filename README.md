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

Here are some simple examples of using the `listSymbols` function.

(Note: The `ggplot2` package has already been pre-loaded.)

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

Here's an example of applying `listSymbols` to a built-in R function `plot.default`.

```r
listSymbols(plot.default)
        Symbol      Definition
1            {            base
2           <-            base
3     function            base
4         Axis        graphics
5          box        graphics
6  plot.window        graphics
7        title        graphics
8           if            base
9            !            base
10     missing            base
11    deparse1            base
12  substitute            base
13   xy.coords       grDevices
14         log            base
15     is.null            base
16        xlab          ggplot
17           $            base
18        ylab          ggplot
19        xlim          ggplot
20       range            base
21           [            base
22   is.finite            base
23        ylim          ggplot
24    dev.hold       grDevices
25     on.exit            base
26   dev.flush       grDevices
27    plot.new        graphics
28     plot.xy        graphics
29         sub            base
30   invisible            base
31           x             arg
32           y             arg
33        type             arg
34        xlim             arg
35        ylim             arg
36         log             arg
37        main             arg
38         sub             arg
39        xlab             arg
40        ylab             arg
41         ann             arg
42        axes             arg
43  frame.plot             arg
44 panel.first             arg
45  panel.last             arg
46         asp             arg
47   xgap.axis             arg
48   ygap.axis             arg
49         ...             arg
50   localAxis locally defined
51    localBox locally defined
52 localWindow locally defined
53  localTitle locally defined
54      xlabel locally defined
55      ylabel locally defined
56          xy locally defined
```
