class ${model.name}Controller {
    
    constructor() {
        let $ = document.querySelector.bind(document);
	    <#list model.getBaseAttributes() as attribute>
	    this._input${attribute.name} = $("#${attribute.name}");
	    </#list>
	}
}