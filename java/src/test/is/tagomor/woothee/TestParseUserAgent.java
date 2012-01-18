package is.tagomor.woothee;

import java.io.File;
import java.io.FileNotFoundException;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import org.junit.BeforeClass;
import org.junit.Test;

import org.ho.yaml.Yaml;

import is.tagomor.woothee.Classifier;

public final class TestParseUserAgent {

  public static String message(final String setName, final String target, final String attribute) {
    return String.format("%s test(%s): %s", setName, attribute, target);
  }

  @SuppressWarnings("unchecked")
  public void executeTestSet(final File testSet, final String setName) throws FileNotFoundException {
    List testsets = (List) Yaml.load(testSet);
    for (Object ts : testsets) {
      Map t = (Map) ts;
      String target = (String) t.get("target");
      Map r = Classifier.parse(target);
      assertEquals(message(setName, target, "name"), t.get("name"), r.get("name"));
      assertEquals(message(setName, target, "category"), t.get("category"), r.get("category"));
      if (t.get("os") != null)
        assertEquals(message(setName, target, "os"), t.get("os"), r.get("os"));
      if (t.get("version") != null)
        assertEquals(message(setName, target, "version"), t.get("version"), r.get("version"));
      if (t.get("vendor") != null)
        assertEquals(message(setName, target, "vendor"), t.get("vendor"), r.get("vendor"));
    }
  }

  @Test
  public void testsetCrawler() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/crawler.yaml"));
    executeTestSet(target, "Crawler");
  }

  @Test
  public void testsetCrawlerGoogle() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/crawler_google.yaml"));
    executeTestSet(target, "Crawler/Google");
  }

  @Test
  public void testsetPCWindows() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/pc_windows.yaml"));
    executeTestSet(target, "PC/Windows");
  }

  @Test
  public void testsetPCMisc() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/pc_misc.yaml"));
    executeTestSet(target, "PC/Misc");
  }

  @Test
  public void testsetMobilePhoneDocomo() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_docomo.yaml"));
    executeTestSet(target, "MobilePhone/docomo");
  }

  @Test
  public void testsetMobilePhoneAU() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_au.yaml"));
    executeTestSet(target, "MobilePhone/au");
  }

  @Test
  public void testsetMobilePhoneSoftbank() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_softbank.yaml"));
    executeTestSet(target, "MobilePhone/softbank");
  }

  @Test
  public void testsetMobilePhoneWillcom() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_willcom.yaml"));
    executeTestSet(target, "MobilePhone/willcom");
  }

  @Test
  public void testsetMobilePhoneMisc() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/mobilephone_misc.yaml"));
    executeTestSet(target, "MobilePhone/misc");
  }

  @Test
  public void testsetSmartPhoneIOS() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/smartphone_ios.yaml"));
    executeTestSet(target, "SmartPhone/ios");
  }

  @Test
  public void testsetSmartPhoneAndroid() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/smartphone_android.yaml"));
    executeTestSet(target, "SmartPhone/android");
  }

  @Test
  public void testsetSmartPhoneMisc() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/smartphone_misc.yaml"));
    executeTestSet(target, "SmartPhone/misc");
  }

  @Test
  public void testsetAppliance() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/appliance.yaml"));
    executeTestSet(target, "Appliance");
  }

  @Test
  public void testsetPCLowPriority() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/pc_lowpriority.yaml"));
    executeTestSet(target, "PC/LowPriority");
  }

  @Test
  public void testsetMisc() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/misc.yaml"));
    executeTestSet(target, "Misc");
  }

  @Test
  public void testsetCrawlerNonMajor() throws FileNotFoundException {
    File target = new File(new File(".").getAbsolutePath().concat("/../testsets/crawler_nonmajor.yaml"));
    executeTestSet(target, "Crawler/NonMajor");
  }
}
