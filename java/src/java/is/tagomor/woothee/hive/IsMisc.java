package is.tagomor.woothee.hive;

import java.util.Map;

import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;

import is.tagomor.woothee.DataSet;

public final class IsMisc extends UDF {
  public String evaluate(final Map<String,String> m) {
    return m.get(DataSet.ATTRIBUTE_CATEGORY).equals(DataSet.DATASET_CATEGORY_MISC) ? 'TRUE' : null;
  }
}
