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
}
