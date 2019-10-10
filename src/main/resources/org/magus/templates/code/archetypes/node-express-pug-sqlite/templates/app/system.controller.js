const models = require('../models/schema.model.js');
const sqlite = require('../../config/sqlite.config.js');


exports.index = (req, res) => {
    console.log("INDEX");
    res.render('system/index', { title: "System page" });
}

// detail a single System with a id
exports.detail = (req, res) => {
    models.System.findById(req.params.systemId)
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "System not found with id " + req.params.systemId
            });            
        }
        res.render('system/detail', {
            data
        });

    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "System not found with id " + req.params.systemId
            });                
        }
        return res.status(500).send({
            message: "Error retrieving System with id " + req.params.systemId
        });
    });
};

// Retrieve and return all System from the database.
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

    const system = new models.System({
        name: req.body.name,
        manufacturer: req.body.manufacturer,
        type: req.body.type,
        country: req.body.country,
        year: req.body.year,
        description: req.body.description,
        price: req.body.price,
        technicalInformation: req.body.technicalInformation,
        adverts: req.body.adverts,
        emulators: req.body.emulators,
        links: req.body.links,
        hardware: req.body.hardware,
        shots: req.body.shots,
        
    });

    system.save()
        .then(data => {
            res.status(201).send(data);
        }).catch(err => {
            console.log("errrrrrr" +err )
            res.status(500).send(
                {   message: err.message || "Some error occurred while creating the System." }
        );
    });
    }catch(err) {
        console.log(err);
    }
};

exports.findAllSQLite = (req, res) => {
    var sql = 'select s.id, s.name, s.type, m.name as manufacturer from system s, manufacturer m where s.manufacturer_id=m.id order by s.name'
    var params = []
    sqlite.all(sql, params, (err, rows) => {
        if (err) {
          res.status(400).json({"error":err.message});
          return;
        }
        console.log(rows);
        res.json({
            "message":"success",
            "data":rows
        })
      });    
}

// Retrieve and return all countries from the database.
exports.findAll = (req, res) => {
    var perPage = 10;
    var page = req.query.page;

    // if a number of page is passed as a parameter use it, otherwise list all.
    if(page) {
        models.System.find({})
        .sort({'name': 1})
        .skip((perPage * page) - perPage)
        .limit(perPage)
        .exec(function(err, data) {
            models.System.countDocuments().exec(function(err, count) {
                
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
        models.System.find()

        .then(data => {
            console.log(data);
            res.send(data);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving System."
            });
        });        
    }
};

// Find a single System with a id
exports.findOne = (req, res) => {
    models.System.findById(req.params.systemId)
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "System not found with id " + req.params.systemId
            });            
        }
        res.send(data);
    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "System not found with id " + req.params.systemId
            });                
        }
        return res.status(500).send({
            message: "Error retrieving System with id " + req.params.systemId
        });
    });
};

// Update a System identified by the SystemId in the request
exports.update = (req, res) => {
    // Find note and update it with the request body
    models.System.findByIdAndUpdate(req.params.systemId, {
        name: req.body.name,
        manufacturer: req.body.manufacturer,
        type: req.body.type,
        country: req.body.country,
        year: req.body.year,
        description: req.body.description,
        price: req.body.price,
        technicalInformation: req.body.technicalInformation,
        adverts: req.body.adverts,
        emulators: req.body.emulators,
        links: req.body.links,
        hardware: req.body.hardware,
        shots: req.body.shots,
    }, {new: true})
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "System not found with id " + req.params.systemId
            });
        }
        res.status(200).send(data);
    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "System not found with id " + req.params.systemId
            });                
        }
        return res.status(500).send({
            message: "Error updating System with id " + req.params.systemId
        });
    });
};

// Update a single field
exports.field =  (req, res) => {
    var update = {};
    update[req.body.field] = req.body.value ;

    models.System.findByIdAndUpdate(req.params.systemId, {
         $set: update ,
    }, {new: true})
    .then(data => {
        if(!data) {
            return res.status(404).send({
                message: "System not found with id " + req.params.systemId
            });
        }
        res.status(200).send(data);
    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "System not found with id " + req.params.systemId
            });                
        }
        return res.status(500).send({
            message: "Error updating System with id " + req.params.systemId
        });
    });
        
};


// Delete a System with the specified SystemId in the request
exports.delete = (req, res) => {
    models.System.findByIdAndRemove(req.params.systemId)
        .then(data => {
            if(!data) {
                return res.status(404).send({
                    message: "System not found with id " + req.params.systemId
                });
            }
            res.status(200).send({message: "System deleted successfully!"});
        }).catch(err => {
            if(err.kind === 'ObjectId' || err.name === 'NotFound') {
                return res.status(404).send({
                    message: "System not found with id " + req.params.systemId
                });                
            }
            return res.status(500).send({
                message: "Could not delete System with id " + req.params.systemId
            });
    });
};