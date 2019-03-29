<#list app.models as model>
const ${string.toCamelCase(model.name)}Rotas = require('./${string.toCamelCase(model.name)}-rotas');
</#list>
const baseRotas = require('./base-rotas');

module.exports = (app) => {
    baseRotas(app);
    <#list app.models as model>
    ${string.toCamelCase(model.name)}Rotas(app);
    </#list>
};