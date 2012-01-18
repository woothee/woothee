package is.tagomor.woothee.misc;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;

public class HTTPLibrary extends AgentCategory {
  public static boolean challenge(final String ua, final Map<String,String> result) {
    Map<String,String> data = null;
    String version = null;

    if (ua.startsWith("Apache-HttpClient/") ||
        ua.startsWith("Jakarta Commons-HttpClient/") ||
        ua.startsWith("Java/")) {
      data = DataSet.get("HTTPLibrary");
      version = "Java";
    }
    else if (ua.startsWith("Wget/")) {
      data = DataSet.get("HTTPLibrary");
      version = "wget";
    }
    else if (ua.startsWith("libwww-perl") ||
             ua.startsWith("WWW-Mechanize") ||
             ua.startsWith("LWP::Simple") ||
             ua.startsWith("LWP ") ||
             ua.startsWith("lwp-trivial")) {
      data = DataSet.get("HTTPLibrary");
      version = "perl";
    }
    else if (ua.startsWith("Python-urllib/")) {
      data = DataSet.get("HTTPLibrary");
      version = "python";
    }
    else if (ua.startsWith("PHP/") ||
             ua.startsWith("WordPress/") ||
             ua.startsWith("CakePHP") ||
             ua.startsWith("PukiWiki/") ||
             ua.indexOf("PEAR HTTP_Request class;") > -1) {
      data = DataSet.get("HTTPLibrary");
      version = "php";
    }

    if (data == null)
      return false;

    updateMap(result, data);
    if (version != null)
      updateVersion(result, version);
    return true;
  }
}
