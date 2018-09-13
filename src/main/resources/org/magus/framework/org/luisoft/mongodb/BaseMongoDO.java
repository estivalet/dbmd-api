package org.luisoft.mongodb;

import org.bson.types.ObjectId;
import org.mongodb.morphia.annotations.Id;
import org.mongodb.morphia.annotations.Property;
import org.mongodb.morphia.annotations.Version;

public class BaseMongoDO {

	@Id
	//@Property("id")
	//private ObjectId id;
	private String id;

	@Version
	@Property("version")
	private Long version;

	public BaseMongoDO() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Long getVersion() {
		return version;
	}

	public void setVersion(Long version) {
		this.version = version;
	}

}
