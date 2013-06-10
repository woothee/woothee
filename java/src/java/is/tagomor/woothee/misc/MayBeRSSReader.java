package is.tagomor.woothee.misc;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class MayBeRSSReader extends AgentCategory {
  private static Pattern rssReader = Pattern.compile("rss(reader|bar|[-_ /;\\(\\)]|[ +]*/)", Pattern.CASE_INSENSITIVE);
  private static Pattern headlineReader = Pattern.compile("headline-reader", Pattern.CASE_INSENSITIVE);

  public static boolean challenge(final String ua, final Map<String,String> result) {
    Map<String,String> data = null;

    if (rssReader.matcher(ua).find() || headlineReader.matcher(ua).find()) {
      data = DataSet.get("VariousRSSReader");
    }
    else {
      if (ua.indexOf("cococ/") > -1)
        data = DataSet.get("VariousRSSReader");
    }

    if (data == null)
      return false;

    updateMap(result, data);
    return true;
  }
}
