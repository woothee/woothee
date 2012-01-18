package is.tagomor.woothee.mobilephone;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Docomo extends AgentCategory {
  // capture Terminal Name
  private static Pattern docomoVersion = Pattern.compile("DoCoMo/[.0-9]+[ /]([^- /;\\(\\)\"']+)");
  private static Pattern oldFomaVersion = Pattern.compile("\\(([^;\\)]+);FOMA;");

  public static boolean challenge(final String ua, final Map<String,String> result) {
    int pos = ua.indexOf("DoCoMo");
    if (pos < 0)
      pos = ua.indexOf(";FOMA;");
    if (pos < 0) // not DoCoMo
      return false;

    String version = DataSet.VALUE_UNKNOWN;

    Matcher docomo = docomoVersion.matcher(ua);
    if (docomo.find(pos))
      version = docomo.group(1);
    else {
      Matcher foma = oldFomaVersion.matcher(ua);
      if (foma.find())
        version = foma.group(1);
    }
    updateMap(result, DataSet.get("docomo"));
    updateVersion(result, version);
    return true;
  }
}
