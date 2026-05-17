package br.com.livros.controller;

import br.com.livros.dao.LivroDAO;
import br.com.livros.model.Livro;
import br.com.livros.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet responsável pelo cadastro de livros.
 * Rota mapeada: POST /livros
 */
@WebServlet("/livros")
public class LivroController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Recebe os dados do formulário, associa o livro ao usuário logado
     * e persiste no banco via LivroDAO.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1. Valida sessão — impede acesso direto sem login
        HttpSession sessao = request.getSession(false);
        if (sessao == null || sessao.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 2. Recupera o usuário logado da sessão
        Usuario usuarioLogado = (Usuario) sessao.getAttribute("usuario");
        int idDono = usuarioLogado.getId();

        // 3. Lê os parâmetros do formulário
        String titulo = request.getParameter("titulo");
        String autor  = request.getParameter("autor");

        // 4. Validação mínima dos campos
        if (titulo == null || titulo.trim().isEmpty()
                || autor == null || autor.trim().isEmpty()) {
            // Volta para o dashboard sem persistir
            response.sendRedirect(request.getContextPath() + "/troca");
            return;
        }

        // 5. Monta o objeto Livro
        Livro novoLivro = new Livro();
        novoLivro.setTitulo(titulo.trim());
        novoLivro.setAutor(autor.trim());
        novoLivro.setUsuarioId(idDono);

        // 6. Persiste via DAO
        LivroDAO livroDAO = new LivroDAO();
        livroDAO.cadastrarLivro(novoLivro);

        // 7. Redireciona de volta ao dashboard (via TrocaController GET)
        response.sendRedirect(request.getContextPath() + "/troca");
    }

    /**
     * Redireciona acessos GET diretos para o dashboard.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/troca");
    }
}