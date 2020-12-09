
PAYLOAD  = c( "Payload" )
QUESTION = c( "SQ" )
DFLT_NAS = list( "", " ", "-99", -99 )

#' @export
#' @importFrom jsonlite fromJSON
survey <- function( file ) {
  qsf <- jsonlite::fromJSON( file )
  assert_valid_qsf( qsf )
  s <- qsf$
  return( s )
}

#' @export
survey_get_questions <- function( s ) {
  ret <- qsf_element_selector( s$qsf, QUESTION )
  return( ret )
}

qsf_element_selector <- function( qsf, elt, value=c( "attr", "payload", "all" ) ) {
  value <- match.arg( value )
  cflt <- switch( value,
    attr    = which( !names( qsf$SurveyElements ) %in% PAYLOAD ),
    payload = which(  names( qsf$SurveyElements ) %in% PAYLOAD ),
    all     = 1:ncol( qsf$SurveyElements )
  )
  rflt <- qsf$SurveyElements$Element %in% elt
  ret <- qsf$SurveyElements[ rflt, cflt ]
  return( ret )
}

qsf_get_payload_attrs <- function( pls, ... ) {
  attrs <- list( ... )
  ret <- pls %>% sapply( function( pl ) pl %>% as.list() %>% `[`( attrs ) ) %>% t()
  return( ret %>% as.data.frame() )
}
