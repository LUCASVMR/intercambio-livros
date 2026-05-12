package br.com.livros.dao;

import br.com.livros.model.Troca;
import br.com.livros.config.MysqlSingleton;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TrocaDAO {

    public boolean atualizarStatus(int trocaId, String novoStatus) {
        String sql = "UPDATE trocas SET status = ? WHERE id = ?";

        try {
            int linhasAfetadas = MysqlSingleton.getInstance().executarUpdate(sql, novoStatus, trocaId);
            return linhasAfetadas > 0;
        } catch (Exception e) {
            System.out.println("Erro ao atualizar status da troca: " + e.getMessage());
            return false;
        }
    }

    public List<Troca> listarTrocasPendentes(int idUsuarioLogado) {
        List<Troca> pendentes = new ArrayList<>();

        String sql = "SELECT t.* FROM trocas t " +
                "INNER JOIN livros l ON t.livro_recebido_id = l.id " +
                "WHERE l.usuario_id = ? AND t.status = 'PENDENTE'";

        try (ResultSet rs = MysqlSingleton.getInstance().executar(sql, idUsuarioLogado)) {
            while (rs.next()) {
                Troca troca = new Troca();
                troca.setId(rs.getInt("id"));
                troca.setLivroOferecidoId(rs.getInt("livro_oferecido_id"));
                troca.setLivroRecebidoId(rs.getInt("livro_recebido_id"));
                troca.setStatus(rs.getString("status"));
                pendentes.add(troca);
            }
        } catch (Exception e) {
            System.out.println("Erro ao buscar trocas pendentes: " + e.getMessage());
        }
        return pendentes;
    }
}