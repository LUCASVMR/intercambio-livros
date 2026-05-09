package br.com.livros.service;

import java.util.List;
import br.com.livros.dao.UsuarioDAO;
import br.com.livros.model.Usuario;

public class UsuarioService {

    private UsuarioDAO usuarioDAO;

    public UsuarioService() {
        this.usuarioDAO = new UsuarioDAO();
    }

    public List<Usuario> listarUsuarios() {
        return usuarioDAO.listarTodos();
    }
}