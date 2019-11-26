module.exports = (app) => {
    const controller = require('../controllers/${app.shortName}.controller');
    
    app.get('/', controller.index);    
    app.get('/login', controller.login);    
    app.get('/register', controller.register);
    app.get('/logout', controller.logout);    
    
    app.post('/', controller.executeLogin);    
    app.post('/register', controller.registerNewUser);    
    
    
}