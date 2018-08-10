class Lista${model.pluralName?capitalize} {

    constructor() {
    	this._${model.pluralName} = [];
    }
    
    adiciona(${model.name}) {
    	this._${model.pluralName}.push(${model.name});
    }
    
    esvazia() {
        this._${model.pluralName} = [];
    }
    
    get ${model.pluralName}() {
        return [].concat(this._${model.pluralName});
    }    
        
}
