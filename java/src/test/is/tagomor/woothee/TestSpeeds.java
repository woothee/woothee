package is.tagomor.woothee;

import java.util.Date;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import org.junit.BeforeClass;
import org.junit.Test;

import org.ho.yaml.Yaml;

import is.tagomor.woothee.Classifier;

public final class TestSpeeds {

  private static String ua1 = "Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)";
  private static String ua2 = "Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)";
  private static String ua3 = "DoCoMo/2.0 P900i(c100;TB;W24H11) (compatible; ichiro/mobile goo; +http://help.goo.ne.jp/help/article/1142/)";
  private static String ua4 = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; 2004/11/08; GoogleT5; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)";
  private static String ua5 = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.52.7 (KHTML, like Gecko) Version/5.1.2 Safari/534.52.7";
  private static String ua6 = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1) Sleipnir/2.8.0";

  private static Pattern p = Pattern.compile("Yahoo! Slurp;|YahooFeedSeeker(Beta)?Jp|Yahoo Pipes|msnbot|compatible; bingbot|Yeti|Indy Library|Apple-PubSub|Hatena (Antenna|Pagetitle|Diary RSS)|Baiduspider|ichiro|livedoor FeedFetcher|facebookexternalhit");

  private static boolean searchRegexp(final String ua) {
    return p.matcher(ua).find();
  }

  private static boolean searchIndexOf(final String ua) {
    if (ua.indexOf("Yahoo") > -1) { return true; }
    else if (ua.indexOf("msnbot") > -1) { return true; }
    else if (ua.indexOf("bingbot") > -1) { return true; }
    else if (ua.indexOf("Baidu") > -1) { return true; }
    else if (ua.indexOf("Yeti") > -1) { return true; }
    else if (ua.indexOf("facebookexternalhit") > -1) { return true; }
    else if (ua.indexOf("Apple-PubSub") > -1) { return true; }
    else if (ua.indexOf("livedoor FeedFetcher") > -1) { return true; }
    else if (ua.indexOf("Hatena ") > -1) { return true; }
    else if (ua.indexOf("Indy Library") > -1) { return true; }
    else { return false; }
  }

  @Test
  public void regexp() {
    assertEquals(1, 1);
    return;
    // regexp pattern: 14080
    // Date start = new Date();
    // for (int i = 0 ; i < 100000 ; i++) {
    //   searchRegexp(ua1); searchRegexp(ua2); searchRegexp(ua3); searchRegexp(ua4); searchRegexp(ua5); searchRegexp(ua6);
    // }
    // System.out.println(String.format("regexp pattern: %d", ((new Date()).getTime() - start.getTime())));
    // assertEquals(1, 1);
  }

  @Test
  public void indexof() {
    assertEquals(1, 1);
    return;
    // indexof pattern: 1060
    // Date start = new Date();
    // for (int i = 0 ; i < 100000 ; i++) {
    //   searchIndexOf(ua1); searchIndexOf(ua2); searchIndexOf(ua3); searchIndexOf(ua4); searchIndexOf(ua5); searchIndexOf(ua6);
    // }
    // System.out.println(String.format("indexof pattern: %d", ((new Date()).getTime() - start.getTime())));
    // assertEquals(1, 1);
  }
}
