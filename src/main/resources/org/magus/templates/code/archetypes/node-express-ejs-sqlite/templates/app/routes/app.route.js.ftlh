module.exports = (app) => {
    const controller = require('../controllers/${app.shortName}.controller');
    
    app.get('/', controller.index);    
}