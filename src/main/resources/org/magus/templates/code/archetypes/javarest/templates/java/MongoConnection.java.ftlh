<#include "/common/license.ftlh">

/*
 * Created on ${date} by ${user}
 */

package ${app.shortName}.server;

import org.luisoft.mongodb.BaseMongoDO;

import org.mongodb.morphia.Datastore;
import org.mongodb.morphia.Morphia;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientOptions;
import com.mongodb.MongoClientURI;
import com.mongodb.MongoException;
import com.mongodb.WriteConcern;

public class MongoConnection {

	private static MongoConnection instance = new MongoConnection();

	private MongoClient mongo = null;
	private Datastore dataStore = null;
	private Morphia morphia = null;

	private MongoConnection() {
	}

	public MongoClient getMongo() throws RuntimeException {
		if (mongo == null) {
			System.out.println("Starting Mongo");
			MongoClientOptions.Builder options = MongoClientOptions.builder().connectionsPerHost(4)
					.maxConnectionIdleTime((60 * 1_000)).maxConnectionLifeTime((120 * 1_000))
					.writeConcern(WriteConcern.ACKNOWLEDGED);

			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017", options);

			System.out.println("About to connect to MongoDB @ " + uri.toString());

			try {
				mongo = new MongoClient(uri);
			} catch (MongoException ex) {
				System.out.println("An error occoured when connecting to MongoDB");
			} catch (Exception ex) {
				System.out.println("An error occoured when connecting to MongoDB");
			}
		}

		return mongo;
	}

	public Morphia getMorphia() {
		if (morphia == null) {
			System.out.println("Starting Morphia");
			morphia = new Morphia();

			System.out.println("Mapping packages for clases within %s");
			morphia.mapPackageFromClass(BaseMongoDO.class);
		}

		return morphia;
	}

	public Datastore getDatastore() {
		if (dataStore == null) {
			String dbName = "${app.shortName}";
			System.out.println("Starting DataStore on DB: %s" + dbName);
			dataStore = getMorphia().createDatastore(getMongo(), dbName);
		}

		return dataStore;
	}

	public void init() {
		System.out.println("Bootstraping");
		getMongo();
		getMorphia();
		getDatastore();
	}

	public void close() {
		System.out.println("Closing MongoDB connection");
		if (mongo != null) {
			try {
				mongo.close();
				System.out.println("Nulling the connection dependency objects");
				mongo = null;
				morphia = null;
				dataStore = null;
			} catch (Exception e) {
				System.out.println("An error occurred when closing the MongoDB connection\n%s");
			}
		} else {
			System.out.println("mongo object was null, wouldn't close connection");
		}
	}

	public static MongoConnection getInstance() {
		return instance;
	}
}