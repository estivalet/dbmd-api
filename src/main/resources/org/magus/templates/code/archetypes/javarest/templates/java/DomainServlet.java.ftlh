<#include "/common/license.ftlh">

/*
 * Created on ${date} by ${user}
 */

package ${app.shortName}.server;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * ${model.name} main controller.
 * 
 * @author ${user}
 */
@SuppressWarnings("serial")
@MultipartConfig
@WebServlet("/${string.toCamelCase(model.name)}")
public class ${model.name}Servlet extends ${string.toCamelCase(app.shortName, true)}Servlet {

	/**
	 * @param request
	 * @param response
	 * @param page
	 * @throws Exception
	 */
	protected void dispatch(HttpServletRequest request,
			HttpServletResponse response, String page) throws Exception {
		super.dispatch(request, response, "${string.toCamelCase(model.name)}/index.jsp");
	}
}
