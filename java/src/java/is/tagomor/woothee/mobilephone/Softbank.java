package is.tagomor.woothee.mobilephone;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Softbank extends AgentCategory {
  // capture Terminal Name
  public static Pattern softbankVersion = Pattern.compile("(?:SoftBank|Vodafone|J-PHONE)/[.0-9]+/([^ /;\\(\\)]+)");
  // public to be refered by os.MobilePhone

  public static boolean challenge(final String ua, final Map<String,String> result) {
    int pos = ua.indexOf("SoftBank");
    if (pos < 0)
      pos = ua.indexOf("Vodafone");
    if (pos < 0)
      pos = ua.indexOf("J-PHONE");
    if (pos < 0)
      return false;

    String version = DataSet.VALUE_UNKNOWN;

    Matcher softbank = softbankVersion.matcher(ua);
    if (softbank.find(pos))
      version = softbank.group(1);
    updateMap(result, DataSet.get("SoftBank"));
    updateVersion(result, version);
    return true;
  }
}
