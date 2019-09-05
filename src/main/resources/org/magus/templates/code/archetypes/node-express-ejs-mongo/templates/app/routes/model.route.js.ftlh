module.exports = (app) => {
    const ${string.toCamelCase(model.name)} = require('../controllers/${string.toCamelCase(model.name)}.controller.js');

	// GUI routes
    // Index page
    app.get('/${string.toCamelCase(model.name)}/index', ${string.toCamelCase(model.name)}.index);

    // View detail of a single ${string.toCamelCase(model.name)} with ${string.toCamelCase(model.name)}Id
    app.get('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}Id/detail', ${string.toCamelCase(model.name)}.detail);

    // Retrieve all ${string.toCamelCase(model.name)}
    app.get('/${string.toCamelCase(model.name)}/list', ${string.toCamelCase(model.name)}.list);

	// SERVICE routes
    // Create a new ${string.toCamelCase(model.name)}
    app.post('/${string.toCamelCase(model.name)}', ${string.toCamelCase(model.name)}.create);

    // Retrieve all ${string.toCamelCase(model.name)}
    app.get('/${string.toCamelCase(model.name)}', ${string.toCamelCase(model.name)}.findAll);

    // Retrieve a single ${string.toCamelCase(model.name)} with ${string.toCamelCase(model.name)}Id
    app.get('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}Id', ${string.toCamelCase(model.name)}.findOne);

    // Update a ${string.toCamelCase(model.name)} with ${string.toCamelCase(model.name)}Id
    app.put('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}Id', ${string.toCamelCase(model.name)}.update);

    // Update a single field of a ${string.toCamelCase(model.name)} with ${string.toCamelCase(model.name)}Id
	app.put('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}Id/field', ${string.toCamelCase(model.name)}.field);

    // Delete a ${string.toCamelCase(model.name)} with ${string.toCamelCase(model.name)}Id
    app.delete('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}Id', ${string.toCamelCase(model.name)}.delete);
}