package is.tagomor.woothee;

import java.util.Map;

import is.tagomor.woothee.DataSet;

public class AgentCategory {
  protected static void updateMap(final Map<String,String> target, final Map<String,String> source) {
    for(String key : source.keySet()) {
      if (key.equals(DataSet.DATASET_KEY_LABEL) || key.equals(DataSet.DATASET_KEY_TYPE))
        continue;
      String val = source.get(key);
      if (val.length() > 0)
        target.put(key, val);
    }
  }
  protected static void updateCategory(final Map<String,String> target, final String category) {
    target.put(DataSet.ATTRIBUTE_CATEGORY, category);
  }
  protected static void updateVersion(final Map<String,String> target, final String version) {
    target.put(DataSet.ATTRIBUTE_VERSION, version);
  }
  protected static void updateOs(final Map<String,String> target, final String os) {
    target.put(DataSet.ATTRIBUTE_OS, os);
  }
}