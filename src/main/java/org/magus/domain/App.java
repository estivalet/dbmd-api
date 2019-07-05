package org.magus.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("serial")
public class App implements Serializable {
	private String name;
	private String shortName;
	private String databaseName;
	private String path;
	private String copyright;
	private List<Model> models = new ArrayList<Model>();
	private List<Service> services = new ArrayList<Service>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public String getPath() {
		return path;
	}

	public String getFullPath() {
		return this.path + "/" + this.shortName;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public List<Model> getModels() {
		return models;
	}

	public void addModel(Model model) {
		this.models.add(model);
	}

	public void setModels(List<Model> models) {
		this.models = models;
	}

	public List<Service> getServices() {
		return services;
	}

	public void setServices(List<Service> services) {
		this.services = services;
	}

	public void addService(Service service) {
		this.services.add(service);
	}

	public String getCopyright() {
		return copyright;
	}

	public void setCopyright(String copyright) {
		this.copyright = copyright;
	}

	public Model getModelByName(String name) {
		for (Model model : models) {
			if (model.getName().equals(name)) {
				return model;
			}
		}
		return null;
	}

	/**
	 * @return the databaseName
	 */
	public String getDatabaseName() {
		return databaseName;
	}

	/**
	 * @param databaseName
	 *            the databaseName to set
	 */
	public void setDatabaseName(String databaseName) {
		this.databaseName = databaseName;
	}

}
