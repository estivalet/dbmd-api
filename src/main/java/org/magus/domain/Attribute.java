package org.magus.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Attribute implements Serializable {
	private String name;
	private String label;
	private String type;
	private String value;
	private String defaultValue;
	private String formula;
	private String tooltip;
	private String description = "";
	private Integer maxLength;
	private Boolean required = false;
	private Boolean orderBy = false;
	private Integer orderByNum = 0;
	/** Bidirectional reference. */
	// private Model model;
	private String model;

	/** If the attribute is referenced by other model. */
	private Boolean referenced;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFormula() {
		return formula;
	}

	public void setFormula(String formula) {
		this.formula = formula;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return name;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	public String getLabel() {
		if (this.label == null) {
			return this.name;
		}
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public Boolean getRequired() {
		return required;
	}

	public void setRequired(Boolean required) {
		this.required = required;
	}

	public String getTooltip() {
		return tooltip;
	}

	public void setTooltip(String tooltip) {
		this.tooltip = tooltip;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getReferenced() {
		return referenced;
	}

	public void setReferenced(Boolean referenced) {
		this.referenced = referenced;
	}

	// public Model getModel() {
	// return model;
	// }
	//
	// public void setModel(Model model) {
	// this.model = model;
	// }

	public Integer getMaxLength() {
		return maxLength;
	}

	public void setMaxLength(Integer maxLength) {
		this.maxLength = maxLength;
	}

	public Boolean getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(Boolean orderBy) {
		this.orderBy = orderBy;
	}

	public Integer getOrderByNum() {
		return orderByNum;
	}

	public void setOrderByNum(Integer orderByNum) {
		this.orderByNum = orderByNum;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

}
