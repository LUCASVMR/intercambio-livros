package br.com.livros.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import br.com.livros.config.MysqlSingleton;
import br.com.livros.model.Usuario;

public class UsuarioDAO {

    public List<Usuario> listarTodos() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";

        try {
            ResultSet rs = MysqlSingleton.getInstance().executar(sql);
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                lista.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}
