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
                <label for="titulo">Titulo:</label>
                <input type="text" id="titulo" name="titulo" value="<#noparse>${data.</#noparse>${attribute.name}}" placeholder="coloque o titulo" />
            </div>
            </#list>

            <input type="submit" value="Salvar" />
        </form>
    </body>
</html>