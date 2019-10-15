module.exports = (app) => {
    const system = require('../controllers/system.controller.js');

	// GUI routes
    // Index page
    app.get('/system/index', system.index);

    // View detail of a single system with systemId
//    app.get('/system/:systemId/detail', system.detail);
    app.get('/system/:systemId/detail', system.detailSQLite);

    // Retrieve all system
    app.get('/system/list', system.list);

	// SERVICE routes
    // Create a new system
    app.post('/system', system.create);

    // Retrieve all system
//    app.get('/system', system.findAll);
    app.get('/system', system.findAllSQLite);

    // Retrieve a single system with systemId
    app.get('/system/:systemId', system.findOne);

    // Update a system with systemId
    app.put('/system/:systemId', system.update);

    // Update a single field of a system with systemId
	app.put('/system/:systemId/field', system.field);

    // Delete a system with systemId
    app.delete('/system/:systemId', system.delete);
}