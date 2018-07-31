package org.magus;

import java.util.ArrayList;
import java.util.List;

public class App {
	private String name;
	private String shortName;
	private String path;
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

}
