<#-- All apps should have only one model set as main -->
<#list app.models as model>
<#if model.main>
const ${model.name}Controlador = require('./${string.toCamelCase(model.name)}-controlador');
</#if>
</#list>

const templates = require('../views/templates');

class BaseControlador {

    static rotas() {
        return {
            home: '/',
            login: '/login'
        };
    }

    home() {
        return function(req, resp) {
            resp.marko(
                templates.base.home
            );
        };
    }

    login() {
        
        return function(req, resp) {
            resp.marko(templates.base.login);
        };
    }

    efetuaLogin() {

        return function(req, resp, next) {

            // Lógica de login.
            const passport = req.passport;
            passport.authenticate('local', (erro, usuario, info) => {
                if (info) {
                    return resp.marko(templates.base.login);
                }

                if (erro) {
                    return next(erro);
                }

                req.login(usuario, (erro) => {
                    if (erro) {
                        return next(erro);
                    }
					<#list app.models as model>
					<#if model.main>
                    return resp.redirect(${model.name}Controlador.rotas().lista);
					</#if>
					</#list>
                });
            })(req, resp, next);
        };
    }
}

module.exports = BaseControlador;