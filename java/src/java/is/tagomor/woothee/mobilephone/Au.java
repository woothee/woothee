package is.tagomor.woothee.mobilephone;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Au extends AgentCategory {
  // capture Terminal Name
  public static Pattern auVersion = Pattern.compile("KDDI-([^- /;\\(\\)\"']+)");
  // public to be refered by os.MobilePhone

  public static boolean challenge(final String ua, final Map<String,String> result) {
    int pos = ua.indexOf("KDDI-");
    if (pos < 0) // not au by KDDI
      return false;

    String version = DataSet.VALUE_UNKNOWN;

    Matcher au = auVersion.matcher(ua);
    if (au.find(pos))
      version = au.group(1);
    updateMap(result, DataSet.get("au"));
    updateVersion(result, version);
    return true;
  }
}
