var mongoose = require('mongoose');
var Schema = mongoose.Schema;

<#list app.models as model>
var ${string.toCamelCase(model.name)}Schema = new Schema(
  {
<#list model.attributes as attribute>
    ${attribute.name}: { type: ${type.getJSType(attribute.type)} },
</#list>
  },
  {
    timestamps: true,
    toObject: { virtuals: true },
    toJSON: { virtuals: true }
  }
);
</#list>

<#list app.models as model>
var ${model.name} = mongoose.model('${model.name}', ${string.toCamelCase(model.name)}Schema);
</#list>

module.exports = {
<#list app.models as model>
  ${model.name}: ${model.name},
</#list>  
}