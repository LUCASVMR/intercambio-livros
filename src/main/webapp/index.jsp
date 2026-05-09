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
    <h2>Usuários Cadastrados (Padrão MVC):</h2>
    <ul>
        <%
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