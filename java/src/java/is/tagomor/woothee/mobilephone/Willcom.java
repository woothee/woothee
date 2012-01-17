package is.tagomor.woothee.mobilephone;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Willcom extends AgentCategory {
  // capture Terminal Name
  public static Pattern willcomVersion = Pattern.compile("(?:WILLCOM|DDIPOCKET);[^/]+/([^ /;\\(\\)]+)");
  // public to be refered by os.MobilePhone

  public static boolean challenge(final String ua, final Map<String,String> result) {
    int pos = ua.indexOf("WILLCOM");
    if (pos < 0)
      pos = ua.indexOf("DDIPOCKET");
    if (pos < 0)
      return false;

    String version = DataSet.VALUE_UNKNOWN;

    Matcher willcom = willcomVersion.matcher(ua);
    if (willcom.find(pos))
      version = willcom.group(1);
    updateMap(result, DataSet.get("willcom"));
    updateVersion(result, version);
    return true;
  }
}
