package is.tagomor.woothee.browser;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class MSIE extends AgentCategory {
  private static Pattern msie = Pattern.compile("MSIE ([.0-9]+);");

  public static boolean challenge(final String ua, final Map<String,String> result) {
    int pos = ua.indexOf("compatible; MSIE");
    if (pos < 0) // not MSIE (nor Sleipnir)
      return false;

    String version = DataSet.VALUE_UNKNOWN;

    Matcher mie = msie.matcher(ua);
    if (mie.find(pos))
      version = mie.group(1);
    updateMap(result, DataSet.get("MSIE"));
    updateVersion(result, version);
    return true;
  }
}

