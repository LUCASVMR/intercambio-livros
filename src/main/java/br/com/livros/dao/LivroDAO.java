package br.com.livros.dao;

import br.com.livros.model.Livro;
import br.com.livros.config.MysqlSingleton;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LivroDAO {

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
}