package is.tagomor.woothee.crawler;

import java.util.Map;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Crawlers extends AgentCategory {
  public static boolean challenge(final String ua, final Map<String,String> result) {
    if (ua.indexOf("Yahoo") > -1) {
      if (ua.indexOf("compatible; Yahoo! Slurp;") > -1) {
        updateMap(result, DataSet.get("YahooSlurp"));
        return true;
      }
      else if (ua.indexOf("YahooFeedSeekerJp") > -1 || ua.indexOf("YahooFeedSeekerBetaJp") > -1) {
        updateMap(result, DataSet.get("YahooJPFeedSeeker"));
        return true;
      }
      else if (ua.indexOf("Yahoo Pipes") > -1) {
        updateMap(result, DataSet.get("YahooPipes"));
        return true;
      }
    }
    else if (ua.indexOf("msnbot") > -1) {
      updateMap(result, DataSet.get("msnbot"));
      return true;
    }
    else if (ua.indexOf("bingbot") > -1) {
      if (ua.indexOf("compatible; bingbot") > -1) {
        updateMap(result, DataSet.get("bingbot"));
        return true;
      }
    }
    else if (ua.indexOf("Baidu") > -1) {
      if (ua.indexOf("compatible; Baiduspider") > -1 || ua.indexOf("Baiduspider+") > -1 || ua.indexOf("Baiduspider-image+") > -1) {
        updateMap(result, DataSet.get("Baiduspider"));
        return true;
      }
    }
    else if (ua.indexOf("Yeti") > -1) {
      if (ua.indexOf("http://help.naver.com/robots") > -1) {
        updateMap(result, DataSet.get("Yeti"));
        return true;
      }
    }
    else if (ua.indexOf("facebookexternalhit") > -1) {
      updateMap(result, DataSet.get("facebook"));
      return true;
    }
    else if (ua.indexOf("ichiro") > -1) {
      if (ua.indexOf("http://help.goo.ne.jp/door/crawler.html") > -1 || ua.indexOf("compatible; ichiro/mobile goo;") > -1) {
        updateMap(result, DataSet.get("gooIchiro"));
        return true;
      }
    }
    else if (ua.indexOf("Apple-PubSub") > -1) {
      updateMap(result, DataSet.get("ApplePubSub"));
      return true;
    }
    else if (ua.indexOf("livedoor FeedFetcher") > -1) {
      updateMap(result, DataSet.get("livedoorFeedFetcher"));
      return true;
    }
    else if (ua.indexOf("Hatena ") > -1) {
      if (ua.indexOf("Hatena Antenna") > -1 || ua.indexOf("Hatena Pagetitle Agent") > -1 || ua.indexOf("Hatena Diary RSS") > -1) {
        updateMap(result, DataSet.get("Hatena"));
        return true;
      }
    }
    else if (ua.indexOf("Indy Library") > -1) {
      if (ua.indexOf("compatible; Indy Library") > -1) {
        updateMap(result, DataSet.get("IndyLibrary"));
        return true;
      }
    }

    return false;
  }
}
