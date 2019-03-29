const ${model.name}Controlador = require('../controladores/${string.toCamelCase(model.name)}-controlador');
const ${string.toCamelCase(model.name)}Controlador = new ${model.name}Controlador();

const ${model.name} = require('../modelos/${string.toCamelCase(model.name)}');

module.exports = (app) => {
    const rotas${model.name} = ${model.name}Controlador.rotas();
    
    app.get(rotas${model.name}.lista, ${string.toCamelCase(model.name)}Controlador.lista());

    app.route(rotas${model.name}.cadastro)
        .get(${string.toCamelCase(model.name)}Controlador.formularioCadastro())
        .post(${model.name}.validacoes(), ${string.toCamelCase(model.name)}Controlador.cadastra())
        .put(${string.toCamelCase(model.name)}Controlador.edita());

    app.get(rotas${model.name}.edicao, ${string.toCamelCase(model.name)}Controlador.formularioEdicao());

    app.delete(rotas${model.name}.delecao, ${string.toCamelCase(model.name)}Controlador.remove());
};