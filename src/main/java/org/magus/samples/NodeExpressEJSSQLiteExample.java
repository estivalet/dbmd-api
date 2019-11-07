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
import org.magus.domain.Attribute;
import org.magus.domain.Model;
import org.zeeltech.util.IOUtil;

import com.google.gson.Gson;

import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.BeansWrapperBuilder;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.TemplateHashModel;

/**
 * 
 * 1. Open node-express-ejs-sqlite-app.json and make sure the path to the folder
 * to generate the app is correct
 * 
 * 2. Run this class to generate the code
 * 
 * 3. Open the folder the path configured in step 1 in Visual Studio Code or any
 * other editor
 * 
 * 4. Open a terminal in the folder and run "npm install" to install all
 * dependencies
 * 
 * 5. Start the app using "npm run devstart"
 * 
 * 6. Open http://localhost:4000
 * 
 * @author lestivalet
 *
 */
public class NodeExpressEJSSQLiteExample {

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
		new File(app.getFullPath()).mkdirs();
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

		processAppTemplate(app, root, "/common/gitignore.ftlh", "/.gitignore");
		processAppTemplate(app, root, archetype + "config/database.config.js.ftlh", "/config/database.config.js");
		processAppTemplate(app, root, archetype + "app.js.ftlh", "/app.js");
		processAppTemplate(app, root, archetype + "database.sqlite.sql.ftlh", "/database.sql");
		processAppTemplate(app, root, archetype + "package.json.ftlh", "/package.json");
		processAppTemplate(app, root, archetype + "README.md.ftlh", "/README.md");
		processAppTemplate(app, root, archetype + "app/controllers/app.controller.js.ftlh",
				"/app/controllers/" + app.getShortName() + ".controller.js");
		processAppTemplate(app, root, archetype + "app/routes/app.route.js.ftlh",
				"/app/routes/" + app.getShortName() + ".routes.js");

		processAppTemplate(app, root, archetype + "app/views/content.ejs.ftlh", "/app/views/content.ejs");
		processAppTemplate(app, root, archetype + "app/views/controlbar.ejs.ftlh", "/app/views/controlbar.ejs");
		processAppTemplate(app, root, archetype + "app/views/footer.ejs.ftlh", "/app/views/footer.ejs");
		processAppTemplate(app, root, archetype + "app/views/index.ejs.ftlh", "/app/views/index.ejs");
		processAppTemplate(app, root, archetype + "app/views/leftbar.ejs.ftlh", "/app/views/leftbar.ejs");
		processAppTemplate(app, root, archetype + "app/views/topbar.ejs.ftlh", "/app/views/topbar.ejs");

		// for (Model m : app.getModels()) {
		// root.put("model", m);
		// processAppTemplate(app, root, archetype + "app/routes/model.route.js.ftlh",
		// "/app/routes/" + StringUtils.toCamelCase(m.getName()) + ".routes.js");
		// processAppTemplate(app, root, archetype +
		// "app/controllers/model.controller.js.ftlh",
		// "/app/controllers/" + StringUtils.toCamelCase(m.getName()) +
		// ".controller.js");
		// processAppTemplate(app, root, archetype + "app/views/model/content.ejs.ftlh",
		// "/app/views/" + StringUtils.toCamelCase(m.getName()) + "/content.ejs");
		// processAppTemplate(app, root, archetype + "app/views/model/detail.ejs.ftlh",
		// "/app/views/" + StringUtils.toCamelCase(m.getName()) + "/detail.ejs");
		// processAppTemplate(app, root, archetype + "app/views/model/list.ejs.ftlh",
		// "/app/views/" + StringUtils.toCamelCase(m.getName()) + "/list.ejs");
		// processAppTemplate(app, root, archetype + "app/views/model/index.ejs.ftlh",
		// "/app/views/" + StringUtils.toCamelCase(m.getName()) + "/index.ejs");
		// }

		// Copy java framework common code (commented because it takes time to copy,
		// uncomment it again when fisnihed)
		String src = System.getProperty("user.dir") + "/src/main/resources/org/magus/templates/web/AdminLTE-3.0.0-rc3/";
		String dest = app.getPath() + "/" + app.getShortName() + "/public/";
		IOUtil.copyFiles(new File(src), new File(dest), false);

		System.out.println("Finished copying files");

	}

	public static void main(String[] args) throws Exception {
		InputStream in = NodeExpressEJSSQLiteExample.class.getResourceAsStream("node-express-ejs-sqlite-app.json");
		App app = new Gson().fromJson(IOUtil.readFully(in), App.class);
		in.close();

		// Set app reference to all models
		for (Model m : app.getModels()) {
			m.setApp(app);
			for (Attribute a : m.getAttributes()) {
				a.setModel(m.getName());
			}
		}

		NodeExpressEJSSQLiteExample t = new NodeExpressEJSSQLiteExample();
		t.setupTemplate();
		t.generateApp("/archetypes/node-express-ejs-sqlite/templates/", app);

	}
}
