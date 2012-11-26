package is.tagomor.woothee.appliance;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class Nintendo extends AgentCategory {
  public static boolean challenge(final String ua, final Map<String,String> result) {
    Map<String,String> data = null;

    // for Opera of DSi/Wii, see os.Appliance
    if (ua.indexOf("Nintendo 3DS;") > -1) {
      data = DataSet.get("Nintendo3DS");
    }
    else if (ua.indexOf("Nintendo DSi;") > -1) {
      data = DataSet.get("NintendoDSi");
    }
    else if (ua.indexOf("Nintendo Wii;") > -1) {
      data = DataSet.get("NintendoWii");
    }
    else if (ua.indexOf("(Nintendo WiiU)") > -1) {
      data = DataSet.get("NintendoWiiU");
    }

    if (data == null)
      return false;

    updateMap(result, data);
    return true;
  }
}
