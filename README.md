<!-- README.md is generated from README.Rmd. Please edit that file -->
LTable (1.0.0)
==============

This package is developed for those who wanna make quick LaTeX code for tables from the results obtained in R environment. There is only one function in the package, "LTable" which is also the package name.

How to install
--------------

You can install the package from my repo on GitHub by running

``` r
devtools::install_github("yukai-yang/LTable")
```

provided that the package "devtools" has been installed beforehand.

Example
-------

After installing the package, you can attach the package by running

``` r
library("LTable")
```

The "rules of the game" are,

-   you input matrices, data.frames, or lists of matrices and data.frames into "...",
-   the elements in "..." will be binded by row,
-   and if the element is a list, then its elements will be binded by column.

In the following, an example is offered, showing you how to write prompt LaTeX table code based on R objects:

``` r
x = matrix(rnorm(9),3,3)
y = data.frame(a=c('a','b','c','d'),b=1:4)
z = matrix(0,2,5)
```

The three R objects are: a matrix (x), a data.frame (y), and a matrix (z). Then we run the "LTable" function:

``` r
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
#>      -1.93 & -0.3 & 1.13 & 0 & 0 & 0 & 0 & 0 \\
#>     \hline
#>      -0.47 & 0.37 & 0.76 & 0 & 0 & 0 & 0 & 0 \\
#>     \hline
#>      1.3 & 1.23 & -1.21 &  &  &  &  &  \\
#>     \hline
#>     \hline
#>   \end{tabular}
#>   \caption{Hello!}
#>   \label{tab:hi}
#> \end{table}
```

LaTeX code done!
