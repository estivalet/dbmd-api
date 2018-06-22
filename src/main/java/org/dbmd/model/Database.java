package org.dbmd.model;

import java.util.ArrayList;
import java.util.List;

public class Database {
	private String productName;

	private String productVersion;

	private Integer majorVersion;

	private Integer minorVersion;

	private Driver databaseDriver;

	private List<Catalog> catalogs = new ArrayList<Catalog>();

	private List<Schema> schemas = new ArrayList<Schema>();

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductVersion() {
		return productVersion;
	}

	public void setProductVersion(String productVersion) {
		this.productVersion = productVersion;
	}

	public Integer getMajorVersion() {
		return majorVersion;
	}

	public void setMajorVersion(Integer majorVersion) {
		this.majorVersion = majorVersion;
	}

	public Integer getMinorVersion() {
		return minorVersion;
	}

	public void setMinorVersion(Integer minorVersion) {
		this.minorVersion = minorVersion;
	}

	public Driver getDatabaseDriver() {
		return databaseDriver;
	}

	public void setDatabaseDriver(Driver databaseDriver) {
		this.databaseDriver = databaseDriver;
	}

	public List<Catalog> getCatalogs() {
		return catalogs;
	}

	public void setCatalogs(List<Catalog> catalogs) {
		this.catalogs = catalogs;
	}

	public void addCatalog(Catalog catalog) {
		this.catalogs.add(catalog);
	}

	public List<Schema> getSchemas() {
		return schemas;
	}

	public void setSchemas(List<Schema> schemas) {
		this.schemas = schemas;
	}

	public void addSchema(Schema schema) {
		this.schemas.add(schema);
	}

}
