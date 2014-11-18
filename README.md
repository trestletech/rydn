# rydn

R interface to the Yahoo! Developers Network APIs.

Currently focused on the [BOSS APIs](https://developer.yahoo.com/boss/) to do geolocation. At the moment, the following APIs are supported:

 - [PlaceFinder](https://developer.yahoo.com/boss/placefinder/)

## API Key

In order to use this package, you'll need to register an application with Yahoo!. You can do that [here](https://developer.apps.yahoo.com/dashboard/createKey.html?api=boss).

## Pricing

The Yahoo! BOSS APIs are non-open, commercial APIs that have charges associated with them. You can find more information about pricing [here](https://info.yahoo.com/legal/us/yahoo/boss/pricing/).

## FAQ

**Why another Geocoder for R?**

TL;DR: Every free API I looked at either couldn't geocode intersections properly, had overall low quality on the samples I tried, and/or required that I display the results on their branded map. Every commercial option I looked at was cost-prohibitive (thousands of dollars per year to start). Yahoo! BOSS offered a more reasonable price structure and seems to have high quality.

It turns out that most freely available Geocoders have pretty stringent limitations on what you're allowed to do with their data. Below are a few options and why they didn't work for particular applications of mine. (You should check for yourself, as these restrictions/problems may have changed since I last looked at the service, or I may have misunderstood them.)

 - [**MapQuest Open**](http://developer.mapquest.com/web/products/open/geocoding-service) - Mapquest provides an API around Open Street Map data that can do geocoding, but it's featureset and accuracy is somewhat limited. It also can't do cross-street geocoding ("Main St and Harper Ave").
 - [**MapQuest Commercial**](http://developer.mapquest.com/web/products/open/geocoding-service) - A commercially licensed geocoder that is more accurate and does cross-street geocoding. If memory serves, they'll give you a limited number of queries on their Commercial geocoder for free, but the service is geared towards customers entering their data into your service directly, and you're required to show the results on a MapQuest map, which you might not want to do. Purchasing access to the commercial license was cost-prohibitive for me. From [their FAQ](http://developer.mapquest.com/web/tools/getting-started/platform/dev-faq):
 
> Geocoding usage in the Community Edition on Licensed Data is limited to only the locations entered by an end user or that you have uploaded through our Data Manager tool. Geocodes under the Community Edition on Licensed Data cannot be stored for use outside the MapQuest service. If you would like more flexible options for geocode use, please contact MapQuest Platform Services to learn more about our extended rights geocoding product. Geocoding on Open Data has different terms, please check the Terms of Use for details.

 - [**Google**](https://developers.google.com/maps/documentation/geocoding/) - A great geocoder with serious restrictions. "The Geocoding API may only be used in conjunction with a Google map; geocoding results without displaying them on a map is prohibited." Commercial licensing was cost-prohibitive for me.
 
 - [**Nokia HERE**](https://developer.here.com/) - Same [restriction](https://developer.here.com/terms-conditions-base) about showing the geocoded results on one of their branded maps. "You may not use Results (i) without a HERE map or underlying imagery with exception of standalone usage for directions, places, geocoding and traffic, or (ii) in connection with a third party map, street level or satellite imagery."

## Todo

  - [x] It looks like you can do <= 2,000 queries per day for free via a YQL interface for non-commercial usage. [More info](https://developer.yahoo.com/boss/geo/docs/free_YQL.html#table_pf). We should support this.
  - [ ] Support [PlaceSpotter API](https://developer.yahoo.com/boss/placespotter/)
  - [ ] Support [Search](https://developer.yahoo.com/boss/search/)
  - [ ] [Other YDN products](https://developer.yahoo.com/everything.html)

## License (MIT)

The MIT License (MIT)

Copyright (c) 2014 Trestle Technology, LLC.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.