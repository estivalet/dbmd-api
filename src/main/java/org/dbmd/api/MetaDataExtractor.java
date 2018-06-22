package org.dbmd.api;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.Properties;

import org.dbmd.model.Catalog;
import org.dbmd.model.Column;
import org.dbmd.model.Database;
import org.dbmd.model.Driver;
import org.dbmd.model.ExportedKey;
import org.dbmd.model.ImportedKey;
import org.dbmd.model.PrimaryKey;
import org.dbmd.model.Schema;
import org.dbmd.model.Table;
import org.dbmd.model.UniqueKey;

import com.google.gson.GsonBuilder;

public class MetaDataExtractor {

	private Database extractMainInformation(Database db, DatabaseMetaData md) throws Exception {
		db.setProductName(md.getDatabaseProductName());
		db.setProductVersion(md.getDatabaseProductVersion());
		db.setMajorVersion(md.getDatabaseMajorVersion());
		db.setMinorVersion(md.getDatabaseMinorVersion());
		return db;
	}

	private Database extractDriverInformation(Database db, DatabaseMetaData md) throws Exception {
		Driver driver = new Driver();
		driver.setName(md.getDriverName());
		driver.setVersion(md.getDriverVersion());
		driver.setMajorVersion(md.getDriverMajorVersion());
		driver.setMajorVersion(md.getDriverMinorVersion());
		driver.setJdbcMajorVersion(md.getJDBCMajorVersion());
		driver.setJdbcMinorVersion(md.getJDBCMinorVersion());
		driver.setSupportCatalogs(md.supportsCatalogsInTableDefinitions());
		driver.setSupportSchemas(md.supportsSchemasInTableDefinitions());
		db.setDatabaseDriver(driver);
		return db;
	}

	private Database extractCatalogs(Database db, DatabaseMetaData md) throws Exception {
		ResultSet rs = md.getCatalogs();
		while (rs.next()) {
			Catalog catalog = new Catalog(rs.getString("TABLE_CAT"));
			db.addCatalog(catalog);
		}
		rs.close();

		return db;
	}

	private Database extractSchemas(Database db, DatabaseMetaData md) throws Exception {
		ResultSet rs = md.getSchemas();
		while (rs.next()) {
			Schema schema = new Schema(rs.getString("TABLE_SCHEM"));
			db.addSchema(schema);
		}
		rs.close();

		return db;
	}

	private Database extractTables(Database db, DatabaseMetaData md) throws Exception {
		for (Schema schema : db.getSchemas()) {
			ResultSet rs = md.getTables(null, schema.getName(), null, new String[] { "TABLE" });
			while (rs.next()) {
				Table t = new Table();
				t.setName(rs.getString("TABLE_NAME"));
				t.setCatalogName(rs.getString("TABLE_CAT"));
				t.setSchemaName(rs.getString("TABLE_SCHEM"));
				schema.addTable(t);
			}
			rs.close();
		}
		return db;
	}

	private Database extractTableColumns(Database db, DatabaseMetaData md) throws Exception {
		for (Schema schema : db.getSchemas()) {
			for (Table table : schema.getTables()) {
				ResultSet rs = md.getColumns(null, schema.getName(), table.getName(), null);
				while (rs.next()) {
					Column c = new Column();
					c.setName(rs.getString("COLUMN_NAME"));
					c.setDataType(rs.getInt("DATA_TYPE"));
					c.setTypeName(rs.getString("TYPE_NAME"));
					c.setSize(rs.getInt("COLUMN_SIZE"));
					c.setDecimalDigits(rs.getInt("DECIMAL_DIGITS"));
					c.setNullable(rs.getInt("NULLABLE") == DatabaseMetaData.columnNullable);
					c.setOrdinalPosition(rs.getInt("ORDINAL_POSITION"));
					table.addColumn(c);
				}
				rs.close();
			}
		}

		return db;
	}

