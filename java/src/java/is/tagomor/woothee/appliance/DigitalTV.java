package is.tagomor.woothee.appliance;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class DigitalTV extends AgentCategory {
  public static boolean challenge(final String ua, final Map<String,String> result) {
    Map<String,String> data = null;

    if (ua.indexOf("InettvBrowser/") > -1) {
      data = DataSet.get("DigitalTV");
    }

    if (data == null)
      return false;

    updateMap(result, data);
    return true;
  }
}
