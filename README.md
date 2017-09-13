<!-- README.md is generated from README.Rmd. Please edit that file -->
LTable
======

This package is developed for those who wanna make quick LaTeX code for tables from the results obtained in R environment.

Example
-------

You install the package by running

``` r
devtools::install_github("yukai-yang/LTable")
```

and attach the package by running

``` r
library("LTable")
```

The "rules of the game" is that, you input matrices, data.frames, or lists of matrices and data.frames into "...", elements in "..." will be binded by row, and if the element is a list, then its elements will be binded by column.

In the following, there is a basic example which shows you how to write prompt LaTeX based on R objects:

``` r
x = matrix(rnorm(9),3,3)
y = data.frame(a=c('a','b','c','d'),b=1:4)
z = matrix(0,2,5)
LTable(y,caption="Hello!",list(round(x,2),z),label="tab:hi",indent=TRUE)
#> \begin{table}
#>   \centering
#>   \begin{tabular}{cccccccc}
#>     \hline
#>     \hline
#>      a & 1 &  &  &  &  &  &  \\
#>     \hline
#>      b & 2 &  &  &  &  &  &  \\
#>     \hline
#>      c & 3 &  &  &  &  &  &  \\
#>     \hline
#>      d & 4 &  &  &  &  &  &  \\
#>     \hline
#>      -1.66 & 0.08 & -1.93 & 0 & 0 & 0 & 0 & 0 \\
#>     \hline
#>      0.02 & -0.55 & 0.25 & 0 & 0 & 0 & 0 & 0 \\
#>     \hline
#>      0.35 & 0.77 & 0.56 &  &  &  &  &  \\
#>     \hline
#>     \hline
#>   \end{tabular}
#>   \caption{Hello!}
#>   \label{tab:hi}
#> \end{table}
```
