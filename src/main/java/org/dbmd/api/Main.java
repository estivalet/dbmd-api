package org.dbmd.api;

import static spark.Spark.port;
import static spark.Spark.threadPool;

public class Main {
	public static void main(String[] args) {
		port(9090);
		int maxThreads = 10;
		int minThreads = 2;
		int timeOutMillis = 30000;
		threadPool(maxThreads, minThreads, timeOutMillis);

		Api api = new Api();
		api.createRoutes();

	}
}
