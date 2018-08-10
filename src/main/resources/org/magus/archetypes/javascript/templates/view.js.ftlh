class ${model.pluralName?capitalize}View extends View {

   constructor(elemento) {
        
        super(elemento);
    }
    
    template(model) {
        
        return `
        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                <#list model.attributes as attribute>
                	<td>${attribute.name}</td>
                </#list>
                </tr>
            </thead>
            <tbody>
	            ${r'${model.'}${model.pluralName}${r'.map(n'}${r' => `'?no_esc}
	            <tr>
	            <#list model.attributes as attribute>
	            <#if attribute.type == "date">
	            	<td>${r'${DateHelper.dataParaTexto(n.'}${attribute.name})}</td>
	            <#else>
	            	<td>${r'${n.'}${attribute.name}}</td>
	            </#if> 
	            </#list>
	            </tr>
	            `).join('')}
	        </tbody>
	        <tfoot>
	        	<td colspan="3"></td>
	        	<td></td>
	        </tfoot>
	    </table>

        `;
    }
}

