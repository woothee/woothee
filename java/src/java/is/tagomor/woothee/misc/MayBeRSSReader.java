package is.tagomor.woothee.misc;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class MayBeRSSReader extends AgentCategory {
  private static Pattern rssReader = Pattern.compile("rss(reader|bar|[-_ /;\\(\\)])", Pattern.CASE_INSENSITIVE);

  public static boolean challenge(final String ua, final Map<String,String> result) {
    Map<String,String> data = null;

    Matcher rssreaders = rssReader.matcher(ua);
    if (rssreaders.find())
      data = DataSet.get("VariousRSSReader");

    if (data == null)
      return false;

    updateMap(result, data);
    return true;
  }
}
