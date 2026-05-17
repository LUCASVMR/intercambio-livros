<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- ============================================================
     VALIDAÇÃO DE SESSÃO — redireciona se não estiver logado
     ============================================================ --%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — Intercâmbio de Livros</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <%-- ============================================================
         BARRA DE NAVEGAÇÃO
         ============================================================ --%>
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/troca" class="navbar-brand">
            📚 Intercâmbio de Livros
        </a>
        <div class="navbar-usuario">
            <span class="nome-usuario">Olá, ${sessionScope.usuario.nome}!</span>
            <a href="${pageContext.request.contextPath}/index.jsp">Sair</a>
        </div>
    </nav>

    <%-- ============================================================
         CORPO DO DASHBOARD
         ============================================================ --%>
    <div class="dashboard-wrapper">

        <%-- ====================================================
             COLUNA PRINCIPAL — Solicitações Pendentes de Troca
             ==================================================== --%>
        <div class="card-secao">
            <h2>
                🔔 Solicitações Pendentes
                <c:if test="${not empty listaPendentes}">
                    <span class="badge">${fn:length(listaPendentes)}</span>
                </c:if>
            </h2>

            <c:choose>
                <c:when test="${empty listaPendentes}">
                    <table class="tabela-trocas">
                        <tbody>
                            <tr>
                                <td class="tabela-vazia">
                                    ✅ Nenhuma solicitação pendente no momento.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <table class="tabela-trocas">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Livro Oferecido</th>
                                <th>Livro Solicitado</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Itera sobre a lista de trocas pendentes --%>
                            <c:forEach var="troca" items="${listaPendentes}">
                                <tr>
                                    <td>${troca.id}</td>
                                    <td>${troca.livroOferecido.titulo}</td>
                                    <td>${troca.livroRecebido.titulo}</td>
                                    <td>
                                        <div class="acoes-troca">

                                            <%-- Formulário: ACEITAR troca --%>
                                            <form
                                                action="${pageContext.request.contextPath}/troca"
                                                method="POST"
                                                style="display:inline;"
                                            >
                                                <input type="hidden" name="id"   value="${troca.id}">
                                                <input type="hidden" name="acao" value="aceitar">
                                                <button type="submit" class="btn btn-aceitar">
                                                    ✔ Aceitar
                                                </button>
                                            </form>

                                            <%-- Formulário: RECUSAR troca --%>
                                            <form
                                                action="${pageContext.request.contextPath}/troca"
                                                method="POST"
                                                style="display:inline;"
                                            >
                                                <input type="hidden" name="id"   value="${troca.id}">
                                                <input type="hidden" name="acao" value="recusar">
                                                <button type="submit" class="btn btn-recusar">
                                                    ✖ Recusar
                                                </button>
                                            </form>

                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>

        </div>

        <%-- ====================================================
             COLUNA LATERAL — Cadastro de Novo Livro
             ==================================================== --%>
        <div class="card-secao">
            <h2>📖 Cadastrar Livro</h2>

            <form
                action="${pageContext.request.contextPath}/livros"
                method="POST"
                class="form-livro"
            >
                <div class="form-grupo">
                    <label for="titulo">Título</label>
                    <input
                        type="text"
                        id="titulo"
                        name="titulo"
                        placeholder="Título do livro"
                        required
                    >
                </div>

                <div class="form-grupo">
                    <label for="autor">Autor</label>
                    <input
                        type="text"
                        id="autor"
                        name="autor"
                        placeholder="Nome do autor"
                        required
                    >
                </div>

                <button type="submit" class="btn btn-primario">
                    + Cadastrar Livro
                </button>

            </form>
        </div>

    </div><%-- fim dashboard-wrapper --%>

</body>
</html>