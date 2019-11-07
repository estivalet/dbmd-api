TODOOOOOOOOOOOOOOOOOO

var fs = require('fs');
const octupus = require('../../config/octupus.config.js');

//const models = require('../models/schema.model.js');
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

exports.detailSQLite = (req, res) => {
    console.log('*******************');
    var sql = 'select s.id, s.name, s.description, m.name as manufacturer, s.country, s.year, s.type, ti.cpu, ti.coprocessor, ti.ram, ti.rom,ti.keyboard,ti.language,ti.buttons,ti.controllers,ti.built_in_games,ti.media,ti.ports,ti.size,ti.colors,ti.sound,ti.speed,ti.graphics,ti.vram,ti.text,ti.switches,ti.power,ti.peripherals,ti.batteries,ti.gun,s.price \
    from system s LEFT OUTER JOIN technical_information ti ON ti.system_id = s.id \
    JOIN manufacturer m ON m.id = s.manufacturer_id  \
    where s.id = ?';
    var params = [req.params.systemId]
    sqlite.all(sql, params, (err, rows) => {
        if (err) {
          res.status(400).json({"error":err.message});
          return;
        }
        console.log(rows);
        res.render('system/detail', {
            rows
        });
    });    
  
};

checkMediaFileAvailability = (filename, systemName, folder, extensions) => {
    for(i=0; i < extensions.length; i++) {
        //console.log(octupus.HOME + "/" + systemName + "/games/art/" + folder + "/" + filename.replace(/\.[^/.]+$/, "") + extensions[i]);
        if(fs.existsSync(octupus.HOME + "/" + systemName + "/games/art/" + folder + "/" + filename.replace(/\.[^/.]+$/, "") + extensions[i])) {
            return true;
        }
    }
    return false;
}

exports.games = (req, res) => {
    var sql = `SELECT g.id, g.name, g.rom_file_name, s.name as system_name, m.bezel, m.box3d, m.boxback, m.boxfront, m.flyer, m.ingame, m.logo, m.manual, m.marquee, m.media, m.mix2, m.mix3, m.mix4, m.title, m.video
               FROM game g
               INNER JOIN system s ON s.id = g.system_id 
               LEFT JOIN game_media m ON g.id = m.game_id 
               WHERE g.system_id = ?`;
    var params = [req.params.systemId];
    sqlite.all(sql, params, (err, rows) => {
        if (err) {
          res.status(400).json({"error":err.message});
          return;
        }
        var games=[];
        var systemName="";
        for(var i = 0; i < rows.length; i++) {
            systemName = rows[i].system_name;
            game = {
                "id": rows[i].id,
                "name": rows[i].name,
                "bezel": rows[i].bezel,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "bezel", [".png"]),
                "box3d": rows[i].box3d,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "box3d", [".png"]),
                "boxback": rows[i].boxback,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "boxback", [".png"]),
                "boxfront": rows[i].boxfront,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "boxfront", [".png"]),
                "flyer": rows[i].flyer,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "flyer", [".png"]),
                "ingame": rows[i].ingame,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "ingame", [".png"]),
                "logo": rows[i].logo,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "logo", [".png"]),
                "manual": rows[i].manual,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "manuals", [".pdf"]),
                "marquee": rows[i].marquee,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "marquee", [".png"]),
                "media": rows[i].media,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "media", [".png"]),
                "mix2": rows[i].mix2,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "mix2", [".png"]),
                "mix3": rows[i].mix3,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "mix3", [".png"]),
                "mix4": rows[i].mix4,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "mix4", [".png"]),
                "title": rows[i].title,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "title", [".png"]),
                "video": rows[i].video,//checkMediaFileAvailability(rows[i].rom_file_name, rows[i].system_name, "video", [".mp4"]),
            }
            games.push(game);
        }
        res.json({
            "message":"success",
            systemName,
            games
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

exports.fieldSQLite =  (req, res) => {
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