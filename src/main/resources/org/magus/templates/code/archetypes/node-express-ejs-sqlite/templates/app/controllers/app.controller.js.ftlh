var request = require('request');
var async = require('async');

const bcryptjs = require('bcryptjs');
const sqlite = require('../../config/database.config.js');

/**
 * Gets all necessary data to show in the index page.
 * @param {*} req 
 * @param {*} res 
 */
exports.index = function(req, res) {
	if(req.session.user_id) {
		res.render('index', {
			title: "${app.shortName}"
		});
	} else {
		res.render('login', {
			title: "${app.shortName}"
		});
			
	}
};

exports.register = function(req, res) {
	res.render('register', {
	    title: "${app.shortName}",
		message: ''
    });
};

exports.login = function(req, res) {
	res.render('login', {
	    title: "${app.shortName}"
    });
};

exports.executeLogin = function(req, res) {
    var sql = 'select id, name, password from user where email = ?';
	var params = [];

	params.push(req.body.email);

    sqlite.all(sql, params, (err, rows) => {
        if (err) {
			res.status(400).json({"error":err.message});
            return;
		}
		if(rows[0]) {
			bcryptjs.compare(req.body.password, rows[0].password, (err, isValid) => {
				console.log(rows);
				if (isValid) {
					req.session.user_id = rows[0].id;
					req.session.user_name = rows[0].name;
					res.locals.user = req.session.user_name;
					res.render('index', {
						title: "contactsapp"
					});
				} else {
					res.redirect('/');		
				}
			});
		} else {
			res.redirect('/');		
		}
		
	});    
	
}

exports.registerNewUser = function(req, res) {
    var sql = 'INSERT INTO user (name, email, password) VALUES (?, ?, ?)';
 	var params = [];
	 
	const cryptPwd = bcryptjs.hashSync(req.body.password, 10)	 

    params.push(req.body.username);
    params.push(req.body.email);
    params.push(cryptPwd);
 	
 	sqlite.run(sql, params, function(err) {
    	if (err) {
			if(err.code == 'SQLITE_CONSTRAINT') {
				res.status(400).render('register', {
					message: "Usuário já existente!"
				});
			}
    	} else {
			res.status(201).render('login', {
				title: "contactsapp",
				message: "Welcome to contactsapp"
			});
		}
	}); 

};

exports.logout = function(req, res) {
	req.session.destroy();
	res.redirect('/');	
}
