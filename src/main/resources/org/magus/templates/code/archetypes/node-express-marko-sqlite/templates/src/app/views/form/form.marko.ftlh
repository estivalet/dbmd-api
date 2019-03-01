<html>
    <body>
        <h1>Cadastro de ${model.pluralName}</h1>
        
        <form action="/${model.pluralName}" method="post">

            <div if(data.${model.getCamelCaseName()}.id)>
                <input type="hidden" name="_method" value="PUT">
                <input type="hidden" id="id" name="id" value="<#noparse>${data.</#noparse>${model.getCamelCaseName()}.id}" />
            </div>

			<#list model.attributes as attribute>
            <div>
                <label for="${attribute.name}">${attribute.label}:</label>
                <input type="text" id="${attribute.name}" name="${attribute.name}" value="<#noparse>${data.</#noparse>${model.getCamelCaseName()}.${attribute.name}}" placeholder="coloque o ${attribute.name}" />
            </div>
            </#list>

            <input type="submit" value="Salvar" />
        </form>
    </body>
</html>