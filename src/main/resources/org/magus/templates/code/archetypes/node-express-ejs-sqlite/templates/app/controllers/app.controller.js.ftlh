var request = require('request');
var async = require('async');

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