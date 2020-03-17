# Project Woothee

Project Woothee is multi-language user-agent strings parsers.

You can try it on demo site: http://woothee.github.io/

## Why new project?

We needs just same logic over 2 or more programming languages, for use on various frameworks, middlewares and environments.

Most important data of this project is only single set of return values, and set of test cases, for equality of results of another languages implementations.

Implementations:

* [Java](https://github.com/woothee/woothee-java) (and Hive UDF)
* [Perl](https://github.com/woothee/woothee-perl)
* [Ruby](https://github.com/woothee/woothee-ruby)
* [Python](https://github.com/woothee/woothee-python)
* [Javascript](https://github.com/woothee/woothee-js) (Node.js or browser)
* [PHP](https://github.com/woothee/woothee-php)
* [Go](https://github.com/woothee/woothee-go)
* [Rust](https://github.com/woothee/woothee-rust)

## Versions

* v1.11.1
  * Update the GSA version in testsets
* v1.11.0
  * Add Google Search App
* v1.10.0
  * Add Microsoft Edge (based on Chromium), Edge for iOS/Android
* v1.9.0
  * Add Android 9
* v1.8.0
  * Add Yandex Browser
* v1.7.0
  * Add trendictionbot crawler
  * Add Yeti 1.1 crawler user agent tests
* v1.6.0
  * Add Android Webview
  * Add curl HTTP library
* v1.5.0
  * Add BingPreview crawler
* v1.4.0
  * Add Vivaldi
* v1.3.0
  * Add Firefox for iOS
* v1.2.1
  * Fix testset bug for BlackBerry 10
* v1.2.0
  * Add Microsoft Edge, Webview of mobile phones
  * Add Windows 10, BlackBerry 10
  * Add Twitterbot
* v1.1.0
  * Add specs for blank input data
* v1.0.1
  * Add variations of MSIE11
* v1.0.0
  * Some of implementations are not v1 yet.

Version numbers are used as:
* vX.Y.Z
  * X and Y is major/minor number to control specs of dataset/testsets
  * Z is patch number for each language implementation release control
  * Z is also used for bug fix control of testsets (versions of each language implementations should be bumped up too)

## Implementations

* Java (and Hive UDF)
  * https://github.com/woothee/woothee-java
* Perl
  * https://github.com/woothee/woothee-perl
* Ruby
  * https://github.com/woothee/woothee-ruby
* Python
  * https://github.com/woothee/woothee-python
* Javascript (Node.js or browser)
  * https://github.com/woothee/woothee-js
* PHP
  * https://github.com/woothee/woothee-php
* Golang
  * https://github.com/woothee/woothee-go
* Rust
  * https://github.com/woothee/woothee-rust

## SYNOPSIS
in Java: (use java/woothee.jar)

```java
// import is.tagomor.woothee.Classifier;
// import is.tagomor.woothee.DataSet;
Map r = Classifier.parse("user agent string");

r.get("name")
// => name of browser (or string like name of user-agent)

r.get("category")
// => "pc", "smartphone", "mobilephone", "appliance", "crawler", "misc", "unknown"

r.get("os")
// => os from user-agent, or carrier name of mobile phones

r.get("version");
// => version of browser, or terminal type name of mobile phones

r.get("os_version");
// => "NT 6.3" (for Windows), "10.8.3" (for OSX), "8.0.1" (for iOS), ....
```

in Hive: (copy woothee.jar into your CLASSPATH, and create function)
```sql
-- add jar to classpath
add jar woothee.jar;
-- create function
CREATE TEMPORARY FUNCTION parse_agent as 'is.tagomor.woothee.hive.ParseAgent';
-- count visits of bots
SELECT parsed_agent['name'] AS botname, COUNT(*) AS cnt
FROM (
  SELECT parse_agent(user_agent) AS parsed_agent
  FROM table_name
  WHERE date='today'
) x
WHERE parsed_agent['category'] = 'crawler'
GROUP BY parsed_agent['name']
ORDER BY cnt DESC LIMIT 1000;
```

in Perl: (cpanm Woothee)

```perl
use Woothee;
Woothee::parse("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)");
# => {'name'=>"Internet Explorer", 'category'=>"pc", 'os'=>"Windows 7", 'version'=>"8.0", 'vendor'=>"Microsoft", 'os_version'=>"NT 6.1"}
```

in Ruby: (gem install woothee)

```ruby
require 'woothee'
Woothee.parse("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)")
# => {:name=>"Internet Explorer", :category=>:pc, :os=>"Windows 7", :version=>"8.0", :vendor=>"Microsoft", :os_version=>"NT 6.1"}
```

in Python:

```python
import woothee
woothee.parse("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)")
# => {'name': 'Internet Explorer', 'category': 'pc', 'os': 'Windows 7', 'version': '8.0', 'vendor': 'Microsoft'}
```

in Javascript(HTML, copy from release/woothee.js)
```html
<script src="./your/own/path/woothee.js"></script>
<script>
woothee.parse('Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)')
// => {name: 'Internet Explorer', category: 'pc', os: 'Windows 7', version: '8.0', vendor: 'Microsoft', os_version: 'NT 6.1'}
</script>
```

in Node.js (npm install woothee)

```javascript
var woothee = require('woothee');
woothee.parse('Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)')
// => {name: 'Internet Explorer', category: 'pc', os: 'Windows 7', version: '8.0', vendor: 'Microsoft', os_version: 'NT 6.1'}
```

in PHP (composer require woothee/woothee:\*)

```php
<?php
include __DIR__ . '/vendor/autoload.php';
$classifier = new \Woothee\Classifier;
$classifier->parse('Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)');
// => ['name' => 'Internet Explorer', 'category' => 'pc', 'os' => 'Windows 7', 'version' => '8.0', 'vendor' => 'Microsoft']
```

in Rust:

```rust
extern crate woothee;

use woothee::parser::Parser;

fn main() {
    let parser = Parser::new();
    let result = parser.parse("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)");
    println!("{:?}", result);
}
// => Some(WootheeResult { name: "Internet Explorer", category: "pc", os: "Windows 7", os_version: "NT 6.1", browser_type: "UNKNOWN", version: "8.0", vendor: "Microsoft" })
```

## Todo

* 'mobilephone' means Japanese mobile phone groups
  * For multi-region code, domestic pattern specifier (or another mechanism) needed

## FAQ

* What's Woothee?
  * http://en.wikipedia.org/wiki/Usui_Pass
  * http://ja.wikipedia.org/wiki/%E7%A2%93%E6%B0%B7%E5%B3%A0

* * * * *

## Authors

* TAGOMORI Satoshi <tagomoris@gmail.com>

## License

Copyright 2012- TAGOMORI Satoshi (tagomoris)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
