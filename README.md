# rydn

R interface to the Yahoo! Developers Network APIs.

Currently focused on the [BOSS APIs](https://developer.yahoo.com/boss/) to do geolocation. At the moment, the following APIs are supported:

 - [PlaceFinder](https://developer.yahoo.com/boss/placefinder/)

## API Key

In order to use this package, you'll need to register an application with Yahoo!. You can do that [here](https://developer.apps.yahoo.com/dashboard/createKey.html?api=boss).

## Pricing

The Yahoo! BOSS APIs are non-open, commercial APIs that have charges associated with them. You can find more information about pricing [here](https://info.yahoo.com/legal/us/yahoo/boss/pricing/).

## Todo

  - [ ] It looks like you can do <= 2,000 queries per day for free via a YQL interface for non-commercial usage. [More info](https://developer.yahoo.com/boss/geo/docs/free_YQL.html#table_pf). We should support this.
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