package is.tagomor.woothee.os;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;
import is.tagomor.woothee.Classifier;

public class MiscOS extends AgentCategory {
  public static boolean challenge(final String ua, final Map<String,String> result) {
    Map<String,String> data = null;

    if (ua.indexOf("(Win98;") > -1) {
      data = DataSet.get("Win98");
    }
    else if (ua.indexOf("Macintosh; U; PPC;") > -1 || ua.indexOf("Mac_PowerPC") > -1) {
      data = DataSet.get("MacOS");
    }
    else if (ua.indexOf("X11; FreeBSD ") > -1) {
      data = DataSet.get("BSD");
    }

    if (data != null) {
      updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
      updateOs(result, data.get(DataSet.DATASET_KEY_NAME));
      return true;
    }

    return false;
  }
}
