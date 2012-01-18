package is.tagomor.woothee.misc;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class SmartPhonePatterns extends AgentCategory {
  public static boolean challenge(final String ua, final Map<String,String> result) {
    Map<String,String> data = null;

    if (ua.indexOf("CFNetwork/") > -1) {
      data = DataSet.get("iOS");
      updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
      updateOs(result, data.get(DataSet.DATASET_KEY_NAME));
      return true;
    }

    return false;
  }
}
