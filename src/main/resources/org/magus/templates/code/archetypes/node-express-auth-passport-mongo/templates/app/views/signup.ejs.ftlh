<!doctype html>
<html>
  <body>
    <h1>Signup</h1>
    <form action="/users/signup" method="POST">
      Username: <input name="username" type="text" /><br />
      Password: <input name="password" type="password" /><br />
      E-mail: <input name="email" type="text" /><br />
      Perfil: <select name="profile">
        <option value="1">Usuário</option>
        <option value="2">Administrador</option>
      </select><br />
      <input type="submit" value="Save" />
    </form>
    <% if(message) { %>
      <p>
        <label style="color:Red"><%= message %></label>
      </p>
    <%}%>
  </body>
</html>
