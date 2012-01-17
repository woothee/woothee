package is.tagomor.woothee;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import is.tagomor.woothee.DataSet;

public final class Classifier {
  public static final String ATTRIBUTE_KEY_NAME = "name";
  public static final String ATTRIBUTE_KEY_CATEGORY = "category";
  public static final String ATTRIBUTE_KEY_OS = "os";
  public static final String ATTRIBUTE_KEY_VERSION = "version";
  public static final String ATTRIBUTE_KEY_VENDOR = "vendor";

  public static final String VALUE_UNKNOWN = "UNKNOWN";

  public static Map<String,String> parse(final String useragent) {
    HashMap<String,String> result = new HashMap<String,String>(5, (float)1.0); // initial capacity, load factor

    if (tryCrawler(useragent, result)) {
      return fillResult(result);
    }

    return fillResult(result);
  }

  public static boolean tryCrawler(final String useragent, final Map<String,String> result) {
    if (is.tagomor.woothee.crawler.Google.challenge(useragent, result)) {
      return true;
    }
    if (is.tagomor.woothee.crawler.Crawlers.challenge(useragent, result)) {
      return true;
    }
    return false;
  }

  public static Map<String,String> fillResult(final Map<String,String> result) {
    if (result.get(ATTRIBUTE_KEY_NAME) == null)
      result.put(ATTRIBUTE_KEY_NAME, VALUE_UNKNOWN);
    if (result.get(ATTRIBUTE_KEY_CATEGORY) == null)
      result.put(ATTRIBUTE_KEY_CATEGORY, VALUE_UNKNOWN);
    if (result.get(ATTRIBUTE_KEY_OS) == null)
      result.put(ATTRIBUTE_KEY_OS, VALUE_UNKNOWN);
    if (result.get(ATTRIBUTE_KEY_VERSION) == null)
      result.put(ATTRIBUTE_KEY_VERSION, VALUE_UNKNOWN);
    if (result.get(ATTRIBUTE_KEY_VENDOR) == null)
      result.put(ATTRIBUTE_KEY_VENDOR, VALUE_UNKNOWN);
    return result;
  }
}
