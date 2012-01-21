package is.tagomor.woothee;

import java.io.File;
import java.io.FileNotFoundException;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import org.junit.BeforeClass;
import org.junit.Test;

import org.ho.yaml.Yaml;

import is.tagomor.woothee.Classifier;

public final class TestIsCrawler {

  public static String message(final String setName, final String target, final String attribute) {
    return String.format("%s test(%s): %s", setName, attribute, target);
  }

  @SuppressWarnings("unchecked")
  public void executeCheckIsCrawler(final File testSet, final String setName, final boolean should_true) throws FileNotFoundException {
    List testsets = (List) Yaml.load(testSet);
    for (Object ts : testsets) {
      Map t = (Map) ts;
      String target = (String) t.get("target");
      if (should_true && t.get("category").equals("crawler"))
        assertTrue(message(setName, target, "isCrawler"), Classifier.isCrawler(target));
      else
        assertFalse(message(setName, target, "isCrawler"), Classifier.isCrawler(target));
    }
  }

  @Test
  public void testsetCrawler() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/crawler.yaml"));
    executeCheckIsCrawler(target, "Crawler", true);
  }

  @Test
  public void testsetCrawlerGoogle() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/crawler_google.yaml"));
    executeCheckIsCrawler(target, "Crawler/Google", true);
  }

  @Test
  public void testsetPCWindows() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/pc_windows.yaml"));
    executeCheckIsCrawler(target, "PC/Windows", false);
  }

  @Test
  public void testsetPCMisc() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/pc_misc.yaml"));
    executeCheckIsCrawler(target, "PC/Misc", false);
  }

  @Test
  public void testsetMobilePhoneDocomo() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_docomo.yaml"));
    executeCheckIsCrawler(target, "MobilePhone/docomo", false);
  }

  @Test
  public void testsetMobilePhoneAU() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_au.yaml"));
    executeCheckIsCrawler(target, "MobilePhone/au", false);
  }

  @Test
  public void testsetMobilePhoneSoftbank() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_softbank.yaml"));
    executeCheckIsCrawler(target, "MobilePhone/softbank", false);
  }

  @Test
  public void testsetMobilePhoneWillcom() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_willcom.yaml"));
    executeCheckIsCrawler(target, "MobilePhone/willcom", false);
  }

  @Test
  public void testsetMobilePhoneMisc() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_misc.yaml"));
    executeCheckIsCrawler(target, "MobilePhone/misc", false);
  }

  @Test
  public void testsetSmartPhoneIOS() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/smartphone_ios.yaml"));
    executeCheckIsCrawler(target, "SmartPhone/ios", false);
  }

  @Test
  public void testsetSmartPhoneAndroid() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/smartphone_android.yaml"));
    executeCheckIsCrawler(target, "SmartPhone/android", false);
  }

  @Test
  public void testsetSmartPhoneMisc() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/smartphone_misc.yaml"));
    executeCheckIsCrawler(target, "SmartPhone/misc", false);
  }

  @Test
  public void testsetAppliance() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/appliance.yaml"));
    executeCheckIsCrawler(target, "Appliance", false);
  }

  @Test
  public void testsetPCLowPriority() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/pc_lowpriority.yaml"));
    executeCheckIsCrawler(target, "PC/LowPriority", false);
  }

  @Test
  public void testsetMisc() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/misc.yaml"));
    executeCheckIsCrawler(target, "Misc", false);
  }

  @Test
  public void testsetCrawlerNonMajor() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/crawler_nonmajor.yaml"));
    executeCheckIsCrawler(target, "Crawler/NonMajor", false);
  }
}
