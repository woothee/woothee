package is.tagomor.woothee.appliance;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Playstation extends AgentCategory {
  public static boolean challenge(final String ua, final Map<String,String> result) {
    Map<String,String> data = null;

    if (ua.indexOf("PSP (PlayStation Portable);") > -1) {
      data = DataSet.get("PSP");
    }
    else if (ua.indexOf("PlayStation Vita") > -1) {
      data = DataSet.get("PSVita");
    }
    else if (ua.indexOf("PLAYSTATION 3 ") > -1 || ua.indexOf("PLAYSTATION 3;") > -1) {
      data = DataSet.get("PS3");
    }

    if (data == null)
      return false;

    updateMap(result, data);
    return true;
  }
}
