var sqlite3 = require('sqlite3').verbose();
var md5 = require('md5');

const DBSOURCE = '${app.databaseName}.db';

let sqlite = new sqlite3.Database(DBSOURCE, (err) => {
	if (err) {
		console.error(err.message);
  		throw err;
    } else {
        console.log('Connected to the SQLite ${app.databaseName} database.');
    }
});


module.exports = sqlite
