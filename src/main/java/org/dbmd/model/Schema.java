package org.dbmd.model;

import java.util.ArrayList;
import java.util.List;

public class Schema {
	private String name;
	private List<Table> tables = new ArrayList<Table>();

	public Schema(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Table> getTables() {
		return tables;
	}

	public void setTables(List<Table> tables) {
		this.tables = tables;
	}

	public void addTable(Table table) {
		this.tables.add(table);
	}

}
