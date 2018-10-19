package org.magus.util;

public class JavaAttributeTypeMapper {

	public static String getJavaType(String attributeType) {
		if ("date".equals(attributeType)) {
			return "Date";
		} else if ("number".equals(attributeType)) {
			return "Integer";
		} else if ("double".equals(attributeType)) {
			return "Double";
		} else if ("text".equals(attributeType)) {
			return "String";
		}

		return "String";
	}

	public static String getJSType(String attributeType) {
		if ("text".equals(attributeType)) {
			return "String";
		}

		return "String";
	}

}
