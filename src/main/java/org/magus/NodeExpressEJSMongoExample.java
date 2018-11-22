package org.magus;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.magus.domain.App;
import org.magus.domain.Attribute;
import org.magus.domain.Model;
import org.zeeltech.util.StringUtils;

import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.BeansWrapperBuilder;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.TemplateHashModel;

/**
 * https://zellwk.com/blog/crud-express-mongodb/
 * 
 * @author lestivalet
 *
 */
public class NodeExpressEJSMongoExample {

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
		app.setName("Book Archive Node Express EJS Mongo Template");
		app.setCopyright("(c) Luiz Fernando Estivalet 2018");
		app.setPath("C:/temp/appsjs");
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
		attr.setLabel("Nome do Autor");
		attr.setDescription("Full author's name");
		attr.setModel(author);
		attr.setReferenced(true);
		attr.setRequired(true);
		author.addAttribute(attr);
		author.setOrderBy(attr);
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
		attr.setModel(country);
		attr.setReferenced(true);
		country.addAttribute(attr);
		country.setOrderBy(attr);
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
		book.setOrderBy(attr);
		book.addModel(author);
		book.addModel(country);
		app.addModel(book);
	}

	private void generate(String archetype) throws Exception {
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

		processTemplate(root, "/common/.gitignore.ftlh", "/.gitignore");
		processTemplate(root, archetype + "config/database.config.js.ftlh", "/config/database.config.js");
		processTemplate(root, archetype + "app.js.ftlh", "/app.js");
		processTemplate(root, archetype + "package.json.ftlh", "/package.json");
		processTemplate(root, archetype + "app/models/schema.model.js.ftlh", "/app/models/schema.model.js");
		processTemplate(root, archetype + "app/controllers/app.controller.js.ftlh",
				"/app/controllers/" + app.getShortName() + ".controller.js");
		processTemplate(root, archetype + "app/routes/app.route.js.ftlh",
				"/app/routes/" + app.getShortName() + ".routes.js");

		processTemplate(root, archetype + "app/views/content.ejs.ftlh", "/app/views/content.ejs");
		processTemplate(root, archetype + "app/views/controlbar.ejs.ftlh", "/app/views/controlbar.ejs");
		processTemplate(root, archetype + "app/views/footer.ejs.ftlh", "/app/views/footer.ejs");
		processTemplate(root, archetype + "app/views/index.ejs.ftlh", "/app/views/index.ejs");
		processTemplate(root, archetype + "app/views/leftbar.ejs.ftlh", "/app/views/leftbar.ejs");
		processTemplate(root, archetype + "app/views/topbar.ejs.ftlh", "/app/views/topbar.ejs");

		for (Model m : app.getModels()) {
			root.put("model", m);
			processTemplate(root, archetype + "app/routes/model.route.js.ftlh",
					"/app/routes/" + StringUtils.toCamelCase(m.getName()) + ".routes.js");
			processTemplate(root, archetype + "app/controllers/model.controller.js.ftlh",
					"/app/controllers/" + StringUtils.toCamelCase(m.getName()) + ".controller.js");
			processTemplate(root, archetype + "app/views/model/content.ejs.ftlh",
					"/app/views/" + StringUtils.toCamelCase(m.getName()) + "/content.ejs");
			processTemplate(root, archetype + "app/views/model/index.ejs.ftlh",
					"/app/views/" + StringUtils.toCamelCase(m.getName()) + "/index.ejs");
		}

		// Copy java framework common code (commented because it takes time to copy,
		// uncomment it again when fisnihed)
		// String src = System.getProperty("user.dir") +
		// "/src/main/resources/org/magus/templates/web/AdminLTE/";
		// String dest = "C:/temp/appsjs/barch/public/";
		// IOUtil.copyFiles(new File(src), new File(dest), false);

		System.out.println("Finished copying files");

	}

	public static void main(String[] args) throws Exception {
		NodeExpressEJSMongoExample t = new NodeExpressEJSMongoExample();
		t.setupTemplate();
		t.createApp();
		t.generate("/archetypes/node-express-ejs-mongo/templates/");

	}
}
