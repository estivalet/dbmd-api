package org.magus.samples;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.magus.domain.App;
import org.magus.domain.Attribute;
import org.magus.domain.Model;
import org.zeeltech.util.IOUtil;
import org.zeeltech.util.StringUtils;

import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.BeansWrapperBuilder;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.TemplateHashModel;

public class JavaRestJSPMongoExample {
	private App app = new App();
	private Configuration cfg;

	public void setupTemplate() {
		cfg = new Configuration(Configuration.VERSION_2_3_28);
		cfg.setClassForTemplateLoading(JavaRestJSPMongoExample.class, "/org/magus/templates/code");
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
		System.out.println(app.getFullPath() + destFile);

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
		app.setName("Book Archive");
		app.setCopyright("(c) Luiz Fernando Estivalet 2018");
		app.setPath("C:/temp/apps");
		app.setShortName("barch");

		Model author = new Model();
		author.setName("Author");
		author.setPluralName("authors");
		author.setImutable(true);
		author.setController(true);
		author.setHasList(true);
		Attribute attr = new Attribute();
		attr.setName("name");
		attr.setType("text");
		// attr.setModel(author);
		attr.setReferenced(true);
		author.addAttribute(attr);
		// author.setOrderBy(attr);
		app.addModel(author);

		Model country = new Model();
		country.setName("Country");
		country.setPluralName("countries");
		country.setImutable(true);
		country.setController(true);
		country.setHasList(true);
		attr = new Attribute();
		attr.setName("description"); // name of the country change it after some tests
		attr.setType("text");
		// attr.setModel(country);
		attr.setReferenced(true);
		country.addAttribute(attr);
		// country.setOrderBy(attr);
		app.addModel(country);

		Model book = new Model();
		book.setName("Book");
		book.setPluralName("books");
		attr = new Attribute();
		attr.setName("title");
		attr.setLabel("Title");
		attr.setType("text");
		book.addAttribute(attr);
		// attr = new Attribute();
		// attr.setName("authorId");
		// attr.setLabel("Author");
		// attr.setType("text");
		// attr.setReferenced(true);
		// book.addAttribute(attr);
		// book.setOrderBy(attr);
		book.addModel(author);
		book.addModel(country);
		app.addModel(book);
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
		String archetype = "/archetypes/java-rest-jsp-mongo/templates/";

		JavaRestJSPMongoExample t = new JavaRestJSPMongoExample();
		t.setupTemplate();
		t.createApp();
		// t.generateJS("/archetypes/javascript/templates/");
		t.generateJava(archetype);

		System.out.println("Working Directory = " + System.getProperty("user.dir"));
		URL url = JavaRestJSPMongoExample.class.getClassLoader().getResource(".");
		File file = new File(url.toURI());
		System.out.println(file.getAbsolutePath());

		// Copy java web dependencies.
		String src = System.getProperty("user.dir") + "/src/main/resources/org/magus/templates/code" + archetype
				+ "web";
		String dest = "C:/temp/apps/barch/";
		IOUtil.copyFiles(new File(src), new File(dest), false);

		// Copy java framework common code
		src = System.getProperty("user.dir") + "/src/main/resources/org/magus/framework/";
		dest = "C:/temp/apps/barch/src/main/java/";
		IOUtil.copyFiles(new File(src), new File(dest), false);

	}
}
