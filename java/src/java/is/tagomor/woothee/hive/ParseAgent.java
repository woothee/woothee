package is.tagomor.woothee.hive;

import java.util.Map;

import org.apache.hadoop.hive.ql.exec.Description;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;

import is.tagomor.woothee.Classifier;

@Description(name="pase_agent",
             value="_FUNC_ returns Map, which has keys such as 'category', 'name', 'os', 'version', 'vendor'.",
             extended="_FUNC_(user_agent_string)")
public final class ParseAgent extends UDF {
  public Map<String,String> evaluate(final Text s) {
    if (s != null)
      return Classifier.parse(s.toString());
    else
      return Classifier.parse(null);
  }
}
