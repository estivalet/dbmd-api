const ${model.name} = require('../models').${model.name};

module.exports = {
  list(req, res) {
    return ${model.name}
      .findAll({
       
      })
      .then((${model.pluralName}) => res.status(200).send(${model.pluralName}))
      .catch((error) => { res.status(400).send(error); });
  },

  getById(req, res) {
    return ${model.name}
      .findById(req.params.id, {
      })
      .then((${string.toCamelCase(model.name)}) => {
        if (!${string.toCamelCase(model.name)}) {
          return res.status(404).send({
            message: '${model.pluralName} Not Found',
          });
        }
        return res.status(200).send(${string.toCamelCase(model.name)});
      })
      .catch((error) => res.status(400).send(error));
  },

  add(req, res) {
    return ${model.name}
      .create({
      	<#list model.attributes as attribute>
        ${attribute.name}: req.body.${attribute.name},
        </#list>
      })
      .then((${string.toCamelCase(model.name)}) => res.status(201).send(${string.toCamelCase(model.name)}))
      .catch((error) => res.status(400).send(error));
  },

  update(req, res) {
    return ${model.name}
      .findById(req.params.id, {
       
      })
      .then(${string.toCamelCase(model.name)} => {
        if (!${string.toCamelCase(model.name)}) {
          return res.status(404).send({
            message: '${model.name} Not Found',
          });
        }
        return ${string.toCamelCase(model.name)}
          .update({
          	<#list model.attributes as attribute>
            ${attribute.name}: req.body.${attribute.name} || ${string.toCamelCase(model.name)}.${attribute.name},
            </#list>
          })
          .then(() => res.status(200).send(${string.toCamelCase(model.name)}))
          .catch((error) => res.status(400).send(error));
      })
      .catch((error) => res.status(400).send(error));
  },

  delete(req, res) {
    return ${model.name}
      .findById(req.params.id)
      .then(${string.toCamelCase(model.name)} => {
        if (!${string.toCamelCase(model.name)}) {
          return res.status(400).send({
            message: '${model.name} Not Found',
          });
        }
        return ${string.toCamelCase(model.name)}
          .destroy()
          .then(() => res.status(204).send())
          .catch((error) => res.status(400).send(error));
      })
      .catch((error) => res.status(400).send(error));
  },
};
