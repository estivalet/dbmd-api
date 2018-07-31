package org.magus;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.FileUtils;

import com.google.gson.GsonBuilder;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

public class Test {
	public static void main(String[] args) throws Exception {
		// Create and adjust the configuration singleton.
		Configuration cfg = new Configuration(Configuration.VERSION_2_3_27);
		cfg.setClassForTemplateLoading(Test.class, "/org/magus/archetypes/javascript/templates");
		cfg.setDefaultEncoding("UTF-8");
		cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
		cfg.setLogTemplateExceptions(false);
		cfg.setWrapUncheckedExceptions(true);

		App app = new App();
		app.setPath("C:/temp/apps");
		app.setShortName("alura1");

		Model model = new JSModel();
		model.setName("Negociacao");
		model.setImutable(true);
		model.setController(true);
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

		model = new JSModel();
		model.setName("Mensagem");
		attr = new Attribute();
		attr.setName("texto");
		attr.setType("text");
		attr.setDefaultValue("xx");
		model.addAttribute(attr);
		app.addModel(model);

		// Create app folder and copy static files
		new File(app.getFullPath()).mkdirs();
		new File(app.getFullPath() + "/js/app/models/").mkdirs();
		new File(app.getFullPath() + "/js/app/controllers/").mkdirs();
		File sourceLocation = new File(Test.class.getResource(".").getPath() + "archetypes/javascript/static");
		File targetLocation = new File(app.getFullPath());
		FileUtils.copyDirectory(sourceLocation, targetLocation);

		// Generate models.
		for (Model m : app.getModels()) {
			// Create a data-model.
			Map root = new HashMap();
			root.put("model", m);

			// Get the model template (uses cache internally).
			Template template = cfg.getTemplate("model.ftlh");
			Writer fileWriter = new FileWriter(new File(app.getFullPath() + "/js/app/models/" + m.getName() + ".js"));
			template.process(root, fileWriter);
			fileWriter.close();

			if (m.getController()) {
				// Get the controller template (uses cache internally).
				template = cfg.getTemplate("controller.ftlh");
				fileWriter = new FileWriter(
						new File(app.getFullPath() + "/js/app/controllers/" + m.getName() + "Controller.js"));
				template.process(root, fileWriter);
				fileWriter.close();
			}
		}

		System.out.println(new GsonBuilder().setPrettyPrinting().create().toJson(app));
	}
}
