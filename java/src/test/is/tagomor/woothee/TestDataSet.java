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

// import is.tagomor.woothee.Classifier;
import is.tagomor.woothee.DataSet;

public final class TestDataSet {

  @Test
    public void testDataSet() {
    assertEquals("CATEGORY LIST SIZE", 7, DataSet.CATEGORY_LIST.length); // pc,smartphone,mobilephone,crawler,appliance,misc,unknown
    assertEquals("ATTRIBUTE LIST SIZE", 5, DataSet.ATTRIBUTE_LIST.length); // name category os vendor version
  }
}
