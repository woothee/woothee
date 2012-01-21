package is.tagomor.woothee.mobilephone;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class MiscPhones extends AgentCategory {
  // capture Terminal Name
  private static Pattern jigTypes = Pattern.compile("jig browser[^;]+; ([^\\);]+)");
  // public to be refered by os.MobilePhone

  public static boolean challenge(final String ua, final Map<String,String> result) {
    if (ua.indexOf("jig browser") > -1) {
      updateMap(result, DataSet.get("jig"));
      Matcher jig = jigTypes.matcher(ua);
      if (jig.find())
        updateVersion(result, jig.group(1));
      return true;
    }
    else if (ua.indexOf("emobile/") > -1 || ua.indexOf("OpenBrowser") > -1 || ua.indexOf("Browser/Obigo-Browser") > -1) {
      updateMap(result, DataSet.get("emobile"));
      return true;
    }
    else if (ua.indexOf("SymbianOS") > -1) {
      updateMap(result, DataSet.get("SymbianOS"));
      return true;
    }
    else if (ua.indexOf("Hatena-Mobile-Gateway/") > -1) {
      Map<String,String> data = DataSet.get("MobileTranscoder");
      updateMap(result, data);
      updateVersion(result, "Hatena");
      return true;
    }
    else if (ua.indexOf("livedoor-Mobile-Gateway/") > -1) {
      Map<String,String> data = DataSet.get("MobileTranscoder");
      updateMap(result, data);
      updateVersion(result, "livedoor");
      return true;
    }

    return false;
  }
}
