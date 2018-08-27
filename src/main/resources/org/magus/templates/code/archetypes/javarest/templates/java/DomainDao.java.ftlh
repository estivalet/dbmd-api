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
		WriteResult wResult = dao.getCollection().insert(tmp);
		conn.close();
	}
}
