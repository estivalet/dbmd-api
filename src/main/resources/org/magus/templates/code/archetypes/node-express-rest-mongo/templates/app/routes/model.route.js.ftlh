module.exports = (app) => {
    const ${string.toCamelCase(model.name)} = require('../controllers/${string.toCamelCase(model.name)}.controller.js');

    // Index page
    app.get('/${string.toCamelCase(model.name)}/index', ${string.toCamelCase(model.name)}.index);

    // Create a new ${string.toCamelCase(model.name)}
    app.post('/${string.toCamelCase(model.name)}', ${string.toCamelCase(model.name)}.create);

    // Retrieve all ${string.toCamelCase(model.name)}
    app.get('/${string.toCamelCase(model.pluralName)}', ${string.toCamelCase(model.name)}.findAll);

    // Retrieve a single ${string.toCamelCase(model.name)} with ${string.toCamelCase(model.name)}Id
    app.get('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}Id', ${string.toCamelCase(model.name)}.findOne);

    // Update a ${string.toCamelCase(model.name)} with ${string.toCamelCase(model.name)}Id
    app.put('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}Id', ${string.toCamelCase(model.name)}.update);

    // Delete a ${string.toCamelCase(model.name)} with ${string.toCamelCase(model.name)}Id
    app.delete('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}Id', ${string.toCamelCase(model.name)}.delete);
}