<#include "/common/license.ftlh">

/*
 * Created on ${date} by ${user}
 */

package ${app.shortName}.service;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.mongodb.DBObject;
import com.mongodb.WriteResult;

import ${app.shortName}.dao.${model.name}Dao;
import ${app.shortName}.domain.${model.name};
import ${app.shortName}.server.MongoConnection;


import ${app.shortName}.domain.${model.name};

/**
 * ${model.name} services.
 * 
 * @author ${user}
 */
@Path("${string.toCamelCase(model.name)}")
public class ${model.name}Service {

	/**
	 * $ curl -v -H "Content-Type: application/json" -d '{"descricao":"Agua"}'
	 * http://localhost:8080/recipe/rest/categorias/add
	 */
	@Path("add")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response insert(String contents) {
		System.out.println("contents--->" + contents);
   	    
		MongoConnection conn = MongoConnection.getInstance();
		${model.name}Dao dao = new ${model.name}Dao(conn.getDatastore());
		${model.name} domain = new Gson().fromJson(contents, ${model.name}.class);
		DBObject tmp = conn.getMorphia().toDBObject(domain);
		if (domain.getId() == null) {
			WriteResult wResult = dao.getCollection().insert(tmp);
		} else {
		    DBObject obj = dao.getCollection().findOne(domain.getId());
		    dao.getCollection().update(obj, tmp);
		}
   	    
   	    
		return Response.status(200).build();
	}
	
	@Path("delete")
	@DELETE
	@Consumes(MediaType.APPLICATION_JSON)
	public Response delete(String contents) {
		System.out.println("contents--->" + contents);

		MongoConnection conn = MongoConnection.getInstance();
		${model.name}Dao dao = new ${model.name}Dao(conn.getDatastore());
		${model.name} domain = new Gson().fromJson(contents, ${model.name}.class);
		System.out.println(domain.getId());
		DBObject tmp = conn.getMorphia().toDBObject(domain);
		WriteResult wResult = dao.getCollection().remove(tmp);

		return Response.status(200).build();
	}

	
	@Path("list")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String list() {
		MongoConnection conn = MongoConnection.getInstance();
		${model.name}Dao dao = new ${model.name}Dao(conn.getDatastore());
		return new Gson().toJson(dao.find().asList());
	}

}
