# strict_drop errors instead of returning TRUE

    Code
      strict_drop(c(TRUE))
    Condition
      Error in `strict_abort()`:
      ! [strict]
      Please explicitly specify `drop` when selecting a single column
      Please see ?strict_drop for more details
    Code
      strict_drop(1)
    Condition
      Error in `strict_abort()`:
      ! [strict]
      Please explicitly specify `drop` when selecting a single column
      Please see ?strict_drop for more details
    Code
      strict_drop("a")
    Condition
      Error in `strict_abort()`:
      ! [strict]
      Please explicitly specify `drop` when selecting a single column
      Please see ?strict_drop for more details

