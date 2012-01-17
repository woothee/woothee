package is.tagomor.woothee.os;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;
import is.tagomor.woothee.Classifier;

public class OSX extends AgentCategory {
  public static boolean challenge(final String ua, final Map<String,String> result) {
    int pos = ua.indexOf("Mac OS X");
    if (pos < 0) // not OSX
      return false;

    Map<String,String> data = DataSet.get("OSX");

    if (ua.indexOf("like Mac OS X") > -1) {
      if (ua.indexOf("iPhone;") > -1)
        data = DataSet.get("iPhone");
      else if (ua.indexOf("iPad;") > -1)
        data = DataSet.get("iPad");
      else if (ua.indexOf("iPod;") > -1)
        data = DataSet.get("iPod");
    }

    updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
    updateOs(result, data.get(DataSet.DATASET_KEY_NAME));
    return true;
  }
}
