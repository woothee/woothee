package is.tagomor.woothee.hive;

import java.util.Map;

import org.apache.hadoop.hive.ql.exec.Description;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;

import is.tagomor.woothee.DataSet;

@Description(name="pc",
             value="_FUNC_ return TRUE when specified map['category'] is a pc agent, else NULL",
             extended="count( _FUNC_(parse_agent(user_agent_string)) )")
public final class PC extends UDF {
  public Boolean evaluate(final Map<String,String> m) {
    return m.get(DataSet.ATTRIBUTE_CATEGORY).equals(DataSet.DATASET_CATEGORY_PC) ? Boolean.TRUE : null;
  }
}
