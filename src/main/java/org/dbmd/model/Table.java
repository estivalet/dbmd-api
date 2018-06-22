package org.dbmd.model;

import java.util.ArrayList;
import java.util.List;

public class Table {
	private String name;
	private String catalogName;
	private String schemaName;
	private List<Column> columns = new ArrayList<Column>();
	private List<PrimaryKey> primaryKeys = new ArrayList<PrimaryKey>();
	private List<UniqueKey> uniqueKeys = new ArrayList<UniqueKey>();
	private List<ExportedKey> exportedKeys = new ArrayList<ExportedKey>();
	private List<ImportedKey> importedKeys = new ArrayList<ImportedKey>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Column> getColumns() {
		return columns;
	}

	public void setColumns(List<Column> columns) {
		this.columns = columns;
	}

	public void addColumn(Column column) {
		this.columns.add(column);
	}

	public String getCatalogName() {
		return catalogName;
	}

	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}

	public String getSchemaName() {
		return schemaName;
	}

	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
	}

	public List<UniqueKey> getUniqueColumns() {
		return uniqueKeys;
	}

	public void setUniqueColumns(List<UniqueKey> uniqueColumns) {
		this.uniqueKeys = uniqueColumns;
	}

	public void addUniqueColumn(UniqueKey column) {
		this.uniqueKeys.add(column);
	}

	public List<UniqueKey> getUniqueKeys() {
		return uniqueKeys;
	}

	public void setUniqueKeys(List<UniqueKey> uniqueKeys) {
		this.uniqueKeys = uniqueKeys;
	}

	public List<ExportedKey> getExportedKeys() {
		return exportedKeys;
	}

	public void setExportedKeys(List<ExportedKey> exportedKeys) {
		this.exportedKeys = exportedKeys;
	}

	public void addExportedColumn(ExportedKey column) {
		this.exportedKeys.add(column);
	}

	public List<ImportedKey> getImportedKeys() {
		return importedKeys;
	}

	public void setImportedKeys(List<ImportedKey> importedKeys) {
		this.importedKeys = importedKeys;
	}

	public void addImportedColumn(ImportedKey column) {
		this.importedKeys.add(column);
	}

	public List<PrimaryKey> getPrimaryKeys() {
		return primaryKeys;
	}

	public void setPrimaryKeys(List<PrimaryKey> primaryKeys) {
		this.primaryKeys = primaryKeys;
	}

	public void addPrimaryKey(PrimaryKey column) {
		this.primaryKeys.add(column);
	}

}
