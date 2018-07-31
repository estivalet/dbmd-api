<#ftl output_format="plainText">
class ${model.name} {

    constructor(${model.getAttributesCommaSeparatedWithDefaultValue()}) {
    <#list model.attributes as attribute>
        <#if attribute.type != "formula">
            <#if attribute.type == "date">
        this._${attribute.name} = new Date(${attribute.name}.getTime());
            <#else>
        this._${attribute.name} = ${attribute.name};
            </#if> 
        </#if> 
    </#list>
    	<#if model.imutable>
        Object.freeze(this);
        </#if>
    }
    
    <#list model.attributes as attribute>
    get ${attribute.name}() {
        <#if attribute.type == "date">
        return new Date(this._${attribute.name}.getTime());
        <#elseif attribute.type == "formula">
        return ${attribute.value};
        <#else>
        return this._${attribute.name};
        </#if> 
    }
    
    set ${attribute.name}(${attribute.name}) {
    	this._${attribute.name} = ${attribute.name};
    }
    </#list>
}
