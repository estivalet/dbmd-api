<#include "/common/license.ftlh">

/*
 * Created on ${date} by ${user}
 */

package ${app.shortName}.server;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.luisoft.commons.core.ICommand;
import org.luisoft.commons.core.IContext;

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
		super.dispatch("${string.toCamelCase(model.name)}/index.jsp");
		dispatcher.forward(request, response);
	}
}
