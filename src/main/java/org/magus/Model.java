package org.magus;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Represents a model/entity of an application.
 * 
 * @author lestivalet
 */
public class Model {
	/** Model name. */
	private String name;

	/** Model plural name. */
	private String pluralName;

	/** List of attributes of this model. */
	protected List<Attribute> attributes = new ArrayList<Attribute>();

	/** Indicates if the model is imutable or not. */
	private Boolean imutable = false;

	/** Indicates if the model is a controller or not. */
	private Boolean controller = false;

	/** Indicates if the model will have a list of models. */
	private Boolean hasList = false;

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

	public String getPluralName() {
		return pluralName;
	}

	public void setPluralName(String pluralName) {
		this.pluralName = pluralName;
	}

	public Boolean getHasList() {
		return hasList;
	}

	public void setHasList(Boolean hasList) {
		this.hasList = hasList;
	}

}
