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
 * 
 * @author lestivalet
 *
 */
public class NodeExpressAuthPassportMongoExample {

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
		processAppTemplate(app, root, archetype + "app.js.ftlh", "/app.js");
		processAppTemplate(app, root, archetype + "env.ftlh", "/.env");
		processAppTemplate(app, root, archetype + "package.json.ftlh", "/package.json");

		processAppTemplate(app, root, archetype + "app/models/db.js.ftlh", "/app/models/db.js");

		processAppTemplate(app, root, archetype + "app/routes/index.js.ftlh", "/app/routes/index.js");
		processAppTemplate(app, root, archetype + "app/routes/login.js.ftlh", "/app/routes/login.js");
		processAppTemplate(app, root, archetype + "app/routes/reports.js.ftlh", "/app/routes/reports.js");
		processAppTemplate(app, root, archetype + "app/routes/users.js.ftlh", "/app/routes/users.js");

		processAppTemplate(app, root, archetype + "app/tools/auth.js.ftlh", "/app/tools/auth.js");
		processAppTemplate(app, root, archetype + "app/tools/mail.js.ftlh", "/app/tools/mail.js");
		processAppTemplate(app, root, archetype + "app/tools/permissions.js.ftlh", "/app/tools/permissions.js");
		processAppTemplate(app, root, archetype + "app/tools/utils.js.ftlh", "/app/tools/utils.js");

		processAppTemplate(app, root, archetype + "app/views/error.ejs.ftlh", "/app/views/error.ejs");
		processAppTemplate(app, root, archetype + "app/views/forgot.ejs.ftlh", "/app/views/forgot.ejs");
		processAppTemplate(app, root, archetype + "app/views/index.ejs.ftlh", "/app/views/index.ejs");
		processAppTemplate(app, root, archetype + "app/views/login.ejs.ftlh", "/app/views/login.ejs");
		processAppTemplate(app, root, archetype + "app/views/reports.ejs.ftlh", "/app/views/reports.ejs");
		processAppTemplate(app, root, archetype + "app/views/signup.ejs.ftlh", "/app/views/signup.ejs");

		processAppTemplate(app, root, archetype + "bin/www.ftlh", "/bin/www");

		System.out.println("Finished copying files");

	}

	public static void main(String[] args) throws Exception {
		InputStream in = NodeExpressEJSSQLiteExample.class.getResourceAsStream("node-express-auth-passport-mongo.json");
		App app = new Gson().fromJson(IOUtil.readFully(in), App.class);
		in.close();

		// Set app reference to all models
		for (Model m : app.getModels()) {
			m.setApp(app);
			for (Attribute a : m.getAttributes()) {
				a.setModel(m.getName());
			}
		}

		NodeExpressAuthPassportMongoExample t = new NodeExpressAuthPassportMongoExample();
		t.setupTemplate();
		t.generateApp("/archetypes/node-express-auth-passport-mongo/templates/", app);

	}
}
