package org.magus.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Represents a model/entity of an application.
 * 
 * @author lestivalet
 */
@SuppressWarnings("serial")
public class Model2 implements Serializable {

	/** Model name. */
	private String name;

	/** Model plural name. */
	private String pluralName;

	/** List of attributes of this model. */
	protected List<Attribute> attributes = new ArrayList<Attribute>();

	/** List of models of this model. */
	protected List<Model2> models = new ArrayList<Model2>();

	/** Indicates if the model is imutable or not. */
	private Boolean imutable = false;

	/** Indicates if the model is a controller or not. */
	private Boolean controller = false;

	/** Indicates if the model will have a list of models. */
	private Boolean hasList = false;

	/** Single attribute to order by the list. */
	private Attribute orderBy;

	/**
	 * Display attribute in case of "foreign keys" to be displayed in a combo for
	 * e.g.
	 */
	private Attribute display;

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

	public void addModel(Model2 model) {
		this.models.add(model);
	}

	public List<Model2> getModels() {
		return models;
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
		for (Model2 m : this.models) {
			for (Attribute a : m.attributes) {
				if (a.getReferenced()) {
					attrs.add(a);
				}
			}
		}
		return attrs;
	}

	public String getAttributesCommaSeparated() {
		return attributes.stream().map(c -> String.valueOf(c)).collect(Collectors.joining(","));
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

	public Attribute getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(Attribute orderBy) {
		this.orderBy = orderBy;
	}

	public Attribute getDisplay() {
		return display;
	}

	public void setDisplay(Attribute display) {
		this.display = display;
	}

	public static void main(String[] args) {
		App app = new App();
		app.setName("Book Archive Node Express EJS Mongo Template");
		app.setCopyright("(c) Luiz Fernando Estivalet 2018");
		app.setPath("C:/temp/appsjs");
		app.setShortName("barch");

		Model author = new Model();
		author.setName("Author");
		author.setPluralName("authors");
		author.setImutable(true);
		author.setController(true);
		author.setHasList(true);
		Attribute attr = new Attribute();
		attr.setName("name");
		attr.setType("text");
		attr.setLabel("Nome do Autor");
		attr.setDescription("Full author's name");
		// attr.setModel(author);
		attr.setReferenced(true);
		attr.setRequired(true);
		author.addAttribute(attr);
		// author.setOrderBy(attr);
		// app.addModel(author);

		Model country = new Model();
		country.setName("Country");
		country.setPluralName("countries");
		country.setImutable(true);
		country.setController(true);
		country.setHasList(true);
		attr = new Attribute();
		attr.setName("description"); // name of the country change it after some tests
		attr.setType("text");
		// attr.setModel(country);
		attr.setReferenced(true);
		country.addAttribute(attr);
		// country.setOrderBy(attr);
		app.addModel(country);

		Model book = new Model();
		book.setName("Book");
		book.setPluralName("books");
		attr = new Attribute();
		attr.setName("title");
		attr.setLabel("Title");
		attr.setType("text");
		book.addAttribute(attr);
		attr = new Attribute();
		attr.setName("authorId");
		attr.setLabel("Author");
		attr.setType("text");
		attr.setReferenced(true);
		book.addAttribute(attr);
		// book.setOrderBy(attr);
		// book.addModel(author);
		// book.addModel(country);
		app.addModel(book);

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String json = gson.toJson(app);
		System.out.println(json);

	}
}
