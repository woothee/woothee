package is.tagomor.woothee;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import is.tagomor.woothee.DataSet;

public final class Classifier {
  public static Map<String,String> parse(final String useragent) {
    return fillResult(execParse(useragent));
  }

  public static boolean isCrawler(final String useragent) {
    if (useragent == null || useragent.length() < 1 || useragent.equals("-"))
      return false;

    if (tryCrawler(useragent, new HashMap<String,String>(6, (float)1.0)))
      return true;

    return false;
  }

  public static Map<String,String> execParse(final String useragent) {
    HashMap<String,String> result = new HashMap<String,String>(6, (float)1.0); // initial capacity, load factor

    if (useragent == null || useragent.length() < 1 || useragent.equals("-"))
      return result;

    if (tryCrawler(useragent, result)) {
      return result;
    }

    if (tryBrowser(useragent, result)) {
      if (tryOS(useragent, result))
        return result;
      else
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
      return result;

    if (tryRareCases(useragent, result))
      return result;

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

    // mobile phones like KDDI-* ...
    if (is.tagomor.woothee.os.MobilePhone.challenge(useragent, result))
      return true;

    // Nintendo DSi/Wii with Opera
    if (is.tagomor.woothee.os.Appliance.challenge(useragent, result))
      return true;

    // Win98,BSD
    if (is.tagomor.woothee.os.MiscOS.challenge(useragent, result))
      return true;

    return false;
  }

  public static boolean tryMobilePhone(final String useragent, final Map<String,String> result) {
    if (is.tagomor.woothee.mobilephone.Docomo.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.mobilephone.Au.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.mobilephone.Softbank.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.mobilephone.Willcom.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.mobilephone.MiscPhones.challenge(useragent, result))
      return true;
    return false;
  }

  public static boolean tryAppliance(final String useragent, final Map<String,String> result) {
    if (is.tagomor.woothee.appliance.Playstation.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.appliance.Nintendo.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.appliance.DigitalTV.challenge(useragent, result))
      return true;
    
    return false;
  }

  public static boolean tryMisc(final String useragent, final Map<String,String> result) {
    if (is.tagomor.woothee.misc.DesktopTools.challenge(useragent, result))
      return true;

    return false;
  }

  public static boolean tryRareCases(final String useragent, final Map<String,String> result) {
    if (is.tagomor.woothee.misc.SmartPhonePatterns.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.browser.Sleipnir.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.misc.HTTPLibrary.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.misc.MayBeRSSReader.challenge(useragent, result))
      return true;
    if (is.tagomor.woothee.crawler.MayBeCrawler.challenge(useragent, result))
      return true;

    return false;
  }

  public static Map<String,String> fillResult(final Map<String,String> result) {
    if (result.get(DataSet.ATTRIBUTE_NAME) == null)
      result.put(DataSet.ATTRIBUTE_NAME, DataSet.VALUE_UNKNOWN);
    if (result.get(DataSet.ATTRIBUTE_CATEGORY) == null)
      result.put(DataSet.ATTRIBUTE_CATEGORY, DataSet.VALUE_UNKNOWN);
    if (result.get(DataSet.ATTRIBUTE_OS) == null)
      result.put(DataSet.ATTRIBUTE_OS, DataSet.VALUE_UNKNOWN);
    if (result.get(DataSet.ATTRIBUTE_VERSION) == null)
      result.put(DataSet.ATTRIBUTE_VERSION, DataSet.VALUE_UNKNOWN);
    if (result.get(DataSet.ATTRIBUTE_VENDOR) == null)
      result.put(DataSet.ATTRIBUTE_VENDOR, DataSet.VALUE_UNKNOWN);
    return result;
  }
}