	private Database extractPrimaryColumns(Database db, DatabaseMetaData md) throws Exception {
		for (Schema schema : db.getSchemas()) {
			for (Table table : schema.getTables()) {
				ResultSet rs = md.getPrimaryKeys(null, schema.getName(), table.getName());
				while (rs.next()) {
					PrimaryKey pk = new PrimaryKey();
					pk.setName(rs.getString("COLUMN_NAME"));
					table.addPrimaryKey(pk);
				}
				rs.close();
			}
		}

		return db;
	}

	private Database extractUniqueColumns(Database db, DatabaseMetaData md) throws Exception {
		for (Schema schema : db.getSchemas()) {
			for (Table table : schema.getTables()) {
				ResultSet rs = md.getIndexInfo(null, schema.getName(), table.getName(), true, true);
				while (rs.next()) {
					UniqueKey uk = new UniqueKey();
					uk.setName(rs.getString("COLUMN_NAME"));
					table.addUniqueColumn(uk);
				}
				rs.close();
			}
		}

		return db;
	}

	private Database extractExportedColumns(Database db, DatabaseMetaData md) throws Exception {
		for (Schema schema : db.getSchemas()) {
			for (Table table : schema.getTables()) {
				ResultSet rs = md.getExportedKeys(null, schema.getName(), table.getName());
				while (rs.next()) {
					ExportedKey ek = new ExportedKey();
					ek.setPkTable(rs.getString("PKTABLE_NAME"));
					ek.setPkColumn(rs.getString("PKCOLUMN_NAME"));
					ek.setFkTable(rs.getString("FKTABLE_NAME"));
					ek.setFkColumn(rs.getString("FKCOLUMN_NAME"));
					ek.setSequence(rs.getShort("KEY_SEQ"));
					table.addExportedColumn(ek);
				}
				rs.close();
			}
		}

		return db;
	}

	private Database extractImportedColumns(Database db, DatabaseMetaData md) throws Exception {
		for (Schema schema : db.getSchemas()) {
			for (Table table : schema.getTables()) {
				ResultSet rs = md.getImportedKeys(null, schema.getName(), table.getName());
				while (rs.next()) {
					ImportedKey ik = new ImportedKey();
					ik.setPkTable(rs.getString("PKTABLE_NAME"));
					ik.setPkColumn(rs.getString("PKCOLUMN_NAME"));
					ik.setFkTable(rs.getString("FKTABLE_NAME"));
					ik.setFkColumn(rs.getString("FKCOLUMN_NAME"));
					ik.setSequence(rs.getShort("KEY_SEQ"));
					table.addImportedColumn(ik);
				}
				rs.close();
			}
		}

		return db;
	}

	public static void main(String[] args) throws Exception {
		String configurationProperties = "/pg-connection.properties";
		Properties conf = new Properties();

		conf.load(MetaDataExtractor.class.getResourceAsStream(configurationProperties));
		Class.forName("org.postgresql.Driver");

		Connection c = DriverManager.getConnection(
				"jdbc:postgresql://" + conf.getProperty("BD_SERVER_HOST") + ":" + conf.getProperty("BD_SERVER_PORT")
						+ "/" + conf.getProperty("BD_BASE_NAME") + "?currentSchema=aud",
				conf.getProperty("BD_USER"), conf.getProperty("BD_PWD"));

		MetaDataExtractor extractor = new MetaDataExtractor();
		Database db = new Database();
		DatabaseMetaData md = c.getMetaData();
		extractor.extractMainInformation(db, md);
		extractor.extractDriverInformation(db, md);
		extractor.extractCatalogs(db, md);
		extractor.extractSchemas(db, md);
		extractor.extractTables(db, md);
		extractor.extractTableColumns(db, md);
		extractor.extractUniqueColumns(db, md);
		extractor.extractExportedColumns(db, md);
		extractor.extractImportedColumns(db, md);
		extractor.extractPrimaryColumns(db, md);

		// System.out.println(new
		// GsonBuilder().setPrettyPrinting().create().toJson(db));
		System.out.println(new GsonBuilder().setPrettyPrinting().create().toJson(db.getSchemas().get(0)));

		try {
			c.close();
		} catch (Exception ex) {
			// Log Exception - Cannot close connection
		}

	}
}
