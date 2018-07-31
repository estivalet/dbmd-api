package org.magus;

/**
 * Javascript specific model (class)
 * 
 * @author lestivalet
 *
 */
public class JSModel extends Model {

	public String getAttributesCommaSeparatedWithDefaultValue() {
		String str = "";
		for (Attribute attr : attributes) {
			if (attr.getDefaultValue() != null) {
				str += attr.getName() + "='" + attr.getDefaultValue() + "',";
			} else {
				str += attr.getName() + ",";
			}
		}
		System.out.println(str);
		return str.substring(0, str.length() - 1);
	}
}
