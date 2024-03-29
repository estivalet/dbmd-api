const models = require('../models/schema.model.js');

exports.index = (req, res) => {
    console.log("INDEX");
    res.render('${string.toCamelCase(model.name)}/index', { title: "${model.name} page" });
}

// detail a single ${model.name} with a id
exports.detail = (req, res) => {
    models.${string.toCamelCase(model.name, true)}.findById(req.params.${string.toCamelCase(model.name)}Id)
    <#list model.getReferencedModels() as refmodel>
    <#if (refmodel.multi)>
    .populate('${string.toCamelCase(refmodel.pluralName)}')
    <#else>
    .populate('${string.toCamelCase(refmodel.name)}')
    </#if>
    </#list>
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });            
        }
        res.render('${string.toCamelCase(model.name)}/detail', {
            data
        });

    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });                
        }
        return res.status(500).send({
            message: "Error retrieving ${model.name} with id " + req.params.${string.toCamelCase(model.name)}Id
        });
    });
};

// Retrieve and return all ${model.name} from the database.
// TODO Very specific need to generalize
exports.list = (req, res) => {
    models.System.aggregate([
        {
            $sort: {name:1}
        },
        {
            $group: {
                _id: '$type',
                count: {$sum: 1},
                entry: {
                    $push: {
                      name: "$name",
                    },
                },
            },
        },
        {
            $sort: {_id: 1}
            
        }
        
    ], function (err, result) {
        if (err) {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving System."
            });
        } else {
            console.log(result);
            res.render('system/list', {
                result
            });
        }
    });
};

exports.create = (req, res) => {
    try {

    const ${string.toCamelCase(model.name)} = new models.${string.toCamelCase(model.name, true)}({
        <#list model.attributes as attribute>
        ${attribute.name}: req.body.${attribute.name},
        </#list>
		<#list model.getReferencedAttributes() as refattr>
		${string.toCamelCase(refattr.model)}: req.body.${string.toCamelCase(refattr.model)}Id,
		</#list>
        
    });

    ${string.toCamelCase(model.name)}.save()
        .then(data => {
            res.status(201).send(data);
        }).catch(err => {
            console.log("errrrrrr" +err )
            res.status(500).send(
                {   message: err.message || "Some error occurred while creating the ${model.name}." }
        );
    });
    }catch(err) {
        console.log(err);
    }
};

// Retrieve and return all countries from the database.
exports.findAll = (req, res) => {
    var perPage = 10;
    var page = req.query.page;

    // if a number of page is passed as a parameter use it, otherwise list all.
    if(page) {
        models.${string.toCamelCase(model.name, true)}.find({})
        <#list model.getReferencedModels() as refmodel>
        <#if (refmodel.multi)>
        .populate('${string.toCamelCase(refmodel.pluralName)}')
        <#else>
        .populate('${string.toCamelCase(refmodel.name)}')
        </#if>
        </#list>
        .sort({'name': 1})
        .skip((perPage * page) - perPage)
        .limit(perPage)
        .exec(function(err, data) {
            models.${string.toCamelCase(model.name, true)}.countDocuments().exec(function(err, count) {
                
                if(err) return next(err);
                
                result = {
                    data: data,
                    current: page,
                    pages: Math.ceil(count / perPage)
                };
                console.log("SENDING RESULT-->" + result);
                res.send(result);
            })
        });
    } else {
        models.${string.toCamelCase(model.name, true)}.find()
        <#list model.getRefModels() as refmodel>
	    <#if (refmodel.visibleInList)>
	    <#list refmodel.getModel().getAttributes() as refmodelattr>
	    <#if (refmodelattr.referencedVisible)>
    		.populate({ path: '${string.toCamelCase(refmodel.name)}', select: '${string.toCamelCase(refmodelattr.name)}'})
	    </#if>
		</#list>
	    </#if>
    	</#list>

        .then(data => {
            res.send(data);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving ${model.name}."
            });
        });        
    }
};

// Find a single ${model.name} with a id
exports.findOne = (req, res) => {
    models.${string.toCamelCase(model.name, true)}.findById(req.params.${string.toCamelCase(model.name)}Id)
    <#list model.getReferencedModels() as refmodel>
    <#if (refmodel.multi)>
    .populate('${string.toCamelCase(refmodel.pluralName)}')
    <#else>
    .populate('${string.toCamelCase(refmodel.name)}')
    </#if>
    </#list>
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });            
        }
        res.send(data);
    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });                
        }
        return res.status(500).send({
            message: "Error retrieving ${model.name} with id " + req.params.${string.toCamelCase(model.name)}Id
        });
    });
};

// Update a ${model.name} identified by the ${model.name}Id in the request
exports.update = (req, res) => {
    // Find note and update it with the request body
    models.${string.toCamelCase(model.name, true)}.findByIdAndUpdate(req.params.${string.toCamelCase(model.name)}Id, {
        <#list model.attributes as attribute>
        ${attribute.name}: req.body.${attribute.name},
        </#list>
		<#list model.getReferencedAttributes() as refattr>
		${string.toCamelCase(refattr.model)}: req.body.${string.toCamelCase(refattr.model)}Id,
		</#list>
    }, {new: true})
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });
        }
        res.status(200).send(data);
    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });                
        }
        return res.status(500).send({
            message: "Error updating ${model.name} with id " + req.params.${string.toCamelCase(model.name)}Id
        });
    });
};

// Update a single field
exports.field =  (req, res) => {
    var update = {};
    update[req.body.field] = req.body.value ;

    models.${string.toCamelCase(model.name, true)}.findByIdAndUpdate(req.params.${string.toCamelCase(model.name)}Id, {
         $set: update ,
    }, {new: true})
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });
        }
        res.status(200).send(data);
    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });                
        }
        return res.status(500).send({
            message: "Error updating ${model.name} with id " + req.params.${string.toCamelCase(model.name)}Id
        });
    });
        
};


// Delete a ${model.name} with the specified ${model.name}Id in the request
exports.delete = (req, res) => {
    models.${string.toCamelCase(model.name, true)}.findByIdAndRemove(req.params.${string.toCamelCase(model.name)}Id)
        .then(data => {
            if(!data) {
                return res.status(404).send({
                    message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
                });
            }
            res.status(200).send({message: "${model.name} deleted successfully!"});
        }).catch(err => {
            if(err.kind === 'ObjectId' || err.name === 'NotFound') {
                return res.status(404).send({
                    message: "${model.name} not found with id " + req.params.${string.toCamelCase(model.name)}Id
                });                
            }
            return res.status(500).send({
                message: "Could not delete ${model.name} with id " + req.params.${string.toCamelCase(model.name)}Id
            });
    });
};