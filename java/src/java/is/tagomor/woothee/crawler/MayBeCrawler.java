package is.tagomor.woothee.crawler;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class MayBeCrawler extends AgentCategory {
  private static Pattern maybeBotPattern = Pattern.compile("(bot|crawler|spider)(?:[-_ ./;@\\(\\)]|$)", Pattern.CASE_INSENSITIVE);
  private static Pattern maybeParserPattern = Pattern.compile("(feed|web) ?parser", Pattern.CASE_INSENSITIVE);
  private static Pattern maybeWatchdogPattern = Pattern.compile("watch ?dog", Pattern.CASE_INSENSITIVE);

  public static boolean challenge(final String ua, final Map<String,String> result) {
    Matcher maybebot = maybeBotPattern.matcher(ua);
    if (maybebot.find()) {
      updateMap(result, DataSet.get("VariousCrawler"));
      return true;
    }

    if (ua.startsWith("Rome Client ") ||
        ua.startsWith("UnwindFetchor/") ||
        ua.startsWith("ia_archiver ") ||
        ua.startsWith("Summify ") ||
        ua.startsWith("PostRank/") ||
        ua.indexOf("ASP-Ranker Feed Crawler") > -1) {
      updateMap(result, DataSet.get("VariousCrawler"));
      return true;
    }
        
    Matcher parser = maybeParserPattern.matcher(ua);
    if (parser.find()) {
      updateMap(result, DataSet.get("VariousCrawler"));
      return true;
    }

    Matcher watchdog = maybeWatchdogPattern.matcher(ua);
    if (watchdog.find()) {
      updateMap(result, DataSet.get("VariousCrawler"));
      return true;
    }

    return false;
  }
}
