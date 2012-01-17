package is.tagomor.woothee.browser;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Opera extends AgentCategory {
  private static Pattern operaVerRegex = Pattern.compile("Opera[/ ]([.0-9]+)");

  public static boolean challenge(final String ua, final Map<String,String> result) {
    int pos = ua.indexOf("Opera");
    if (pos < 0) // not Opera
      return false;

    String version = DataSet.VALUE_UNKNOWN;

    // Opera (PC/Mobile/Smartphone)
    Matcher opera = operaVerRegex.matcher(ua);
    if (opera.find(pos))
      version = opera.group(1);
    updateMap(result, DataSet.get("Opera"));
    updateVersion(result, version);
    return true;
  }
}
