/** TODOOOOOOOOOOOOOOOOOO*/

var fs = require('fs');
const sqlite = require('../../config/database.config.js');


exports.index = (req, res) => {
    console.log("INDEX");
    res.render('${string.toCamelCase(model.name)}/index', { title: "${string.toCamelCase(model.name)} page" });
}


exports.list = (req, res) => {
    var sql = 'select ${model.getAttributesPrecededByModelName()} from ${string.toUnderline(model.name)} ${string.toUnderline(model.name)}';
    var params = [];
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


