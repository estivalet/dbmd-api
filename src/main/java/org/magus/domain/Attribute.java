package org.magus.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("serial")
public class Attribute implements Serializable {

	/** Name of the attribute. */
	private String name;

	/** Label to be displayed for the attribute. */
	private String label;

	/** Type of the attribute to render for input (text, select, ...) */
	private String type;

	/** Value set for the attribute. */
	private String value;

	/** Default value for the attribute. */
	private String defaultValue;

	/** Formula used to calculate the value of the attribute. */
	private String formula;

	/** Tool tip to be displayed for the attribute. */
	private String tooltip;

	/** Description to be displayed for the attribute. */
	private String description = "";

	/** Max length of the attribute. */
	private Integer maxLength;

	/** Indicates if the attribute is required or not. */
	private Boolean required = false;

	/** If the attribute is visible in a table for example. */
	private Boolean visible = true;

	/** Indicates if the attribute can be editable or it is read-only. */
	private Boolean readOnly = true;

	/** Indicates if this attribute is used to order the list of attributes. */
	private Boolean orderBy = false;

	/** Indicates the order number if attribute is ordered. */
	private Integer orderByNum = 0;

	/** Bidirectional reference. */
	// private Model model;
	private String model;

	/** If the attribute is referenced by other model. */
	private Boolean referenced;

	/** If a referenced attribute is visible. */
	private Boolean referencedVisible = true;

	/** List of possible values used for checkbox, radio and select. */
	private List<AttributeOption> options = new ArrayList<AttributeOption>();

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

	public Boolean getVisible() {
		return visible;
	}

	public void setVisible(Boolean visible) {
		this.visible = visible;
	}

	public Boolean getReadOnly() {
		return readOnly;
	}

	public void setReadOnly(Boolean readOnly) {
		this.readOnly = readOnly;
	}

	/**
	 * @return the referencedVisible
	 */
	public Boolean getReferencedVisible() {
		return referencedVisible;
	}

	/**
	 * @param referencedVisible
	 *            the referencedVisible to set
	 */
	public void setReferencedVisible(Boolean referencedVisible) {
		this.referencedVisible = referencedVisible;
	}

	/**
	 * @return the options
	 */
	public List<AttributeOption> getOptions() {
		return options;
	}

	/**
	 * @param options
	 *            the options to set
	 */
	public void setOptions(List<AttributeOption> options) {
		this.options = options;
	}

	public void addOption(AttributeOption option) {
		this.options.add(option);
	}
}
