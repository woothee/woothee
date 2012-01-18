package is.tagomor.woothee.os;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class MobilePhone extends AgentCategory {
  // capture Terminal Name
  private static Pattern auVersion = is.tagomor.woothee.mobilephone.Au.auVersion;
  private static Pattern willcomVersion = is.tagomor.woothee.mobilephone.Willcom.willcomVersion;

  public static boolean challenge(final String ua, final Map<String,String> result) {
    // various mobile phones

    if (ua.indexOf("KDDI-") > -1) {
      Matcher au = auVersion.matcher(ua);
      if (au.find()) {
        String term = au.group(1);
        Map<String,String> data = DataSet.get("au");
        updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
        updateOs(result, data.get(DataSet.DATASET_KEY_OS));
        updateVersion(result, term);
        return true;
      }
    }
    if (ua.indexOf("WILLCOM") > -1 || ua.indexOf("DDIPOCKET") > -1) {
      Matcher willcom = willcomVersion.matcher(ua);
      if (willcom.find()) {
        String term = willcom.group(1);
        Map<String,String> data = DataSet.get("willcom");
        updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
        updateOs(result, data.get(DataSet.DATASET_KEY_OS));
        updateVersion(result, term);
        return true;
      }
    }
    if (ua.indexOf("SymbianOS") > -1) {
      Map<String,String> data = DataSet.get("SymbianOS");
      updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
      updateOs(result, data.get(DataSet.DATASET_KEY_OS));
      return true;
    }
    if (ua.indexOf("Google Wireless Transcoder") > -1) {
      Map<String,String> data = DataSet.get("MobileTranscoder");
      updateMap(result, data);
      updateVersion(result, "Google");
      return true;
    }
    if (ua.indexOf("Naver Transcoder") > -1) {
      Map<String,String> data = DataSet.get("MobileTranscoder");
      updateMap(result, data);
      updateVersion(result, "Naver");
      return true;
    }

    return false;
  }
}
