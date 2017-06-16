register_shims_square_bracket <- function(env) {
  rlang::env_bind(env,
    `[` = strict_square_bracket
  )
}

#' Strict behaviour for square bracket indexing
#'
#' The effect of indexing with a factor is unclear, since factors can behave
#'   like character vectors or integer vectors, depending upon context. In
#'   strict mode, factor indexing throws an error.
#'
#' @param x The object to be indexed.
#' @param i The first index.
#' @param ... Other indexing values.
#' @examples
#' (x <- c(d = 1, c = 4, b = 9, a = 16))
#' (index <- factor(letters[1:4]))
#' # Character and integer indexing OK
#' x[as.character(index)]
#' x[as.integer(index)]
#' # Factor indexing disallowed
#' try(x[index])
strict_square_bracket <- function(x, i, ...) {
  if(is.factor(i)) {
    stop("Indexing with a factor is disallowed.")
  } else base::`[`(x, i, ...)
}

