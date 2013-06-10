package is.tagomor.woothee.crawler;

import java.util.Map;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Crawlers extends AgentCategory {
  public static boolean challenge(final String ua, final Map<String,String> result) {
    if (ua.indexOf("Yahoo") > -1 ||
        ua.indexOf("help.yahoo.co.jp/help/jp/") > -1 ||
        ua.indexOf("listing.yahoo.co.jp/support/faq/") > -1 ) {
      if (ua.indexOf("compatible; Yahoo! Slurp") > -1) {
        updateMap(result, DataSet.get("YahooSlurp"));
        return true;
      }
      else if (ua.indexOf("YahooFeedSeekerJp") > -1 || ua.indexOf("YahooFeedSeekerBetaJp") > -1) {
        updateMap(result, DataSet.get("YahooJP"));
        return true;
      }
      else if (ua.indexOf("crawler (http://listing.yahoo.co.jp/support/faq/") > -1 ||
               ua.indexOf("crawler (http://help.yahoo.co.jp/help/jp/") > -1) {
        updateMap(result, DataSet.get("YahooJP"));
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
    else if (ua.indexOf("FeedBurner/") > -1) {
      updateMap(result, DataSet.get("FeedBurner"));
      return true;
    }
    else if (ua.indexOf("facebookexternalhit") > -1) {
      updateMap(result, DataSet.get("facebook"));
      return true;
    }
    else if (ua.indexOf("ichiro") > -1) {
      if (ua.indexOf("http://help.goo.ne.jp/door/crawler.html") > -1 || ua.indexOf("compatible; ichiro/mobile goo;") > -1) {
        updateMap(result, DataSet.get("goo"));
        return true;
      }
    }
    else if (ua.indexOf("gooblogsearch/") > -1) {
        updateMap(result, DataSet.get("goo"));
        return true;
    }
    else if (ua.indexOf("Apple-PubSub") > -1) {
      updateMap(result, DataSet.get("ApplePubSub"));
      return true;
    }
    else if (ua.indexOf("(www.radian6.com/crawler)") > -1) {
      updateMap(result, DataSet.get("radian6"));
      return true;
    }
    else if (ua.indexOf("Genieo/") > -1) {
        updateMap(result, DataSet.get("Genieo"));
        return true;
    }
    else if (ua.indexOf("labs.topsy.com/butterfly/") > -1) {
      updateMap(result, DataSet.get("topsyButterfly"));
      return true;
    }
    else if (ua.indexOf("rogerbot/1.0 (http://www.seomoz.org/dp/rogerbot") > -1) {
      updateMap(result, DataSet.get("rogerbot"));
      return true;
    }
    else if (ua.indexOf("compatible; AhrefsBot/") > -1) {
      updateMap(result, DataSet.get("AhrefsBot"));
      return true;
    }
    else if (ua.indexOf("livedoor FeedFetcher") > -1 || ua.indexOf("Fastladder FeedFetcher") > -1) {
      updateMap(result, DataSet.get("livedoorFeedFetcher"));
      return true;
    }
    else if (ua.indexOf("Hatena ") > -1) {
      if (ua.indexOf("Hatena Antenna") > -1 || ua.indexOf("Hatena Pagetitle Agent") > -1 || ua.indexOf("Hatena Diary RSS") > -1) {
        updateMap(result, DataSet.get("Hatena"));
        return true;
      }
    }
    else if (ua.indexOf("mixi-check") > -1 || ua.indexOf("mixi-crawler") > -1 || ua.indexOf("mixi-news-crawler") > -1) {
      updateMap(result, DataSet.get("mixi"));
      return true;
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
