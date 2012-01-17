package is.tagomor.woothee.hive;

import java.util.Map;

import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;

import is.tagomor.woothee.Classifier;

public final class ParseAgent extends UDF {
  public Map<String,String> evaluate(final Text s) {
    return Classifier.parse(s.toString());
  }
}
