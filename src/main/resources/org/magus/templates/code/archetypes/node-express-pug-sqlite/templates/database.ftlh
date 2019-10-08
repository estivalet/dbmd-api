<#-- For each model create a correspoding database table -->
CREATE TABLE IF NOT EXISTS ${string.toUnderline(model.name?lower_case)} (
	id INTEGER PRIMARY KEY,
<#list model.attributes as attribute>
<#if attribute.type == "text">
    ${string.toUnderline(attribute.name)} TEXT<#if attribute.required> NOT NULL</#if>,
</#if>
</#list>
);

<#-- 
For each set of subattributes of a model create a correspoding database table 
and create a foreign key to the base table.
-->
<#list model.attributes as attribute>
<#if attribute.type == "subattributes">
CREATE TABLE IF NOT EXISTS ${string.toUnderline(attribute.name)} (
	id INTEGER PRIMARY KEY,
	${string.toUnderline(model.name?lower_case)}_id INTEGER,
<#list attribute.attributes as subattribute>
<#if subattribute.type == "text">
    ${string.toUnderline(subattribute.name)} TEXT<#if subattribute.required> NOT NULL</#if>,
</#if>
</#list>
	FOREIGN KEY (${string.toUnderline(model.name?lower_case)}_id) REFERENCES ${string.toUnderline(model.name?lower_case)} (id) 
);
</#if>
</#list>

<#-- For each attribute of a model that has type array create a correspoding database table -->
<#list model.attributes as attribute>
<#if attribute.type == "array">
CREATE TABLE IF NOT EXISTS ${string.toUnderline(attribute.name)} (
	id INTEGER PRIMARY KEY,
	${string.toUnderline(model.name?lower_case)}_id INTEGER,
	FOREIGN KEY (${string.toUnderline(model.name?lower_case)}_id) REFERENCES ${string.toUnderline(model.name?lower_case)} (id) 
);
</#if>
</#list>
