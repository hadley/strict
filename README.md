
<!-- README.md is generated from README.Rmd. Please edit that file -->

# strict

[![Travis-CI Build
Status](https://travis-ci.org/hadley/strict.svg?branch=master)](https://travis-ci.org/hadley/strict)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/strict)](https://cran.r-project.org/package=strict)
[![Coverage
Status](https://img.shields.io/codecov/c/github/hadley/strict/master.svg)](https://codecov.io/github/hadley/strict?branch=master)

The goal of strict is to make R behave a little more strictly, making
base functions more likely to throw an error rather than returning
potentially ambiguous results.

`library(strict)` forces you to confront potential problems now, instead
of in the future. This has both pros and cons: often you can most easily
fix a potential ambiguity when your working on the code (rather than in
six months time when you’ve forgotten how it works), but it also forces
you to resolve ambiguities that might never occur with your code/data.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("hadley/strict")
```

## Features

`library(strict)` affects code in the current script/session only
(i.e. it doesn’t affect code in others packages).

- An alternative conflict resolution mechanism. Instead of warning about
  conflicts on package load and letting the last loaded package win,
  strict throws an error when you access ambiguous functions:

  ``` r
  library(strict)
  library(plyr)
  library(Hmisc)
  #> Error in library(package, help = help, pos = pos, lib.loc = lib.loc, character.only = TRUE, : there is no package called 'Hmisc'

  is.discrete
  #> function (x) 
  #> is.factor(x) || is.character(x) || is.logical(x)
  #> <bytecode: 0x10703b498>
  #> <environment: namespace:plyr>
  ```

  (Thanks to @[krlmlr](https://github.com/krlmlr) for this neat idea!)

- Shims for functions with “risky” arguments, i.e. arguments that either
  rely on global options (like `stringsAsFactors`) or have computed
  defaults that 90% evaluate to one thing (like `drop`). strict forces
  you to supply values for these arguments.

  ``` r
  library(strict)
  mtcars[, 1]
  #>  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
  #> [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
  #> [31] 15.0 21.4

  data.frame(x = "a")
  #> Error in `strict_abort()` at strict/R/shim-risky.R:10:3:
  #> ! [strict]
  #> Please supply a value for `stringsAsFactors` argument.
  #> Please see ?strict_arg for more details
  ```

- Automatically sets options to warn when partial matching occurs.

  ``` r
  library(strict)

  df <- data.frame(xyz = 1)
  df$x
  #> Warning in df$x: partial match of 'x' to 'xyz'
  #> [1] 1
  ```

- `T` and `F` generate errors, forcing you to use `TRUE` and `FALSE`.

  ``` r
  library(strict)
  T
  #> Error in `strict_abort()` at strict/R/shims.R:21:9:
  #> ! [strict]
  #> Please use TRUE, not T
  ```

- `sapply()` throws an error suggesting that you use the type-safe
  `vapply()` instead. `apply()` throws an error if you use it with a
  data frame.

  ``` r
  library(strict)
  sapply(1:10, sum)
  #> Error in `strict_abort()` at strict/R/shim-apply.R:33:3:
  #> ! [strict]
  #> Please use `vapply()` instead of `sapply()`.
  #> Please see ?strict_sapply for more details
  ```

- `:` will throw an error instead of creating a decreasing sequence that
  terminates in 0.

  ``` r
  library(strict)

  x <- numeric()
  1:length(x)
  #> Error in `strict_abort()` at strict/R/shim-colon.R:15:5:
  #> ! [strict]
  #> Tried to create descending sequence 1:0. Do you want to `seq_along()` instead?
  #> 
  #> Please see ?shim_colon for more details
  ```

- `diag()` and `sample()` throw an error if given scalar `x`. This
  avoids an otherwise unpleasant surprise.

  ``` r
  library(strict)

  sample(5:3)
  #> [1] 5 3 4
  sample(5:4)
  #> [1] 5 4
  lax(sample(5:5))
  #> [1] 4 2 1 3 5

  sample(5:5)
  #> Error in `strict_abort()` at strict/R/shim-scalar.R:33:5:
  #> ! [strict]
  #> `sample()` has surprising behaviour when `x` is a scalar.
  #> Use `sample.int()` instead.
  #> Please see ?strict_sample for more details
  ```

Once strict is loaded, you can continue to run code in a lax manner
using `lax()`.
