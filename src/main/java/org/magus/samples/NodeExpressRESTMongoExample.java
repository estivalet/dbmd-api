package org.magus.samples;

import java.io.File;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.magus.domain.App;
import org.magus.domain.Model;
import org.zeeltech.util.IOUtil;
import org.zeeltech.util.StringUtils;

import com.google.gson.Gson;

import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.BeansWrapperBuilder;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.TemplateHashModel;

/**
 * https://www.callicoder.com/node-js-express-mongodb-restful-crud-api-tutorial/
 * 
 * @author lestivalet
 *
 */
public class NodeExpressRESTMongoExample {

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
	public void processAppTemplate(App app, Object dataModel, String templateFile, String destFile) throws Exception {
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

	private void generateApp(String archetype, App app) throws Exception {
		// Create a data-model.
		Map<String, Object> root = new HashMap<String, Object>();
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

		processAppTemplate(app, root, "common/gitignore.ftlh", "/.gitignore");
		processAppTemplate(app, root, archetype + "config/database.config.js.ftlh", "/config/database.config.js");
		processAppTemplate(app, root, archetype + "server.js.ftlh", "/server.js");
		processAppTemplate(app, root, archetype + "package.json.ftlh", "/package.json");
		processAppTemplate(app, root, archetype + "README.md.ftlh", "/README.md");
		processAppTemplate(app, root, archetype + "app/models/schema.model.js.ftlh", "/app/models/schema.model.js");

		for (Model m : app.getModels()) {
			root.put("model", m);
			processAppTemplate(app, root, archetype + "app/routes/model.route.js.ftlh",
					"/app/routes/" + StringUtils.toCamelCase(m.getName()) + ".routes.js");
			processAppTemplate(app, root, archetype + "app/controllers/model.controller.js.ftlh",
					"/app/controllers/" + StringUtils.toCamelCase(m.getName()) + ".controller.js");
		}

		System.out.println("Finished copying files");

	}

	public static void main(String[] args) throws Exception {
		// Read app json description.
		InputStream in = NodeExpressRESTMongoExample.class.getResourceAsStream("node-express-rest-mongo-app.json");
		String json = IOUtil.readFully(in);
		Gson gson = new Gson();
		App app = gson.fromJson(json, App.class);
		in.close();

		// Set app reference to all models
		for (Model m : app.getModels()) {
			m.setApp(app);
		}

		NodeExpressRESTMongoExample t = new NodeExpressRESTMongoExample();
		t.setupTemplate();
		t.generateApp("/archetypes/node-express-rest-mongo/templates/", app);

	}
}
