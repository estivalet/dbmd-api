module.exports = {
    base: require('./base'),
    <#list app.models as model>
${model.pluralName}: require('./${model.pluralName}')
    </#list>
}