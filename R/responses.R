
#' @export
responses <- function( file, survey=NULL, ...  ) {
  data <- load_responses( file, ... )
  if( !is.null( survey ) ) {
    data %<>% survey_validate_responses( survey, data )
  }
  return( data )
}

#' @export
load_responses <- function( file, ... ) {
  ext <- gsub( ".*\\.(.*)", "\\1", file  )
  data <- switch( ext,
    csv  = load_responses_csv( file, ... ),
    xlsx = load_responses_xlsx( file, ... ),
    stop( sprintf( "Usupported response data format: %s", ext ) )
  )
  return( data )
}

#' @export
#' @importFrom data.table fread
load_responses_csv <- function( file, names.subs='\"(.*)\":\\1', skip="{", colClasses="character", ... ) {
  nms <- ( readLines( file, n=1 ) %>% strsplit( split="," ) )[[1]]
  if( !is.null( names.subs ) ) {
    split <- strsplit( names.subs, ":" )[[1]]
    rxp <- split[1]
    sub <- split[2]
    nms %<>% gsub( rxp, sub, . )
  }
  data <- if( chk_pkg( "data.table" ) ) {
    data.table::fread( file, skip=skip, data.table=FALSE, ... )
  } else {
    stopf( "No fallback dependency for %s. Please install package and retry.", "data.table" )
  }
  import_info <- names( data )
  # TODO: qualtricks::validate( import_info )
  names( data ) <- nms
  return( data )
}

#' @export
#' @importFrom readxl read_xlsx
load_responses_xlsx <- function( file ) {
    nms  <- readxl::read_xlsx( file, n_max=0, progress=FALSE ) %>% names()
    data <- readxl::read_xlsx( file, skip=2, col_names=nms, col_types="text", progress=FALSE )
    data$StartDate    %<>% xls_date( format="%Y-%m-%d %H:%M:%S" )
    data$EndDate      %<>% xls_date( format="%Y-%m-%d %H:%M:%S" )
    data$RecordedDate %<>% xls_date( format="%Y-%m-%d %H:%M:%S" )
    return( data )
}
