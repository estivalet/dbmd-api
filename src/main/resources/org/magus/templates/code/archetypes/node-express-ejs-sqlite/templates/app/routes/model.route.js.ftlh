/** TODOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/


module.exports = (app) => {
    const ${string.toCamelCase(model.name)} = require('../controllers/${string.toCamelCase(model.name)}.controller.js');

    app.get('/${string.toCamelCase(model.name)}/index', ${string.toCamelCase(model.name)}.index);
    app.get('/${string.toCamelCase(model.name)}', ${string.toCamelCase(model.name)}.list);
    app.post('/${string.toCamelCase(model.name)}', ${string.toCamelCase(model.name)}.create);

}