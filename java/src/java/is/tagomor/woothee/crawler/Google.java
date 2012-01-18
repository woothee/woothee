package is.tagomor.woothee.crawler;

import java.util.Map;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Google extends AgentCategory {
  public static boolean challenge(final String useragent, final Map<String,String> result) {
    if (useragent.indexOf("Google") < 0)
      return false;
    
    if (useragent.indexOf("compatible; Googlebot") > -1) { // Googlebot or Googlebot-Mobile
      if (useragent.indexOf("compatible; Googlebot-Mobile") > -1) {
        updateMap(result, DataSet.get("GoogleBotMobile"));
        return true;
      }
      else {
        updateMap(result, DataSet.get("GoogleBot"));
        return true;
      }
    }
    if (useragent.indexOf("Googlebot-Image/") > -1) {
      updateMap(result, DataSet.get("GoogleBot"));
      return true;
    }
    if (useragent.indexOf("Mediapartners-Google") > -1) {
      if (useragent.indexOf("compatible; Mediapartners-Google") > -1 || useragent.equals("Mediapartners-Google")) {
        updateMap(result, DataSet.get("GoogleMediaPartners"));
        return true;
      }
    }
    if (useragent.indexOf("Feedfetcher-Google;") > -1) {
      updateMap(result, DataSet.get("GoogleFeedFetcher"));
      return true;
    }
    if (useragent.indexOf("AppEngine-Google") > -1) {
      updateMap(result, DataSet.get("GoogleAppEngine"));
      return true;
    }
    if (useragent.indexOf("Google Web Preview") > -1) {
      updateMap(result, DataSet.get("GoogleWebPreview"));
      return true;
    }

    return false;
  }
}
