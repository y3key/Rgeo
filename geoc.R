## Simple example how to geocode address to get country, state, county, city name, postal code
#  Only the address with the best match will get returned, empty character if there is no match
#  Uses the HERE Geocoder API - get credentials at https://developer.here.com/.
#  Note: This software is based in part on the work of HERE Technologies.

install.packages("devtools")
library("devtools")
install.packages("RCurl")
library("RCurl")
install.packages("xml2")
library("xml2")
install.packages("urltools")
library("urltools")

# util function
removeTags=function(fullString) {
  return(gsub("<.*?>", "", fullString))
}

## geocodes an address
#  param address.input: free form address
#  param auth.id: app_id from developer.here.com
#  param auth.code: app_code from developer.here.com
#  returns a data frame with the address which has the best match
geocodeAddress=function(address.input,auth.id,auth.code) {
  address.input <- url_encode(address.input)
  env <- "" # .cit" - for Test: ".cit", for real usage: empty
  
  addressLevel <- c("Country","State","County","City","PostalCode")
  address.frame=data.frame("","","","","")
  colnames(address.frame) <- c("Country", "State", "County", "City", "PostalCode")
  
  # get xml
  xml.url <- paste0("https://geocoder",env,".api.here.com/6.2/geocode.xml?searchtext=",address.input,"&app_id=",auth.id,"&app_code=",auth.code,"&gen=8")
  xml.file <- getURL(xml.url)
  xml.data <- read_xml(xml.file)
  xml.url
  # parse xml
  matchLevel <- removeTags(xml_find_all(xml.data, ".//MatchLevel"))
  matchLevel <- matchLevel[1]
  
  if (is.na(matchLevel)) {
    it=0
  } else if (matchLevel == "country") {
    it=1
  } else if (matchLevel == "state") {
    it=2
  } else if (matchLevel == "county") {
    it=3
  } else if (matchLevel == "city") {
    it=4
  } else
    it=5
  
  if (it > 0) {
    address.full <- xml_find_all(xml.data, ".//Address")
    for (i in 1:it){
      pat <- paste0(".//",addressLevel[i])
      address.frame[i] <- c( removeTags(xml_find_all(address.full[1], pat)) )
    }
  } 
  return(address.frame)
}


