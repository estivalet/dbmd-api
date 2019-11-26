/** TODOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/


module.exports = (app, authFn) => {
    const ${string.toCamelCase(model.name)} = require('../controllers/${string.toCamelCase(model.name)}.controller.js');

    app.get('/${string.toCamelCase(model.name)}/index', authFn(), ${string.toCamelCase(model.name)}.index);
    app.get('/${string.toCamelCase(model.name)}', authFn(), ${string.toCamelCase(model.name)}.list);
    app.post('/${string.toCamelCase(model.name)}', authFn(), ${string.toCamelCase(model.name)}.create);
    app.delete('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}_id', authFn(), ${string.toCamelCase(model.name)}.delete);
    app.get('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}_id', authFn(), ${string.toCamelCase(model.name)}.findOne);
    app.put('/${string.toCamelCase(model.name)}/:${string.toCamelCase(model.name)}_id', authFn(), ${string.toCamelCase(model.name)}.update);

}