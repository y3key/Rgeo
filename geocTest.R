## Test of geoc.R
#  Note: This software is based in part on the work of HERE Technologies.

# install required libraries
install.packages("devtools")
library("devtools")
install.packages("RCurl")
library("RCurl")
install.packages("xml2")
library("xml2")
install.packages("urltools")
library("urltools")

library("testthat")

source("geoc.R")

## Execute once, before the start of all tests
auth.id="YOUR_APP_ID"
auth.code="YOUR_APP_CODE"
if (auth.id == "YOUR_APP_ID" || auth.code == "YOUR_APP_CODE") {
  print("ERROR: YOU HAVE TO USE VALID CREDENTIALS!")
}

test.frame=data.frame("","","","","")
colnames(test.frame) <- c("Country", "State", "County", "City", "PostalCode")

testDesc=function(desc) {
  print(paste("Test Case: ", desc))
}

### Execute Tests

testDesc("valid city as input, valid credentials")
test.input = "Berlin"
test.frame=geocodeAddress(test.input,auth.id,auth.code)
# assert: city identified
expect_that(test.frame$City[1] == test.input, is_true())
# assert: no postal code found
expect_that(test.frame$PostalCode[1] == "", is_true())

testDesc("city name wich results in multiple matches")
test.input = "Springfield"
test.frame=geocodeAddress(test.input,auth.id,auth.code)
# assert: only 1 address returned
expect_that(nrow(test.frame) == 1, is_true())

testDesc("test encoding (space)")
test.input="times square new york"
test.frame=geocodeAddress(test.input,auth.id,auth.code)
# assert: correct city found
expect_that(test.frame$City[1] == "New York", is_true())

testDesc("invalid input")
test.input="not_an_address"
test.frame=geocodeAddress(test.input,auth.id,auth.code)
# assert: empty character returned for city
expect_that(test.frame$City[1] == "", is_true())

