const ${model.name}Controlador = require('../controladores/${string.toCamelCase(model.name)}-controlador');
const ${string.toCamelCase(model.name)}Controlador = new ${model.name}Controlador();

const ${model.name} = require('../modelos/${string.toCamelCase(model.name)}');

const BaseControlador = require('../controladores/base-controlador');

module.exports = (app) => {
    const rotas${model.name} = ${model.name}Controlador.rotas();
    
    app.use(rotas${model.name}.autenticadas, function(req, resp, next) {
        if (req.isAuthenticated()) {
            next();
        } else {
            resp.redirect(BaseControlador.rotas().login);
        }
    });
   
    app.get(rotas${model.name}.lista, ${string.toCamelCase(model.name)}Controlador.lista());

    app.route(rotas${model.name}.cadastro)
        .get(${string.toCamelCase(model.name)}Controlador.formularioCadastro())
        .post(${model.name}.validacoes(), ${string.toCamelCase(model.name)}Controlador.cadastra())
        .put(${string.toCamelCase(model.name)}Controlador.edita());

    app.get(rotas${model.name}.edicao, ${string.toCamelCase(model.name)}Controlador.formularioEdicao());

    app.delete(rotas${model.name}.delecao, ${string.toCamelCase(model.name)}Controlador.remove());
};