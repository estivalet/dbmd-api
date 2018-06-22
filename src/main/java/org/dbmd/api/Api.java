package org.dbmd.api;

import static spark.Spark.get;
import static spark.Spark.halt;
import static spark.Spark.path;

import org.dbmd.model.Table;

import com.google.gson.Gson;

public class Api {

	public void createRoutes() {
		path("/api", () -> {
			path("/table", () -> {
				get("/:name", (request, response) -> {
					try {
						response.type("application/json");
						Table t = new Table();
						t.setName("tabela_y");
						return new Gson().toJson(t);
					} catch (Exception e) {
						e.printStackTrace();
						halt(500, e.getMessage());
					}
					return null;
				});
				get("/columns/list/all", (request, response) -> {
					try {
						response.type("application/json");
						return new Gson().toJson("{'msg':'all columns'}");
					} catch (Exception e) {
						e.printStackTrace();
						halt(500, e.getMessage());
					}
					return null;
				});
			});
		});
	}

}
