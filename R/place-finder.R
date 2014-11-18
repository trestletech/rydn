#' Geolocate an address
#' 
#' Lookup the latitude and longitude of a location using the place's
#' name or address.
#' 
#' For details about the various parameters that can be sent and, see \link{https://developer.yahoo.com/boss/geo/docs/address-formats.html#fully-parsed-format}.
#' Information about formats can be found here: \link{https://developer.yahoo.com/boss/geo/docs/address-formats.html#fully-parsed-format}.
#' 
#' There are charges associated with the use of this function set by 
#' your Yahoo! BOSS application. See 
#' \link{https://info.yahoo.com/legal/us/yahoo/boss/pricing/} for pricing
#' details.
#' @param location The location name or address you want to lookup
#' @param name The name of a place or area of interest. See \link{https://developer.yahoo.com/boss/geo/docs/address-formats.html#poi-aoi-names}
#' @param line1 First line of address (street address or intersection).
#' @param line2 Second line of address (city-state-zip in US).
#' @param line3 Third line of address (postal code in UK).
#' @param house House number.
#' @param street Street name.
#' @param unittype Unit type, such as apartment (\code{Apt}) or suite \code{Ste}.
#' @param unit Unit/suite/apartment/box number.
#' @param xstreet Cross street name.
#' @param postal Postal code.
#' @param neighborhood Yahoo's "Level 4 Administrative name." If used, \code{city},
#' \code{county}, \code{state}, and \code{country} should also be specified.
#' @param city Yahoo's "Level 3 Administrative name." If used, \code{county}, 
#' \code{state}, and \code{country} should also be specified.
#' @param county Yahoo's "Level 2 Administrative name." If used, \code{state}, 
#' and \code{country} should also be specified.
#' @param state Yahoo's "Level 1 Administrative name." If used, \code{country} 
#' should also be specified.
#' @param country Yahoo's "Level 0 Administrative name" or country code.
#' @param woeid An integer representing a "Where on Earth ID." See \link{https://developer.yahoo.com/geo/geoplanet/guide/concepts.html#woeids}
#' @param reverse \code{TRUE} if reverse geocoding (looking up a location by its
#' latitude and longitude).
#' @param locale The language and country. A two-letter ISO-639 major language 
#' code and a two-letter ISO-3166-1 alpha-2 country code, separated by either a 
#' hyphen or underscore. Default is en_US (English/US).
#' @param flags The \code{flags} parameter to pass through to the YDN query. See
#' \link{https://developer.yahoo.com/boss/geo/docs/control-parameters.html}.
#' @param gflags The \code{gflags} parameter to pass through to the YDN query. See
#' \link{https://developer.yahoo.com/boss/geo/docs/control-parameters.html}.
#' \code{R} will be added if \code{reverse=TRUE}. "J" is always added.
#' @param commercial If \code{FALSE} (the default), will use the YQL interface
#' to Yahoo's geo.placefinder table to do the geocoding. This API is currently 
#' restricted to 2,000 queries per day per app and is intended for non-commercial
#' usage. If \code{TRUE}, it will use the proper BOSS APIs directly. The 
#' commercial API is better documented and appears to occasionally return
#' better results.
#' @param key The Yahoo! Developer Network BOSS application key. Register
#'   for an API key at \link{https://developer.yahoo.com/boss/}
#' @param secret The Yahoo! Developer Network BOSS application secret
#' @return A dataframe with all results. See \link{https://developer.yahoo.com/boss/geo/docs/supported_responses.html}
#' for a description of what each field means.
#' @import httr
#' @examples
#' \dontrun{
#' find_place("151 3rd St., San Francisco, CA", commercial=TRUE)
#' find_place("151 3rd St., San Francisco, CA", commercial=FALSE)
#' find_place(name="Yosimete National Park")
#' find_place(line1="Franklin St at Broadway St, San Francisco, CA, USA 94109")
#' find_place(house="151", street="3rd St.", postal=94103, city="San Francisco", 
#'   state="CA", country="USA")
#' find_place(location="37.787082+-122.400929", reverse=TRUE)
#' }
#' @export
find_place <- function(location=NULL,
                       name=NULL,
                       line1=NULL,
                       line2=NULL,
                       line3=NULL,
                       house=NULL,
                       street=NULL,
                       unittype=NULL,
                       unit=NULL,
                       xstreet=NULL,
                       postal=NULL,
                       neighborhood=NULL,
                       city=NULL,
                       county=NULL,
                       state=NULL,
                       country=NULL,
                       woeid=NULL,
                       reverse=FALSE,
                       locale="en_US",
                       flags="",
                       gflags="",
                       commercial=FALSE,
                       key=getOption("RYDN_KEY"),
                       secret=getOption("RYDN_SECRET")){
  if (sum(missing(location), missing(woeid), missing(name)) < 2){
    stop("Can only provide either location, woeid, or name.")
  }
  
  if (!missing(location) || !missing(name) || !missing(woeid)){
    if (!missing(line1) || !missing(line2) || !missing(line3)){
      stop("Cannot provide both location and line parameters.")
    }
    if(!missing(house) || !missing(street) || !missing(unittype) || 
         !missing(unit) || !missing(xstreet) || !missing(postal) || 
         !missing(neighborhood) || !missing(city) || !missing(county) ||
         !missing(state) || !missing(country)){
      stop("Cannot provide both a location string and specific fields such as 'street' or 'city'.")
    }
  }
  
  if (!missing(line1)){
    if(!missing(house) || !missing(street) || !missing(unittype) || 
         !missing(unit) || !missing(xstreet) || !missing(postal) || 
         !missing(neighborhood) || !missing(city) || !missing(county) ||
         !missing(state) || !missing(country)){
      stop("Cannot provide both a multi-line (line1, etc.) address and specific fields such as 'street' or 'city'.")
    }
  }
  
  if (is.null(key) || is.null(secret)){
    stop("key and secret must both be provided")
  } 
  
  if (reverse){
    gflags <- paste0(gflags, "R")
  }
  
  flags <- paste0(flags, "J")
  
  qp <- list(
    location = location,
    name = name,
    line1 = line1,
    line2 = line2,
    line3 = line3,
    house = house,
    street = street,
    unittype = unittype,
    unit = unit,
    xstreet = xstreet,
    postal = postal,
    level4 = neighborhood,
    level3 = city,
    level2 = county,
    level1 = state,
    level0 = country,
    woeid = woeid,
    gflags = gflags,
    flags = flags
  )
  
  if (!commercial){
    qpOpen <- qp
    qpOpen["text"] <- qp$location
    qpOpen["location"] <- NULL
    qpOpen["flags"] <- NULL
    qs <- listToYQL(qpOpen, "geo.placefinder")
    url <- "https://query.yahooapis.com/v1/public/yql"
  } else{
    qs <- listToQS(qp)
    url <- "https://yboss.yahooapis.com/geo/placefinder"
  }
  
  oa <- httr::oauth_app("YDN", key, secret)
  
  urlq <- paste0(url, "?", qs)
  
  sig <- httr::oauth_signature(urlq, app=oa)
  
  oaqstr <- ""
  for (i in 1:length(sig)) {
    val <- sig[[i]]
    oaqstr <- paste0(oaqstr, "&", names(sig)[i], "=", val)
  }
  urlqa <- paste0(urlq, oaqstr)
  
  q <- httr::GET(urlqa)
  stop_for_status(q)
  
  if (!commercial){
    con <- content(q)
    res <- con$query$results$Result
    
    if (con$query$count > 1){
      for (i in 1:length(res)){
        res[[i]][sapply(res[[i]], is.null)] <- NA
      }  
      df <- do.call(rbind.data.frame, res)
    } else{
      res[sapply(res, is.null)] <- NA
      df <- as.data.frame(res)
    }
  } else{
    res <- content(q)$bossresponse$placefinder$results
    df <- do.call(rbind.data.frame, res)
  }
  df
}

listToQS <- function(qp){
  qs <- ""
  for (n in names(qp)){
    val <- qp[[n]]
    if (!is.null(val)){
      qs <- paste0(qs, n, "=", RCurl::curlEscape(val), "&")  
    }
  }
  
  # Trim last &
  substr(qs, 0, nchar(qs)-1)
}

listToYQL <- function(qp, table){
  qs <- paste0("SELECT * FROM ", table, " WHERE ")
  for (n in names(qp)){
    val <- qp[[n]]
    if (!is.null(val)){
      qs <- paste0(qs, n, "=", paste0('"', val, '"'), " AND ")
    }
  }
  
  # Trim last ' AND '
  qs <- substr(qs, 0, nchar(qs)-5)
  
  qs <- RCurl::curlEscape(qs)
  
  paste0("q=", qs, "&format=json")
}