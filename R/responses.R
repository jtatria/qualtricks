
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
load_responses_csv <- function(
  file, names.subs='\"(.*)\":\\1', colClasses="character", clean.str=TRUE, ...
) {
  nms <- ( readLines( file, n=1 ) %>% strsplit( split="," ) )[[1]]
  if( !is.null( names.subs ) ) {
    split <- strsplit( names.subs, ":" )[[1]]
    rxp <- split[1]
    sub <- split[2]
    nms %<>% gsub( rxp, sub, . )
  }
  df <- tryCatch(
    data.table::fread( file, skip="{", data.table=FALSE, colClasses=colClasses, ... ),
    error=function( e ) {
      if( grepl( "skip", e$message ) ) {
        data.table::fread( file, skip=0, data.table=FALSE, colClasses=colClasses, ... )
      }
    }
  )

  import_info <- names( df )
  # TODO: qualtricks::validate( import_info )
  names( df ) <- nms

  if( clean.str ) {
      for( col in names( df ) ) {
          clz <- class( df[[ col ]] )
          df[[ col ]] %<>%
              gsub( "^\\s+", "" , . ) %>% # leading whitepace
              gsub( "\\s+$", "" , . ) %>% # trailing whitespace
              gsub( "\"+", "\"", . )  %>% # embedded "'s
              as( clz ) # u don't mess with the type
      }
  }

  return( df )
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
