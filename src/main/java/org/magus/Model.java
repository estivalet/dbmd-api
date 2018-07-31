package org.magus;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Model {
	private String name;
	private Boolean imutable = false;
	private Boolean controller = false;
	protected List<Attribute> attributes = new ArrayList<Attribute>();

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

	public List<Attribute> getBaseAttributes() {
		List<Attribute> attrs = new ArrayList<Attribute>();
		for (Attribute a : this.attributes) {
			if (!"formula".equals(a.getType())) {
				attrs.add(a);
			}
		}
		return attrs;
	}

	public String getAttributesCommaSeparated() {
		return attributes.stream().map(c -> String.valueOf(c)).collect(Collectors.joining(","));
	}

	public String getAttributesCommaSeparatedWithDefaultValue() {
		return "NEED TO BE IMPLEMENTED";
	}

	public void setAttributes(List<Attribute> attributes) {
		this.attributes = attributes;
	}

	public Boolean getImutable() {
		return imutable;
	}

	public void setImutable(Boolean imutable) {
		this.imutable = imutable;
	}

	public Boolean getController() {
		return controller;
	}

	public void setController(Boolean controller) {
		this.controller = controller;
	}

}
