<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
  </head>
  <body>
    <h1><%= title %></h1>
    <p>Welcome to <%= title %></p>
    <p><%= qtd %> usuários cadastrados!</p>
    <table>
      <tr style="background-color:Gray">
        <td>Nome</td><td>Ações</td>
      </tr>
      <% 
        if(docs) {
          for(var i=0; i < docs.length; i++){
            %>
            <tr>
              <td><a href="/edit/<%= docs[i]._id %>"><%= docs[i].username %></a></td>
              <td>
                  <a href="/users/delete/<%= docs[i]._id %>">
                    <input type="button" value="Excluir" />
                  </a>                    
              </td>
            </tr>
            <%
          }
        }
      %>
      <tr>
        <td colspan="2">
          <%
            for(var i=1; i <= qtdPaginas; i++){
              if(pagina === i){
          %>
                <%= i %> | 
          <% 
              } else {
          %>
              <a href="/index/<%= i %>">
                <%= i %>
              </a> | 
          <%
            } 
          }
          %>
        </td>
      </tr>
    </table>
    <p>
      <a href="/users/signup">Cadastrar</a>
      <form action="/logoff" method="POST">
        <input type="submit" value="Logoff" />
      </form>
    </p>
    <p>
      <%
        if(profile === '2'){
      %>
          <a href="/reports">reports para admins</a>
      <% } %>
    </p>
  </body>
</html>
