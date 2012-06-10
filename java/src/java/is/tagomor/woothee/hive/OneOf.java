package is.tagomor.woothee.hive;

import java.util.Map;
import java.util.List;

import org.apache.hadoop.hive.ql.exec.Description;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;

import is.tagomor.woothee.DataSet;

@Description(name="one_of",
             value="_FUNC_ return TRUE when specified map's ['category'] is equals to one of LIST, else NULL",
             extended="count( _FUNC_(parse_agent(user_agent_string), array('pc', 'mobilephone', 'smartphone', 'appliance')) )")
public final class OneOf extends UDF {
  public Boolean evaluate(final Map<String,String> m, final List<String> categories) {
    String targetCategory = m.get(DataSet.ATTRIBUTE_CATEGORY);
    for (String c : categories) {
      if (targetCategory.equals(c))
        return Boolean.TRUE;
    }
    return null;
  }
}
