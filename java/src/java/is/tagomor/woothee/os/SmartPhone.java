package is.tagomor.woothee.os;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class SmartPhone extends AgentCategory {
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

    if (data == null)
      return false;

    updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
    updateOs(result, data.get(DataSet.DATASET_KEY_NAME));
    return true;
  }
}
