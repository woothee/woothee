package is.tagomor.woothee.browser;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class MSIE extends AgentCategory {
  private static Pattern msie = Pattern.compile("MSIE ([.0-9]+);");
  private static Pattern trident = Pattern.compile("Trident/([.0-9]+); rv ([.0-9]+)");

  public static boolean challenge(final String ua, final Map<String,String> result) {
    if (ua.indexOf("compatible; MSIE") >= 0 || ua.indexOf("Trident/") >= 0) {
      String version = DataSet.VALUE_UNKNOWN;

      Matcher mie = msie.matcher(ua);
      Matcher tri = trident.matcher(ua);
      if (mie.find())
        version = mie.group(1);
      else if (tri.find())
        version = tri.group(2);
      updateMap(result, DataSet.get("MSIE"));
      updateVersion(result, version);
      return true;
    }

    return false; // not MSIE (nor Sleipnir)
  }
}

