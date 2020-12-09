#' @export
xls_date <- function( d, UTC.delta=4, format=NA, origin="1899-12-30" ) {
  ret <- d %>% as.numeric() * 3600 * 24 + UTC.delta %>% as.POSIXct( origin=origin )
  ret <- if( !is.na( format ) ) as.character( ret, format=format ) else ret
  return( ret )
}
