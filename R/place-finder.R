#' Geolocate an address
#' 
#' Lookup the latitude and longitude of a location using the place's
#' name or address.
#' 
#' There are charges associated with the use of this function set by 
#' your Yahoo! BOSS application. See 
#' \link{https://info.yahoo.com/legal/us/yahoo/boss/pricing/} for pricing
#' details.
#' @param location The location name or address you want to lookup
#' @param name The name of a point of interest to lookup
#' @param key The Yahoo! Developer Network BOSS application key. Register
#'   for an API key at \link{https://developer.yahoo.com/boss/}
#' @param secret The Yahoo! Developer Network BOSS application secret
#' @import httr
find_place <- function(location,
                       name,
                       key=getOption("RYDN_KEY"),
                       secret=getOption("RYDN_SECRET")){
  if (!missing(location) && !missing(name)){
    stop("Cannot provide both location and name parameter.")
  }
  
  if (missing(location) && missing(name)){
    stop("Must provide either location or name parameter.")
  }
  
  if (is.null(key) || is.null(secret)){
    stop("key and secret must both be provided")
  } 
  
  url <- "https://yboss.yahooapis.com/geo/placefinder"
  oa <- httr::oauth_app("YDN", key, secret)
  
  urlq <- paste0(url, "?flags=J&location=", URLencode(location))
  
  sig <- httr::oauth_signature(urlq, app=oa)
  
  oaqstr <- ""
  for (i in 1:length(sig)) {
    val <- sig[[i]]
    oaqstr <- paste0(oaqstr, "&", names(sig)[i], "=", val)
  }
  urlqa <- paste0(urlq, oaqstr)
  
  q <- httr::GET(urlqa)
  stop_for_status(q)
  
  res <- content(q)$bossresponse$placefinder
  do.call(rbind.data.frame, res$results)
}
