package org.magus;

import java.io.File;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.GsonBuilder;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

public class Test {
	public static void main(String[] args) throws Exception {
		// Create and adjust the configuration singleton.
		Configuration cfg = new Configuration(Configuration.VERSION_2_3_27);
		cfg.setDirectoryForTemplateLoading(new File("."));
		cfg.setDefaultEncoding("UTF-8");
		cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
		cfg.setLogTemplateExceptions(false);
		cfg.setWrapUncheckedExceptions(true);

		Model m = new Model();
		m.setName("Negociacao");
		Attribute a = new Attribute();
		a.setName("data");
		m.addAttribute(a);
		a = new Attribute();
		a.setName("quantidade");
		m.addAttribute(a);
		a = new Attribute();
		a.setName("valor");
		m.addAttribute(a);

		/* Create a data-model */
		Map root = new HashMap();
		root.put("model", m);

		/* Get the template (uses cache internally) */
		Template temp = cfg.getTemplate("test.ftlh");

		/* Merge data-model with template */
		Writer out = new OutputStreamWriter(System.out);
		temp.process(root, out);
		// Note: Depending on what `out` is, you may need to call `out.close()`.
		// This is usually the case for file output, but not for servlet output.

		System.out.println(new GsonBuilder().setPrettyPrinting().create().toJson(m));
	}
}
