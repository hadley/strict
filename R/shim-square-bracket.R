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
#' # Character and integer indexing is OK.
#' x[as.character(index)]
#' x[as.integer(index)]
#' # Factor indexing is disallowed.
#' try(x[index])
#'
#' # For higher dimension objects, passing a factor to any dimension
#' # throws an error.
#' d <- data.frame(
#'   a = 1:4, b = letters[1:4], c = runif(4),
#'   stringsAsFactors = FALSE)
#' try(d[factor(d$b), ])
#' try(d[, factor(c("a", "b"))])
strict_square_bracket <- function(x, ...) {
  #browser()
  indexers <- rlang::dots_list(..., .ignore_empty = "all")
  if(any(vapply(indexers, is.factor, logical(1L)))) {
    stop("Indexing with a factor has unclear behavior. Explicitly coerce your index to a character or integer vector.")
  } else base::`[`(x, ...)
}

