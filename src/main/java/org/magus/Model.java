package org.magus;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Model {
	private String name;
	private List<Attribute> attributes = new ArrayList<Attribute>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void addAttribute(Attribute attribute) {
		this.attributes.add(attribute);
	}

	public List<Attribute> getAttributes() {
		return attributes;
	}

	public String getAttributesCommaSeparated() {
		return attributes.stream().map(c -> String.valueOf(c)).collect(Collectors.joining(","));
	}

	public void setAttributes(List<Attribute> attributes) {
		this.attributes = attributes;
	}

}
