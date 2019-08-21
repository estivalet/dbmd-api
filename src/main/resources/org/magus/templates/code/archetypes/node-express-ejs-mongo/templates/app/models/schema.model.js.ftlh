var mongoose = require('mongoose');
var Schema = mongoose.Schema;

<#list app.models as model>
var ${string.toCamelCase(model.name)}Schema = new Schema(
  {
<#list model.attributes as attribute>
    ${attribute.name}: { type: ${type.getJSType(attribute.type)} },
</#list>
<#list model.getReferencedModels() as refmodel>
    <#if (refmodel.multi)>
    ${string.toCamelCase(refmodel.pluralName)}: [{ type: Schema.Types.ObjectId, ref: '${refmodel.name}' }],
	<#else>
    ${string.toCamelCase(refmodel.name)}: { type: Schema.Types.ObjectId, ref: '${refmodel.name}' },
	</#if>
</#list>
  },
  {
    timestamps: true,
    toObject: { virtuals: true },
    toJSON: { virtuals: true },
    collection: '${string.toCamelCase(model.name)}'   // force to use the name, if not moongoose add "s" at the and of the collection.
  }
);

<#list model.getReferencedModels() as refmodel>
<#if (refmodel.multi)>
${string.toCamelCase(refmodel.name)}Schema.post('save', function(${string.toCamelCase(refmodel.name)}) {
  console.log(${string.toCamelCase(refmodel.name)});
  ${model.name}.findByIdAndUpdate(${string.toCamelCase(refmodel.name)}.${string.toCamelCase(model.name)}, {
    $push: {${string.toCamelCase(refmodel.pluralName)}: ${string.toCamelCase(refmodel.name)}._id}
  }, {new: true})
  .then(data => {
  });

});
</#if>
</#list>

</#list>



<#list app.models as model>
var ${model.name} = mongoose.model('${model.name}', ${string.toCamelCase(model.name)}Schema);
</#list>

module.exports = {
<#list app.models as model>
  ${model.name}: ${model.name},
</#list>  
}