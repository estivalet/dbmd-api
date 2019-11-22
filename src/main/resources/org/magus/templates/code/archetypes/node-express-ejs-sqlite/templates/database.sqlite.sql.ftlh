<#list app.models as model>
<#-- For each model create a correspoding database table -->
CREATE TABLE IF NOT EXISTS ${string.toUnderline(model.name)} (
	id INTEGER PRIMARY KEY,
<#list model.attributes as attribute>
<#if attribute.type == "text">
    ${string.toUnderline(attribute.name)} TEXT<#if attribute.required> NOT NULL</#if>,
</#if>
<#if attribute.type == "email">
    ${string.toUnderline(attribute.name)} TEXT<#if attribute.required> NOT NULL</#if>,
</#if>
<#if attribute.type == "date">
    ${string.toUnderline(attribute.name)} TEXT<#if attribute.required> NOT NULL</#if>,
</#if>
<#if attribute.type == "radio">
    ${string.toUnderline(attribute.name)} TEXT<#if attribute.required> NOT NULL</#if>,
</#if>
<#if attribute.type == "textarea">
    ${string.toUnderline(attribute.name)} TEXT<#if attribute.required> NOT NULL</#if>,
</#if>
<#if attribute.type == "checkbox">
    ${string.toUnderline(attribute.name)} TEXT<#if attribute.required> NOT NULL</#if>,
</#if>
</#list>
<#list model.refModels as refModel>
	${string.toUnderline(refModel.name)}_id INTEGER,
</#list>
<#list model.refModels as refModel>
	FOREIGN KEY (${string.toUnderline(refModel.name)}_id) REFERENCES ${string.toUnderline(refModel.name)} (id), 
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
</#list>

<#-- Create unique indexes -->
<#list app.models as model>
<#-- For each model create a correspoding database table -->
<#list model.attributes as attribute>
<#if attribute.unique>
CREATE UNIQUE INDEX idx_${string.toUnderline(model.name)}_${string.toUnderline(attribute.name)}
ON ${string.toUnderline(model.name)} (${string.toUnderline(attribute.name)});
</#if>
</#list>
</#list>

