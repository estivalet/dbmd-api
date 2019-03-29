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
 * Curso Alura: Node.js Partes 1 e 2: Inovando com JavaScript no backend
 * 
 * @author lestivalet
 *
 */
public class NodeExpressMarkoSqliteExample {

	private Configuration cfg;

	private static final String BASE_TPL_FOLDER = "/src/main/resources/org/magus/templates/code";

	private static final String USER_DIR = System.getProperty("user.dir");

	/**
	 * 
	 */
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
	public void processTemplate(App app, Object dataModel, String templateFile, String destFile) throws Exception {
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

	/**
	 * @param root
	 * @throws Exception
	 */
	private void addCommonTemplateVariables(String archetype, Map<String, Object> root) throws Exception {
		// Add static methods to be accesible by the templates.
		BeansWrapper wrapper = new BeansWrapperBuilder(Configuration.VERSION_2_3_28).build();
		TemplateHashModel staticModels = wrapper.getStaticModels();
		TemplateHashModel stringStatics = (TemplateHashModel) staticModels.get("org.zeeltech.util.StringUtils");
		root.put("string", stringStatics);
		root.put("date", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
		root.put("user", System.getProperty("user.name"));
	}

	/**
	 * @param app
	 * @throws Exception
	 */
	private void copyFolders(String archetype, App app) throws Exception {
		// copy public folder.
		String src = USER_DIR + BASE_TPL_FOLDER + archetype + "src/app/public";
		String dest = app.getFullPath() + "/src/app/public";
		IOUtil.copyFiles(new File(src), new File(dest), false);

		// copy base views folder.
		src = USER_DIR + BASE_TPL_FOLDER + archetype + "src/app/views/base";
		dest = app.getFullPath() + "/src/app/views/base";
		IOUtil.copyFiles(new File(src), new File(dest), false);

		// copy config folder.
		src = USER_DIR + BASE_TPL_FOLDER + archetype + "src/config";
		dest = app.getFullPath() + "/src/config";
		IOUtil.copyFiles(new File(src), new File(dest), false);

		src = USER_DIR + BASE_TPL_FOLDER + archetype + "src/app/infra/usuario-dao.js";
		dest = app.getFullPath() + "/src/app/infra/usuario-dao.js";
		IOUtil.copyFiles(new File(src), new File(dest), false);

		src = USER_DIR + BASE_TPL_FOLDER + archetype + "src/app/rotas/base-rotas.js";
		dest = app.getFullPath() + "/src/app/rotas/base-rotas.js";
		IOUtil.copyFiles(new File(src), new File(dest), false);

	}

	/**
	 * @param archetype
	 * @param app
	 * @param root
	 * @throws Exception
	 */
	private void processAppTemplates(String archetype, App app, Map<String, Object> root) throws Exception {
		processTemplate(app, root, archetype + "package.json.ftlh", "/package.json");
		processTemplate(app, root, archetype + "server.js.ftlh", "/server.js");
		processTemplate(app, root, archetype + "src/app/controladores/base-controlador.js.ftlh",
				"/src/app/controladores/base-controlador.js");
		processTemplate(app, root, archetype + "src/app/rotas/rotas.js.ftlh", "/src/app/rotas/rotas.js");
		processTemplate(app, root, archetype + "src/app/views/templates.js.ftlh", "/src/app/views/templates.js");
	}

	/**
	 * @param archetype
	 * @param app
	 * @param root
	 * @throws Exception
	 */
	private void processAppModelsTemplates(String archetype, App app, Map<String, Object> root) throws Exception {
		// Model specific templates
		for (Model m : app.getModels()) {
			root.put("model", m);
			processTemplate(app, root, archetype + "src/app/infra/model-dao.js.ftlh",
					"/src/app/infra/" + StringUtils.toCamelCase(m.getName()) + "-dao.js");
			processTemplate(app, root, archetype + "src/app/controladores/model-controlador.js.ftlh",
					"/src/app/controladores/" + StringUtils.toCamelCase(m.getName()) + "-controlador.js");
			processTemplate(app, root, archetype + "src/app/modelos/model.js.ftlh",
					"/src/app/modelos/" + StringUtils.toCamelCase(m.getName()) + ".js");
			processTemplate(app, root, archetype + "src/app/rotas/model-rotas.js.ftlh",
					"/src/app/rotas/" + StringUtils.toCamelCase(m.getName()) + "-rotas.js");
			processTemplate(app, root, archetype + "src/app/views/model/form/form.marko.ftlh",
					"/src/app/views/" + m.getPluralName() + "/form/form.marko");
			processTemplate(app, root, archetype + "src/app/views/model/lista/lista.marko.ftlh",
					"/src/app/views/" + m.getPluralName() + "/lista/lista.marko");
			processTemplate(app, root, archetype + "src/app/views/model/index.js.ftlh",
					"/src/app/views/" + m.getPluralName() + "/index.js");
		}

	}

	/**
	 * @param archetype
	 * @param app
	 * @throws Exception
	 */
	private void generateApp(String archetype, App app) throws Exception {
		// Create a data-model.
		Map<String, Object> root = new HashMap<String, Object>();
		root.put("app", app);
		this.addCommonTemplateVariables(archetype, root);

		this.copyFolders(archetype, app);
		this.processAppTemplates(archetype, app, root);
		this.processAppModelsTemplates(archetype, app, root);

	}

	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		InputStream in = NodeExpressMarkoSqliteExample.class.getResourceAsStream("node-express-marko-sqlite-app.json");
		String json = IOUtil.readFully(in);
		Gson gson = new Gson();
		App app = gson.fromJson(json, App.class);
		in.close();

		NodeExpressMarkoSqliteExample t = new NodeExpressMarkoSqliteExample();
		t.setupTemplate();
		t.generateApp("/archetypes/node-express-marko-sqlite/templates/", app);

	}
}
