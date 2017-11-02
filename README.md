# Rgeo
Geocoding in R

geoc.R is a simple example how to geocode an address in R.
R is a free software environment for statistical computing.
If you want to group by administrative areas (e.g. country, city), you can geocode your addresses.

The geocoding is done by using the HERE Geocoder API: https://developer.here.com/.
You have to provide a valid app_id and app_code for authorization!

Only the address with the best match is considered, other addresses are ignored.
If there is no match, you get empty characters for the address elements.

Administrative areas:
* Country
* State
* County
* City
* PostalCode

The address information is stored in a data frame.

Examples:
See geocTest.R

Note:
This software is based in part on the work of HERE Technologies!
