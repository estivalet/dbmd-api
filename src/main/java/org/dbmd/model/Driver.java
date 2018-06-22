package org.dbmd.model;

public class Driver {
	private String name;

	private String version;

	private Integer majorVersion;

	private Integer minorVersion;

	private Integer jdbcMajorVersion;

	private Integer jdbcMinorVersion;

	/** Does the database support catalogs? . */
	private boolean supportCatalogs;

	/** Does the database support schemas? . */
	private boolean supportSchemas;

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
	 * @return the version
	 */
	public String getVersion() {
		return version;
	}

	/**
	 * @param version
	 *            the version to set
	 */
	public void setVersion(String version) {
		this.version = version;
	}

	/**
	 * @return the jdbcMajorVersion
	 */
	public Integer getJdbcMajorVersion() {
		return jdbcMajorVersion;
	}

	/**
	 * @param jdbcMajorVersion
	 *            the jdbcMajorVersion to set
	 */
	public void setJdbcMajorVersion(Integer jdbcMajorVersion) {
		this.jdbcMajorVersion = jdbcMajorVersion;
	}

	/**
	 * @return the jdbcMinorVersion
	 */
	public Integer getJdbcMinorVersion() {
		return jdbcMinorVersion;
	}

	/**
	 * @param jdbcMinorVersion
	 *            the jdbcMinorVersion to set
	 */
	public void setJdbcMinorVersion(Integer jdbcMinorVersion) {
		this.jdbcMinorVersion = jdbcMinorVersion;
	}

	/**
	 * @return the majorVersion
	 */
	public Integer getMajorVersion() {
		return majorVersion;
	}

	/**
	 * @param majorVersion
	 *            the majorVersion to set
	 */
	public void setMajorVersion(Integer majorVersion) {
		this.majorVersion = majorVersion;
	}

	/**
	 * @return the minorVersion
	 */
	public Integer getMinorVersion() {
		return minorVersion;
	}

	/**
	 * @param minorVersion
	 *            the minorVersion to set
	 */
	public void setMinorVersion(Integer minorVersion) {
		this.minorVersion = minorVersion;
	}

	/**
	 * @return the supportCatalogs
	 */
	public boolean hasSupportCatalogs() {
		return supportCatalogs;
	}

	/**
	 * @param supportCatalogs
	 *            the supportCatalogs to set
	 */
	public void setSupportCatalogs(boolean supportCatalogs) {
		this.supportCatalogs = supportCatalogs;
	}

	/**
	 * @return the supportSchemas
	 */
	public boolean hasSupportSchemas() {
		return supportSchemas;
	}

	/**
	 * @param supportSchemas
	 *            the supportSchemas to set
	 */
	public void setSupportSchemas(boolean supportSchemas) {
		this.supportSchemas = supportSchemas;
	}
}
