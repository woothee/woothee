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
    return fillResult(execParse(useragent));
  }

  public static Map<String,String> execParse(final String useragent) {
    HashMap<String,String> result = new HashMap<String,String>(6, (float)1.0); // initial capacity, load factor

    if (tryCrawler(useragent, result)) {
      return result;
    }

    if (tryBrowser(useragent, result)) {
      if (tryOS(useragent, result))
        return result;
      return fillResult(result);
    }

    if (trySmartPhone(useragent, result)) {
      return result;
    }

    if (tryMobilePhone(useragent, result)) {
      return result;
    }

    if (tryAppliance(useragent, result)) {
      return result;
    }

    if (tryMisc(useragent, result)) {
      return result;
    }

    // browser unknown. check os only
    if (tryOS(useragent, result))
      return fillResult(result);

    return result;
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

  public static boolean tryBrowser(final String useragent, final Map<String,String> result) {
    if (is.tagomor.woothee.browser.MSIE.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.browser.SafariChrome.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.browser.Firefox.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.browser.Opera.challenge(useragent, result))
      return true;

    return false;
  }

  public static boolean tryOS(final String useragent, final Map<String,String> result) {
    // Windows PC, and Windows Phone OS
    if (is.tagomor.woothee.os.Windows.challenge(useragent, result))
      return true;

    // Mac OS X PC, and iOS devices(strict check)
    if (is.tagomor.woothee.os.OSX.challenge(useragent, result))
      return true;

    // Linux PC, and Android
    if (is.tagomor.woothee.os.Linux.challenge(useragent, result))
      return true;

    // all useragents matches /(iPhone|iPad|iPod|Andorid|BlackBerry)/
    if (is.tagomor.woothee.os.SmartPhone.challenge(useragent, result))
      return true;

    return false;
  }

  public static boolean trySmartPhone(final String useragent, final Map<String,String> result) {
    return false;
  }

  public static boolean tryMobilePhone(final String useragent, final Map<String,String> result) {
    return false;
  }

  public static boolean tryAppliance(final String useragent, final Map<String,String> result) {
    return false;
  }

  public static boolean tryMisc(final String useragent, final Map<String,String> result) {
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
