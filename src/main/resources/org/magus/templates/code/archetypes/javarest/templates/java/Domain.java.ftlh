<#include "/common/license.ftlh">

package ${app.shortName}.domain;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

import org.mongodb.morphia.annotations.Entity;

import org.luisoft.mongodb.BaseMongoDO;

import java.util.*;

@SuppressWarnings("serial")
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
@Entity("${string.toCamelCase(model.name)}")
public class ${model.name} extends BaseMongoDO implements Serializable, Cloneable {
    <#list model.attributes as attribute>
    private ${type.getJavaType(attribute.type)} ${attribute.name};
	</#list>
	
	<#list model.attributes as attribute>
    /**
     * @param ${attribute.name}
     *            the ${attribute.name} to set.
     */	
	public void set${string.toCamelCase(attribute.name,true)}(${type.getJavaType(attribute.type)} ${attribute.name}) {
		this.${attribute.name} = ${attribute.name};
	}
	
    /**
     * @return the ${attribute.name}
     */	
	public ${type.getJavaType(attribute.type)} get${string.toCamelCase(attribute.name,true)}() {
		return this.${attribute.name};
	}
	
	</#list>
}