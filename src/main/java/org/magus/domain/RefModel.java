package org.magus.domain;

public class RefModel {

	/** Referenced model name. */
	private String name;

	/** Referenced model got from name above. */
	private Model model;

	/**
	 * If the referenced attribute of the model is visible in a table for example.
	 */
	private Boolean visibleInList = true;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the visibleInList
	 */
	public Boolean getVisibleInList() {
		return visibleInList;
	}

	/**
	 * @param visibleInList
	 *            the visibleInList to set
	 */
	public void setVisibleInList(Boolean visibleInList) {
		this.visibleInList = visibleInList;
	}

	/**
	 * @return the model
	 */
	public Model getModel() {
		return model;
	}

	/**
	 * @param model
	 *            the model to set
	 */
	public void setModel(Model model) {
		this.model = model;
	}

}
