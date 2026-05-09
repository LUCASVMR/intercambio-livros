<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="br.com.livros.model.Usuario" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sistema de Intercâmbio - Teste MVC</title>
</head>
<body>
    <h2>Usuários Cadastrados (Padrão MVC Correto):</h2>
    <ul>
        <%
            // ESTA É A LINHA QUE FALTAVA! 
            // Ela pega a lista que o Servlet preparou e guarda na variável 'usuarios'
            List<Usuario> usuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
            
            if(usuarios != null && !usuarios.isEmpty()){
                for(Usuario u : usuarios) {
        %>
                    <li>ID: <%= u.getId() %> | Nome: <%= u.getNome() %> | E-mail: <%= u.getEmail() %></li>
        <%
                }
            } else {
        %>
                <li>Nenhum usuário encontrado. Você acessou pela rota correta (/usuarios)?</li>
        <%
            }
        %>
    </ul>
</body>
</html>