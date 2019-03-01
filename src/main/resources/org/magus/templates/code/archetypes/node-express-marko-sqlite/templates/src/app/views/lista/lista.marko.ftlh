<html>
    <head>
        <meta charset="utf-8">
    </head>
    <body>
        <h1> Listagem de ${model.pluralName} </h1>

        <table id="${model.pluralName}">
            <tr>
                <td>ID</td>
            	<#list model.attributes as attribute>
                <td>${attribute.label}</td>
                </#list>
            </tr>
            <tr id="${model.getCamelCaseName()}_<#noparse>${</#noparse>${model.getCamelCaseName()}.id}" for (${model.getCamelCaseName()} in data.${model.pluralName})>
                <td><#noparse>${</#noparse>${model.getCamelCaseName()}.id}</td>
                <#list model.attributes as attribute>
                <td><#noparse>${</#noparse>${model.getCamelCaseName()}.${attribute.name}}</td>
                </#list>
                <td><a href="/${model.pluralName}/form/<#noparse>${</#noparse>${model.getCamelCaseName()}.id}">Editar</a></td>
                <td><a href="#" data-ref="<#noparse>${</#noparse>${model.getCamelCaseName()}.id}" data-type="remocao">Remover</a></td>
            </tr>
        </table>

        <script src="/estatico/js/remove-${model.getCamelCaseName()}.js">
        </script>
    </body>
</html>