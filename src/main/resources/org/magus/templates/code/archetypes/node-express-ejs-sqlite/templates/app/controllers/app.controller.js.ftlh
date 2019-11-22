var request = require('request');
var async = require('async');

const sqlite = require('../../config/database.config.js');

/**
 * Gets all necessary data to show in the index page.
 * @param {*} req 
 * @param {*} res 
 */
exports.index = function(req, res) {
	res.render('index', {
	    title: "${app.shortName}"
    });
};

exports.register = function(req, res) {
	res.render('register', {
	    title: "${app.shortName}"
    });
};

exports.login = function(req, res) {
	res.render('login', {
	    title: "${app.shortName}"
    });
};

exports.registerNewUser = function(req, res) {
    var sql = 'INSERT INTO user (name, email, password) VALUES (?, ?, ?)';
 	var params = [];
 	
    params.push(req.body.email);
    params.push(req.body.email);
    params.push(req.body.password);
 	
 	sqlite.run(sql, params, function(err) {
    	if (err) {
		    res.status(400).json({
				"message":"ERROR:" + err.message,
		    });
    	}
	   
		res.render('index', {
		    title: "${app.shortName}",
		    message: "Welcome to ${app.shortName}"
	    });
    	
	}); 

};