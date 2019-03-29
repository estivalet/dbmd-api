const { validationResult } = require('express-validator/check');

const ${model.name}Dao = require('../infra/${string.toCamelCase(model.name)}-dao');
const db = require('../../config/database');

const templates = require('../views/templates');

class ${model.name}Controlador {

    static rotas() {
        return {
            lista: '/${model.pluralName}',
            cadastro: '/${model.pluralName}/form',
            edicao: '/${model.pluralName}/form/:id',
            delecao: '/${model.pluralName}/:id'
        };
    }

    lista() {
        return function(req, resp) {

            const ${string.toCamelCase(model.name)}Dao = new ${model.name}Dao(db);
            ${string.toCamelCase(model.name)}Dao.lista()
                    .then(${model.pluralName} => resp.marko(
                        templates.${model.pluralName}.lista,
                        {
                            ${model.pluralName}: ${model.pluralName}
                        }
                    ))
                    .catch(erro => console.log(erro));
        };
    }

    formularioCadastro() {
        return function(req, resp) {
            resp.marko(templates.${model.pluralName}.form, { ${string.toCamelCase(model.name)}: {} });
        };
    }

    formularioEdicao() {
        return function(req, resp) {
            const id = req.params.id;
            const ${string.toCamelCase(model.name)}Dao = new ${model.name}Dao(db);
    
            ${string.toCamelCase(model.name)}Dao.buscaPorId(id)
                    .then(${string.toCamelCase(model.name)} => 
                        resp.marko(
                            templates.${model.pluralName}.form, 
                            { ${string.toCamelCase(model.name)}: ${string.toCamelCase(model.name)} }
                        )
                    )
                    .catch(erro => console.log(erro));
        };
    }

    cadastra() {
        return function(req, resp) {
            console.log(req.body);
            const ${string.toCamelCase(model.name)}Dao = new ${model.name}Dao(db);
            
            const erros = validationResult(req);
    
            if (!erros.isEmpty()) {
                return resp.marko(
                    templates.${model.pluralName}.form,
                    { 
                        ${string.toCamelCase(model.name)}: {}, 
                        errosValidacao: erros.array()
                    }
                );
            }
    
            ${string.toCamelCase(model.name)}Dao.adiciona(req.body)
                    .then(resp.redirect(${model.name}Controlador.rotas().lista))
                    .catch(erro => console.log(erro));
        };
    }

    edita() {
        return function(req, resp) {
            console.log(req.body);
            const ${string.toCamelCase(model.name)}Dao = new ${model.name}Dao(db);
            
            ${string.toCamelCase(model.name)}Dao.atualiza(req.body)
                    .then(resp.redirect(${model.name}Controlador.rotas().lista))
                    .catch(erro => console.log(erro));
        };
    }

    remove() {
        return function(req, resp) {
            const id = req.params.id;
    
            const ${string.toCamelCase(model.name)}Dao = new ${model.name}Dao(db);
            ${string.toCamelCase(model.name)}Dao.remove(id)
                    .then(() => resp.status(200).end())
                    .catch(erro => console.log(erro));
        };
    }
}

module.exports = ${model.name}Controlador;