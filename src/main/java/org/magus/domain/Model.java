package org.magus.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.zeeltech.util.StringUtils;

/**
 * Represents a model/entity of an application.
 * 
 * @author lestivalet
 */
@SuppressWarnings("serial")
public class Model implements Serializable {

	/** Model name. */
	private String name;

	/** Model plural name. */
	private String pluralName;

	/** List of attributes of this model. */
	protected List<Attribute> attributes = new ArrayList<Attribute>();

	/** List of models of this model. */
	protected List<Model> models = new ArrayList<Model>();

	/** Indicates if the model is imutable or not. */
	private Boolean imutable = false;

	/** Indicates if the model is a controller or not. */
	private Boolean controller = false;

	/** Indicates if the model will have a list of models. */
	private Boolean hasList = false;

	/** Single attribute to order by the list. */
	private Attribute orderBy;

	/**
	 * Indicates if this is the main module to be shown for example after a login
	 * page. There must be only one main module in case of multiple modules.
	 */
	private Boolean main = false;

	/**
	 * Display attribute in case of "foreign keys" to be displayed in a combo for
	 * e.g.
	 */
	private Attribute display;

	public String getName() {
		return name;
	}

	public String getCamelCaseName() {
		return StringUtils.toCamelCase(name);
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

	public void addModel(Model model) {
		this.models.add(model);
	}

	public List<Model> getModels() {
		return models;
	}

	public String getAttributesCommaSeparated() {
		return attributes.stream().map(c -> String.valueOf(c)).collect(Collectors.joining(","));
	}

	public String getAttributesReplacedBy(String character) {
		String str = "";
		for (Attribute attr : attributes) {
			str += character + ",";
		}
		return str.substring(0, str.length() - 1);
	}

	public String getAttributesEquals(String character) {
		String str = "";
		for (Attribute attr : attributes) {
			str += attr.getName() + " = " + character + ",";
		}
		return str.substring(0, str.length() - 1);
	}

	public String getAttributesPrecededByModelName() {
		String str = "";
		for (Attribute attr : attributes) {
			str += StringUtils.toCamelCase(this.name) + "." + attr.getName() + ",";
		}
		return str.substring(0, str.length() - 1);
	}

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

	public List<Attribute> getBaseAttributes() {
		List<Attribute> attrs = new ArrayList<Attribute>();
		for (Attribute a : this.attributes) {
			if (!"formula".equals(a.getType())) {
				attrs.add(a);
			}
		}
		return attrs;
	}

	public List<Attribute> getReferencedAttributes() {
		List<Attribute> attrs = new ArrayList<Attribute>();
		for (Model m : this.models) {
			for (Attribute a : m.attributes) {
				if (a.getReferenced()) {
					attrs.add(a);
				}
			}
		}
		return attrs;
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

	// public Attribute getOrderBy() {
	// return orderBy;
	// }
	//
	// public void setOrderBy(Attribute orderBy) {
	// this.orderBy = orderBy;
	// }

	public Attribute getDisplay() {
		return display;
	}

	public void setDisplay(Attribute display) {
		this.display = display;
	}

	/**
	 * @return the main
	 */
	public Boolean getMain() {
		return main;
	}

	/**
	 * @param main
	 *            the main to set
	 */
	public void setMain(Boolean main) {
		this.main = main;
	}

}
