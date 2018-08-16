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
 * ${app.name} main controller.
 * 
 * @author ${user}
 */
@SuppressWarnings("serial")
@MultipartConfig
@WebServlet(name = "${app.shortName}", urlPatterns = "")
public class ${string.toCamelCase(app.shortName, true)}Servlet extends HttpServlet {

	/** Servlet context. */
	private IContext context;

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.GenericServlet#init()
	 */
	@Override
	public void init() throws ServletException {
		super.init();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest
	 * , javax.servlet.http.HttpServletResponse)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest
	 * , javax.servlet.http.HttpServletResponse)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @param request
	 * @param response
	 */
	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			// Identify requested command and execute it.
            String command = request.getParameter("command");
            if (command == null) {
                dispatch(request, response, "index.jsp");
                return;
            }
            String pkg = this.getClass().getPackage().getName() + ".commands.";
            String clazz = pkg + command + "Command";
			
			ICommand iCommand = (ICommand) Class.forName(clazz).newInstance();
			iCommand.execute(request, response, context);
			if (iCommand.dispatch() != null) {
				dispatch(request, response, iCommand.dispatch());
			}
		} catch (Exception e) {
			System.out.println("Problem with your request");
			e.printStackTrace();
		}
	}

	/**
	 * @param request
	 * @param response
	 * @param page
	 * @throws Exception
	 */
	protected void dispatch(HttpServletRequest request,
			HttpServletResponse response, String page) throws Exception {
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher("/WEB-INF/jsp/" + page);
		dispatcher.forward(request, response);
	}
}
