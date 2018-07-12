class ${model.name} {
    constructor(${model.getAttributesCommaSeparated()}) {
    <#list model.attributes as attribute>
        this._${attribute.name} = ${attribute.name}; 
    </#list>
    }
    
    <#list model.attributes as attribute>
    get ${attribute.name}() {
        return this._${attribute.name};
    }
    
    </#list>
}
