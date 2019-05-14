var mongoose = require('mongoose');
var Schema = mongoose.Schema;

<#list app.models as model>
var ${string.toCamelCase(model.name)}Schema = new Schema(
  {
<#list model.attributes as attribute>
    ${attribute.name}: { type: ${type.getJSType(attribute.type)} },
</#list>
<#list model.getReferencedAttributes() as refattr>
    ${string.toCamelCase(refattr.model)}:{ type: Schema.Types.ObjectId, ref: '${refattr.model}' },
</#list>
  },
  {
    timestamps: true,
    toObject: { virtuals: true },
    toJSON: { virtuals: true },
    collection: '${string.toCamelCase(model.name)}'   // force to use the name, if not moongoose add "s" at the and of the collection.
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