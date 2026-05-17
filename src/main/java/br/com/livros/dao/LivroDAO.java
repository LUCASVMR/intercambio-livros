package br.com.livros.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import br.com.livros.config.MysqlSingleton;
import br.com.livros.model.Livro;

public class LivroDAO {

    // Mantendo EXATAMENTE o método de listagem do Bruno
    public List<Livro> listarTodos() {
        List<Livro> livros = new ArrayList<>();
        String sql = "SELECT * FROM livros";

        try (ResultSet rs = MysqlSingleton.getInstance().executar(sql)) {
            while (rs.next()) {
                Livro livro = new Livro();
                livro.setId(rs.getInt("id"));
                livro.setTitulo(rs.getString("titulo"));
                livro.setAutor(rs.getString("autor"));
                livro.setUsuarioId(rs.getInt("usuario_id"));
                livros.add(livro);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar livros: " + e.getMessage());
        }
        return livros;
    }

    /**
     * Cadastra um novo livro no banco de dados.
     * Seguindo exatamente o padrão MysqlSingleton do Arquivo F!
     */
    public boolean cadastrarLivro(Livro livro) {
        String sql = "INSERT INTO livros (titulo, autor, usuario_id) VALUES (?, ?, ?)";

        Object[] parametros = {
            livro.getTitulo(),
            livro.getAutor(),
            livro.getUsuarioId()
        };

        try {
            int linhasAfetadas = MysqlSingleton.getInstance().executarUpdate(sql, parametros);
            return linhasAfetadas > 0;
        } catch (Exception e) {
            System.out.println("Erro ao cadastrar livro: " + e.getMessage());
            return false;
        }
    }
}