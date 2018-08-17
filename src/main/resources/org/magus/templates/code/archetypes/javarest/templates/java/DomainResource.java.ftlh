<#include "/common/license.ftlh">

/*
 * Created on ${date} by ${user}
 */

package ${app.shortName}.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * ${model.name} services.
 * 
 * @author ${user}
 */
@Path("${string.toCamelCase(model.name)}")
public class ${model.name}Resource {

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
		return Response.status(200).build();
	}
}
