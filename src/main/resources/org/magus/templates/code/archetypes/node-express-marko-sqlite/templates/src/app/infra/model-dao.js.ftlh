class ${model.name}Dao {

    constructor(db) {
        this._db = db;
    }

    adiciona(${string.toCamelCase(model.name)}) {
        return new Promise((resolve, reject) => {
            this._db.run(`
                INSERT INTO ${string.toCamelCase(model.name)} (
                	${model.getAttributesCommaSeparated()}
                ) values (${model.getAttributesReplacedBy("?")})
                `,
                [
                	${model.getAttributesPrecededByModelName()}
                ],
                function (err) {
                    if (err) {
                        console.log(err);
                        return reject('Não foi possível adicionar o ${string.toCamelCase(model.name)}!');
                    }

                    resolve();
                }
            )
        });
    }

    lista() {
        return new Promise((resolve, reject) => {
            this._db.all(
                'SELECT * FROM ${string.toCamelCase(model.name)}',
                (erro, resultados) => {
                    if (erro) return reject('Não foi possível listar os ${string.toCamelCase(model.name)}!');

                    return resolve(resultados);
                }
            )
        });
    }

    buscaPorId(id) {

        return new Promise((resolve, reject) => {
            this._db.get(
                `
                    SELECT *
                    FROM ${string.toCamelCase(model.name)}
                    WHERE id = ?
                `,
                [id],
                (erro, ${string.toCamelCase(model.name)}) => {
                    if (erro) {
                        return reject('Não foi possível encontrar o ${string.toCamelCase(model.name)}!');
                    }
                    return resolve(${string.toCamelCase(model.name)});
                }
            );
        });
    }

    atualiza(${string.toCamelCase(model.name)}) {
        return new Promise((resolve, reject) => {
            this._db.run(`
                UPDATE ${string.toCamelCase(model.name)} SET
                titulo = ?,
                preco = ?,
                descricao = ?
                WHERE id = ?
            `,
            [
				${model.getAttributesPrecededByModelName()}
            ],
            erro => {
                if (erro) {
                    return reject('Não foi possível atualizar o ${string.toCamelCase(model.name)}!');
                }

                resolve();
            });
        });
    }

    remove(id) {

        return new Promise((resolve, reject) => {
            this._db.get(
                `
                    DELETE 
                    FROM ${string.toCamelCase(model.name)}
                    WHERE id = ?
                `,
                [id],
                (erro) => {
                    if (erro) {
                        return reject('Não foi possível remover o ${string.toCamelCase(model.name)}!');
                    }
                    return resolve();
                }
            );
        });
    }
}

module.exports = ${model.name}Dao;