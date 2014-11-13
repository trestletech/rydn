
httr::GET("https://yboss.yahooapis.com/geo/placefinder?location=170%20South%20Market%20St.%2C%20San%20Jose%2C%20CA&flags=J")

url <- "https://yboss.yahooapis.com/geo/placefinder"


oa <- httr::oauth_app("YDN", key, secret)

urlq <- paste0(url, "?location=701+first+avenue+sunnnyvale&flags=J")

sig <- httr::oauth_signature(urlq, app=oa)

oaqstr <- ""
for (i in 1:length(sig)) {
  val <- sig[[i]]
  if (is.character(val)){
    #val <- URLencode(val, TRUE) 
  }
  oaqstr <- paste0(oaqstr, "&", names(sig)[i], "=", val)
}
urlqa <- paste0(urlq, oaqstr)

q <- httr::GET(urlqa)

