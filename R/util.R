
chk_pkg <- function( pkg ) {
  chk <- requireNamespace( pkg, quietly=TRUE )
}

stopf <- function( fmt, ... ) {
  stop( sprintf( fmt, ... ) )
}

warnf <- function( fmt, ... ) {
  warning( sprintf( fmt, ... ) )
}

infof <- function( fmt, ... ) {
  message( sprintf( fmt, ... ) )
}
