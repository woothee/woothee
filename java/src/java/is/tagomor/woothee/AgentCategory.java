package is.tagomor.woothee;

import java.util.Map;

public class AgentCategory {
  protected static void updateMap(final Map<String,String> target, final Map<String,String> source) {
    for(String key : source.keySet()) {
      target.put(key, source.get(key));
    }
  }
}