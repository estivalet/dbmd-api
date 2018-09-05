<#include "/common/license.ftlh">

package ${app.shortName}.dao;

import ${app.shortName}.domain.${model.name};

import org.bson.types.ObjectId;
import org.mongodb.morphia.Datastore;
import org.mongodb.morphia.dao.BasicDAO;

import com.mongodb.DBObject;
import com.mongodb.WriteResult;

import ${app.shortName}.server.MongoConnection;

public class ${model.name}Dao extends BasicDAO<${model.name}, ObjectId> {

	public ${model.name}Dao(Datastore ds) {
		super(ds);
	}

	public static void main(String[] args) {
		MongoConnection conn = MongoConnection.getInstance();
		${model.name}Dao dao = new ${model.name}Dao(conn.getDatastore());
		${model.name} m = new ${model.name}();
		//m.setTexto("test mongo morphia2");
		DBObject tmp = conn.getMorphia().toDBObject(m);
		//WriteResult wResult = dao.getCollection().insert(tmp);
		
		System.out.println(dao.getCollection().count());
		DBObject obj = dao.getCollection().findOne(new ObjectId("5b7c4d5693fc5508306da3af"));
		System.out.println(obj);

		conn.close();
		
		
		/////////////////////////
		// list
		MongoClient mongoClient = new MongoClient("localhost", 27017);
		MongoDatabase db = mongoClient.getDatabase("alura1");
		MongoCollection<Document> collection = db.getCollection("mensagem");
		MongoCursor<Document> cursor = collection.find().iterator();
		try {
			while (cursor.hasNext()) {
				System.out.println(cursor.next().toJson());
			}
		} finally {
			cursor.close();
		}

		// add
		Mensagem m = new Mensagem();
		m.setTexto("NOVA MSG");
		Gson gson = new Gson();
		String data = gson.toJson(m);
		GsonBuilder gb = new GsonBuilder();
		Gson g = gb.create();
		Map<String, Object> map = g.fromJson(data, new TypeToken<Map<String, Object>>() {
		}.getType());
		Document doc = new Document(map);
		collection.insertOne(doc);

		// find
		System.out.println(collection.find(Filters.eq("_id", new ObjectId("5b8ecd9193fc5528844def61"))).first());

		// delete
		collection.deleteMany(Filters.eq("texto", "NOVA MSG"));

		mongoClient.close();
		

	}
}
