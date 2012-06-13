# Project Woothee

Project Woothee is multi-language user-agent strings parsers, now contains perl and java implementations.

## Why new project?

We needs just same logic over 2 or more programming languages, for use on various frameworks, middlewares and environments.

Most important data of this project is only single set of return values, and set of test cases, for equality of results of another languages implementations.

Implemantations:

  * Java (and Hive UDF)
  * Perl
  * Ruby
  * Python

## SYNOPSIS
in Java:

    // import is.tagomor.woothee.Classifier;
    // import is.tagomor.woothee.DataSet;
    Map r = Classifier.parse("user agent string");
    
    r.get("name")
    // => name of browser (or string like name of user-agent

    r.get("category")
    // => "pc", "smartphone", "mobilephone", "appliance", "crawler", "misc", "unknown"
    
    r.get("os")
    // => os from user-agent, or carrier name of mobile phones
    
    r.get("version");
    // => version of browser, or terminal type name of mobile phones

in Hive:

    // add woothee.jar to classpath
    add jar woothee.jar;
    
    create temporary function parse_agent as 'is.tagomor.woothee.hive.ParseAgent';
    create temporary function is_pc as 'is.tagomor.woothee.hive.IsPC';
    create temporary function is_smartphone as 'is.tagomor.woothee.hive.IsSmartPhone';
    create temporary function is_mobilephone as 'is.tagomor.woothee.hive.IsMobilePhone';
    create temporary function is_appliance as 'is.tagomor.woothee.hive.IsAppliance';
    create temporary function is_crawler as 'is.tagomor.woothee.hive.IsCrawler';
    create temporary function is_misc as 'is.tagomor.woothee.hive.IsMisc';
    create temporary function is_unknown as 'is.tagomor.woothee.hive.IsUnknown';
    create temporary function is_in as 'is.tagomor.woothee.hive.IsIn';
    create temporary function pc as 'is.tagomor.woothee.hive.PC';
    create temporary function smartphone as 'is.tagomor.woothee.hive.SmartPhone';
    create temporary function mobilephone as 'is.tagomor.woothee.hive.MobilePhone';
    create temporary function appliance as 'is.tagomor.woothee.hive.Appliance';
    create temporary function crawler as 'is.tagomor.woothee.hive.Crawler';
    create temporary function misc as 'is.tagomor.woothee.hive.Misc';
    create temporary function unknown as 'is.tagomor.woothee.hive.Unknown';
    create temporary function oneof as 'is.tagomor.woothee.hive.OneOf';
    
    SELECT
      count(pc(parsed_agent)) as pc_pageviews,
      count(oneof(parsed_agent, array('pc', 'mobilephone', 'smartphone', 'appliance'))) as total_pageviews
    FROM (
      SELECT parse_agent(useragent) as parsed_agent FROM access_log WHERE date='today'
    ) x
    WHERE NOT is_crawler(parsed_agent) AND NOT is_unknown(parsed_agent)

in Perl:

    use Woothee::Classifier;
    Woothee::Classifier::parse("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)");
    # => {'name'=>"Internet Explorer", 'category'=>"pc", 'os'=>"Windows 7", 'version'=>"8.0", 'vendor'=>"Microsoft"}

in Ruby:

    require 'woothee'
    Woothee.parse("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)")
    # => {:name=>"Internet Explorer", :category=>:pc, :os=>"Windows 7", :version=>"8.0", :vendor=>"Microsoft"}

in Python:

    import woothee
    woothee.parse("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)")
    # => {'name': 'Internet Explorer', 'category': 'pc', 'os': 'Windows 7', 'version': '8.0', 'vendor': 'Microsoft'}


## Todo

* 'mobilephone' means Japanese mobile phone groups
  * For multi-region code, domestic pattern specifier (or another mechanism) needed
* Add node.js implementation

## FAQ

* What's Woothee?
    * http://en.wikipedia.org/wiki/Usui_Pass
    * http://ja.wikipedia.org/wiki/%E7%A2%93%E6%B0%B7%E5%B3%A0

* * * * *

## Authors

* TAGOMORI Satoshi <tagomoris@gmail.com>
* UEDA Tetsuhiro (najeira)

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
