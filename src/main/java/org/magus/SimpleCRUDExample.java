package org.magus;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.magus.domain.App;
import org.magus.domain.Attribute;
import org.magus.domain.Model;
import org.zeeltech.util.IOUtil;
import org.zeeltech.util.StringUtils;

import com.google.gson.GsonBuilder;

import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.BeansWrapperBuilder;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.TemplateHashModel;

public class SimpleCRUDExample {
	private App app = new App();
	private Configuration cfg;

	public void setupTemplate() {
		cfg = new Configuration(Configuration.VERSION_2_3_28);
		cfg.setClassForTemplateLoading(SimpleCRUDExample.class, "/org/magus/templates/code");
		cfg.setDefaultEncoding("UTF-8");
		cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
		cfg.setLogTemplateExceptions(false);
		cfg.setWrapUncheckedExceptions(true);
	}

	/**
	 * @param dataModel
	 * @param templateFile
	 * @param destFile
	 * @throws Exception
	 */
	public void processTemplate(Object dataModel, String templateFile, String destFile) throws Exception {
		// Create destination folder.
		new File(app.getFullPath());
		if (destFile.lastIndexOf("/") > 0) {
			new File(app.getFullPath() + destFile.substring(0, destFile.lastIndexOf("/"))).mkdirs();
		}

		// Get template, process it and generate final file.
		Template template = cfg.getTemplate(templateFile);
		Writer fileWriter = new FileWriter(new File(app.getFullPath() + destFile));
		template.process(dataModel, fileWriter);
		fileWriter.close();
	}

	public void createApp() {
		app.setName("Alura Javascript Course");
		app.setCopyright("(c) Luiz Fernando Estivalet 2018");
		app.setPath("C:/temp/apps");
		app.setShortName("alura1");

		Model model = new Model();
		model.setName("Negociacao");
		model.setPluralName("negociacoes");
		model.setImutable(true);
		model.setController(true);
		model.setHasList(true);
		Attribute attr = new Attribute();
		attr.setName("data");
		attr.setType("date");
		model.addAttribute(attr);
		attr = new Attribute();
		attr.setName("quantidade");
		attr.setType("number");
		model.addAttribute(attr);
		attr = new Attribute();
		attr.setName("valor");
		attr.setType("double");
		model.addAttribute(attr);
		attr = new Attribute();
		attr.setName("volume");
		attr.setType("formula");
		attr.setValue("this._valor * this._quantidade");
		model.addAttribute(attr);
		app.addModel(model);

		model = new Model();
		model.setName("Mensagem");
		model.setPluralName("mensagens");
		attr = new Attribute();
		attr.setName("texto");
		attr.setLabel("Texto");
		attr.setType("text");
		attr.setTooltip("texto da mensagem");
		attr.setDescription("texto da mensagem a ser exibido");
		attr.setDefaultValue("xx");
		model.addAttribute(attr);
		model.setOrderBy(attr);
		app.addModel(model);
	}

	private void generateJS(String archetype) throws IOException, TemplateException {
		// Create app folder and copy static files
		new File(app.getFullPath()).mkdirs();
		new File(app.getFullPath() + "/js/app/models/").mkdirs();
		new File(app.getFullPath() + "/js/app/controllers/").mkdirs();
		File sourceLocation = new File(SimpleCRUDExample.class.getResource(".").getPath() + "archetypes/javascript/static");
		File targetLocation = new File(app.getFullPath());
		FileUtils.copyDirectory(sourceLocation, targetLocation);

		// Create a data-model.
		Map root = new HashMap();
		root.put("app", app);

		// Generate models.
		for (Model m : app.getModels()) {
			root.put("model", m);

			// Get the model template (uses cache internally).
			Template template = cfg.getTemplate(archetype + "model.js.ftlh");
			Writer fileWriter = new FileWriter(new File(app.getFullPath() + "/js/app/models/" + m.getName() + ".js"));
			template.process(root, fileWriter);
			fileWriter.close();

			//
			template = cfg.getTemplate(archetype + "view.js.ftlh");
			fileWriter = new FileWriter(new File(
					app.getFullPath() + "/js/app/views/" + StringUtils.capitalize(m.getPluralName()) + "View.js"));
			template.process(root, fileWriter);
			fileWriter.close();

			if (m.getController()) {
				// Get the controller template (uses cache internally).
				template = cfg.getTemplate(archetype + "controller.js.ftlh");
				fileWriter = new FileWriter(
						new File(app.getFullPath() + "/js/app/controllers/" + m.getName() + "Controller.js"));
				template.process(root, fileWriter);
				fileWriter.close();
			}

			if (m.getHasList()) {
				template = cfg.getTemplate(archetype + "listmodel.js.ftlh");
				fileWriter = new FileWriter(new File(app.getFullPath() + "/js/app/models/Lista"
						+ StringUtils.capitalize(m.getPluralName()) + ".js"));
				template.process(root, fileWriter);
				fileWriter.close();

			}
		}

		// Generate main index.html file.
		Template template = cfg.getTemplate(archetype + "index.html.ftlh");
		Writer fileWriter = new FileWriter(new File(app.getFullPath() + "/index.html"));
		template.process(null, fileWriter);
		fileWriter.close();

		System.out.println(new GsonBuilder().setPrettyPrinting().create().toJson(app));

	}

