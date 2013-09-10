package is.tagomor.woothee.os;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class SmartPhone extends AgentCategory {
  public static Pattern firefoxOsPattern = Pattern.compile("^Mozilla/[.0-9]+ \\(Mobile;(.*;)? rv:[.0-9]+\\) Gecko/[.0-9]+ Firefox/[.0-9]+$");

  public static boolean challenge(final String ua, final Map<String,String> result) {
    
    Map<String,String> data = null;

    if (ua.indexOf("iPhone") > -1)
      data = DataSet.get("iPhone");
    else if (ua.indexOf("iPad") > -1)
      data = DataSet.get("iPad");
    else if (ua.indexOf("iPod") > -1)
      data = DataSet.get("iPod");
    else if (ua.indexOf("Android") > -1)
      data = DataSet.get("Android");
    else if (ua.indexOf("CFNetwork") > -1)
      data = DataSet.get("iOS");
    else if (ua.indexOf("BlackBerry") > -1)
      data = DataSet.get("BlackBerry");

    if (result.containsKey(DataSet.DATASET_KEY_NAME) && result.get(DataSet.DATASET_KEY_NAME) == DataSet.get("Firefox").get(DataSet.DATASET_KEY_NAME)) {
      // Firefox OS specific pattern
      // http://lawrencemandel.com/2012/07/27/decision-made-firefox-os-user-agent-string/
      Matcher firefoxOs = firefoxOsPattern.matcher(ua);
      if (firefoxOs.find()) {
        data = DataSet.get("FirefoxOS");
      }
    }

    if (data == null)
      return false;

    updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
    updateOs(result, data.get(DataSet.DATASET_KEY_NAME));
    return true;
  }
}
