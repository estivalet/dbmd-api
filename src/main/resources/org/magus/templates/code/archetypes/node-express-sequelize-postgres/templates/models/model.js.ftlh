'use strict';

module.exports = (sequelize, DataTypes) => {
  var ${model.name} = sequelize.define('${model.name}', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true, allowNull: false },
    <#list model.attributes as attribute>
    ${attribute.name}: DataTypes.STRING
    </#list>
  }, {});

  return ${model.name};
};