	private void generateJava(String archetype) throws Exception {
		// Create a data-model.
		Map root = new HashMap();
		root.put("app", app);

		// Add static methos to be accesible by the templates.
		BeansWrapper wrapper = new BeansWrapperBuilder(Configuration.VERSION_2_3_28).build();
		TemplateHashModel staticModels = wrapper.getStaticModels();
		TemplateHashModel mapperStatics = (TemplateHashModel) staticModels
				.get("org.magus.util.JavaAttributeTypeMapper");
		TemplateHashModel stringStatics = (TemplateHashModel) staticModels.get("org.zeeltech.util.StringUtils");
		root.put("type", mapperStatics);
		root.put("string", stringStatics);
		root.put("date", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
		root.put("user", System.getProperty("user.name"));

		// Generate models.
		for (Model m : app.getModels()) {
			root.put("model", m);
			processTemplate(root, archetype + "java/Domain.java.ftlh",
					"/src/main/java/" + app.getShortName() + "/domain/" + m.getName() + ".java");
			processTemplate(root, archetype + "java/DomainServlet.java.ftlh",
					"/src/main/java/" + app.getShortName() + "/server/" + m.getName() + "Servlet.java");
			processTemplate(root, archetype + "java/DomainService.java.ftlh",
					"/src/main/java/" + app.getShortName() + "/service/" + m.getName() + "Service.java");

			// use one or other Model does not use morphia and dao uses morphia mongodb
			// processTemplate(root, archetype + "java/DomainModel.java.ftlh",
			// "/src/main/java/" + app.getShortName() + "/model/" + m.getName() +
			// "Model.java");
			processTemplate(root, archetype + "java/DomainDao.java.ftlh",
					"/src/main/java/" + app.getShortName() + "/dao/" + m.getName() + "Dao.java");

			processTemplate(root, archetype + "layout/AdminLTE/index2.jsp.ftlh",
					"/WebContent/WEB-INF/jsp/" + StringUtils.toCamelCase(m.getName()) + "/index.jsp");
		}
		processTemplate(root, archetype + "java/ApplicationServlet.java.ftlh", "/src/main/java/" + app.getShortName()
				+ "/server/" + StringUtils.toCamelCase(app.getShortName(), true) + "Servlet.java");

		processTemplate(root, archetype + "eclipse/classpath.ftlh", "/.classpath");
		processTemplate(root, archetype + "eclipse/project.ftlh", "/.project");

		processTemplate(root, archetype + "pom.xml.ftlh", "/pom.xml");

		processTemplate(root, archetype + "tomcat/server.xml.ftlh", "/add-to-server.xml");

		processTemplate(root, archetype + "web.xml.ftlh", "/WebContent/WEB-INF/web.xml");

		processTemplate(root, archetype + "layout/AdminLTE/index.jsp.ftlh", "/WebContent/WEB-INF/jsp/index.jsp");
		processTemplate(root, archetype + "layout/AdminLTE/header.jsp.ftlh", "/WebContent/WEB-INF/jsp/header.jsp");
		processTemplate(root, archetype + "layout/AdminLTE/footer.jsp.ftlh", "/WebContent/WEB-INF/jsp/footer.jsp");

		processTemplate(root, archetype + "java/MongoConnection.java.ftlh",
				"/src/main/java/" + app.getShortName() + "/server/MongoConnection.java");

	}

	public static void main(String[] args) throws Exception {
		SimpleCRUDExample t = new SimpleCRUDExample();
		t.setupTemplate();
		t.createApp();
		// t.generateJS("/archetypes/javascript/templates/");
		t.generateJava("/archetypes/javarest/templates/");

		System.out.println("Working Directory = " + System.getProperty("user.dir"));
		URL url = SimpleCRUDExample.class.getClassLoader().getResource(".");
		File file = new File(url.toURI());
		System.out.println(file.getAbsolutePath());

		// Copy web template
		String src = System.getProperty("user.dir") + "/src/main/resources/org/magus/templates/web/AdminLTE/";
		String dest = "C:/temp/apps/alura1/";
		IOUtil.copyFiles(new File(src), new File(dest), false);

		// Copy java framework common code
		src = System.getProperty("user.dir") + "/src/main/resources/org/magus/framework/";
		dest = "C:/temp/apps/alura1/src/main/java/";
		IOUtil.copyFiles(new File(src), new File(dest), false);

	}
}
