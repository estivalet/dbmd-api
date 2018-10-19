<#include "/common/license.ftlh">

/*
 * Created on ${date} by ${user}
 */

package ${app.shortName}.model;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Path;

import org.bson.Document;

import com.google.gson.Gson;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

import ${app.shortName}.domain.${model.name};

/**
 * ${model.name} services.
 * 
 * @author ${user}
 */
@Path("${string.toCamelCase(model.name)}")
public class ${model.name}Model {

	public void create(${model.name} model) {
	
		MongoClientURI connectionString = new MongoClientURI("mongodb://localhost:27017");
		MongoClient mongoClient = new MongoClient(connectionString);
		MongoDatabase database = mongoClient.getDatabase("${app.shortName}");
		MongoCollection<Document> collection = database.getCollection("${string.toCamelCase(model.name)}");

		
		Document document = Document.parse(new Gson().toJson(model));
		collection.insertOne(document);
		
		mongoClient.close();
	}
	
	public List<${model.name}> retrieve() {
		List<${model.name}> list = new ArrayList<${model.name}>();
		
		MongoClientURI connectionString = new MongoClientURI("mongodb://localhost:27017");
		MongoClient mongoClient = new MongoClient(connectionString);
		MongoDatabase database = mongoClient.getDatabase("${app.shortName}");
	
		MongoCursor<Document> cursor = database.getCollection("${string.toCamelCase(model.name)}").find().iterator();
		try {
			while (cursor.hasNext()) {
				${model.name} model = new Gson().fromJson(cursor.next().toJson(), ${model.name}.class);
				list.add(model);
			}
		} finally {
			cursor.close();
		}

		mongoClient.close();

		return list;
	}

}