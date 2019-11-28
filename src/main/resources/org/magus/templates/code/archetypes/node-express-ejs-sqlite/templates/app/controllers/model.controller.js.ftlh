/** TODOOOOOOOOOOOOOOOOOO*/

var fs = require('fs');
const sqlite = require('../../config/database.config.js');


exports.index = (req, res) => {
    res.render('${string.toCamelCase(model.name)}/index', { title: "${string.toCamelCase(model.name)} page" });
}


exports.list = (req, res) => {
    var params = [];

    var sql = 'SELECT id, ${model.getAttributesPrecededByModelName()} FROM ${string.toUnderline(model.name)} ${string.toUnderline(model.name)} ';
    if (req.query.search == 'true') {
    <#list model.attributes as attribute>
	<#if (attribute.searchBy == true)>	
	    if(req.query.${attribute.name}) {
	<#if (attribute?index == 0)>
			sql += 'WHERE ';
	</#if>
	<#if (attribute?index == 0)>
			sql += '${string.toUnderline(attribute.name)} LIKE ? ';
			params.push(req.query.${attribute.name} + '%');
	<#else>
			sql += 'AND ${string.toUnderline(attribute.name)} LIKE ? ';
			params.push(req.query.${attribute.name} + '%');
	</#if>
    	}
	</#if>
    </#list>
    }
    sql += 'ORDER BY ${model.getFirstOrderByAttributeName()}';
    
    sqlite.all(sql, params, (err, rows) => {
        if (err) {
			res.status(400).json({"error":err.message});
            return;
        }
        res.status(200).json({
            "message":"success",
            "data":rows
        })
	});    
}

exports.create = (req, res) => {
    var sql = 'INSERT INTO ${string.toUnderline(model.name)} (${model.getAttributesCommaSeparated()}) VALUES (${model.getAttributesReplacedBy("?")})';
 	var params = [];
 	
    <#list model.attributes as attribute>
    params.push(req.body.${attribute.name});
    </#list>
    <#list model.getRefModels() as refmodel>
    params.push(req.body.${string.toUnderline(refmodel.name)}_id);
    </#list>
 	
 	sqlite.run(sql, params, function(err) {
    	if (err) {
		    res.status(400).json({
				"message":"ERROR:" + err.message,
		    });
    	}
	   
	    res.status(201).json({
			"message":"success",
	    });
    	
	}); 
};

exports.delete = (req, res) => {
    var sql = 'DELETE FROM ${string.toUnderline(model.name)} WHERE id = ?';
 	var params = [];
 	
 	params.push(req.params.${string.toCamelCase(model.name)}_id);
 	
 	sqlite.run(sql, params, function(err) {
    	if (err) {
		    res.status(400).json({
				"message":"ERROR:" + err.message,
		    });
    	}
	   
	    res.status(200).json({
			"message":"Record deleted",
	    });
    	
	}); 
};

exports.update = (req, res) => {
    var sql = 'UPDATE ${string.toUnderline(model.name)} SET ${model.getAttributesEquals('?')} WHERE id = ?';
 	var params = [];
 	
    <#list model.attributes as attribute>
    params.push(req.body.${attribute.name});
    </#list>
    <#list model.getRefModels() as refmodel>
    params.push(req.body.${string.toUnderline(refmodel.name)}_id);
    </#list>
 	params.push(req.params.${string.toCamelCase(model.name)}_id);
 	
 	sqlite.run(sql, params, function(err) {
    	if (err) {
		    res.status(400).json({
				"message":"ERROR:" + err.message,
		    });
    	}
	   
	    res.status(200).json({
			"message":"success",
	    });
    	
	}); 
};

exports.findOne = (req, res) => {
    var sql = 'SELECT id, ${model.getAttributesCommaSeparated()} FROM ${string.toUnderline(model.name)} ${string.toUnderline(model.name)} WHERE id = ?';
    var params = [];
    
 	var params = [];
 	params.push(req.params.${string.toCamelCase(model.name)}_id);
    
    sqlite.all(sql, params, (err, rows) => {
        if (err) {
			res.status(400).json({"error":err.message});
            return;
        }
        res.status(200).json({
            "message":"success",
            "data":rows
        })
	});    
};
