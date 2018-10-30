const models = require('../models/schema.model.js');

exports.index = (req, res) => {
    console.log("INDEX");
    res.render('${string.toCamelCase(model.name)}/index', { title: "${model.name} page" });
}

exports.create = (req, res) => {
    try {

    // Create a genre.
    const ${string.toCamelCase(model.name)} = new models.${string.toCamelCase(model.name, true)}({
        name: req.body.name
    });

    // Save a genre in the database.
    ${string.toCamelCase(model.name)}.save()
        .then(data => {
            res.send(data);
        }).catch(err => {
            console.log("errrrrrr" +err )
            res.status(500).send(
                {   message: err.message || "Some error occurred while creating the Country." }
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

    // if a number of page is passed as a parameter use it, otherwise list all genres.
    if(page) {
        models.${string.toCamelCase(model.name, true)}.find({})
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
        .then(data => {
            res.send(data);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving genres."
            });
        });        
    }
};

// Find a single country with a countryId
exports.findOne = (req, res) => {
    models.${string.toCamelCase(model.name, true)}.findById(req.params.${string.toCamelCase(model.name)}Id)
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "genre not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });            
        }
        res.send(data);
    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "genre not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });                
        }
        return res.status(500).send({
            message: "Error retrieving genre with id " + req.params.${string.toCamelCase(model.name)}Id
        });
    });
};

// Update a country identified by the countryId in the request
exports.update = (req, res) => {
    // Find note and update it with the request body
    models.${string.toCamelCase(model.name, true)}.findByIdAndUpdate(req.params.${string.toCamelCase(model.name)}Id, {
        name: req.body.name
    }, {new: true})
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "genre not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });
        }
        res.send(data);
    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "genre not found with id " + req.params.${string.toCamelCase(model.name)}Id
            });                
        }
        return res.status(500).send({
            message: "Error updating genre with id " + req.params.${string.toCamelCase(model.name)}Id
        });
    });
};

// Delete a country with the specified countryId in the request
exports.delete = (req, res) => {
    models.${string.toCamelCase(model.name, true)}.findByIdAndRemove(req.params.${string.toCamelCase(model.name)}Id)
        .then(data => {
            if(!data) {
                return res.status(404).send({
                    message: "genre not found with id " + req.params.${string.toCamelCase(model.name)}Id
                });
            }
            res.send({message: "genre deleted successfully!"});
        }).catch(err => {
            if(err.kind === 'ObjectId' || err.name === 'NotFound') {
                return res.status(404).send({
                    message: "genre not found with id " + req.params.${string.toCamelCase(model.name)}Id
                });                
            }
            return res.status(500).send({
                message: "Could not delete genre with id " + req.params.${string.toCamelCase(model.name)}Id
            });
    });
};