# throw errors for scalar x

    Code
      strict_diag(5)
    Condition
      Error in `strict_abort()`:
      ! [strict]
      `diag()` has surprising behaviour when `x` is a scalar.
      Use `diag(rep(1, x))` instead.
      Please see ?strict_diag for more details

---

    Code
      strict_sample(5)
    Condition
      Error in `strict_abort()`:
      ! [strict]
      `sample()` has surprising behaviour when `x` is a scalar.
      Use `sample.int()` instead.
      Please see ?strict_sample for more details

