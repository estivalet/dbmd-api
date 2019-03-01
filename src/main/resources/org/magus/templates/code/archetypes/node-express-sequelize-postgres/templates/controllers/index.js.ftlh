<#list app.models as model>
const ${string.toCamelCase(model.name)} = require('./${string.toCamelCase(model.name)}');
</#list>


module.exports = {
<#list app.models as model>
	${string.toCamelCase(model.name)},
</#list>  
};
