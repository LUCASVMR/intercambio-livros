package br.com.livros.controller;

import br.com.livros.dao.TrocaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/troca") 
public class TrocaController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
      
        String idTrocaStr = request.getParameter("id");
        String acao = request.getParameter("acao");

        if (idTrocaStr != null && acao != null) {
            int idTroca = Integer.parseInt(idTrocaStr);
            String novoStatus = "";

            if (acao.equals("aceitar")) {
                novoStatus = "ACEITA";
            } else if (acao.equals("recusar")) {
                novoStatus = "RECUSADA";
            }

            if (!novoStatus.isEmpty()) {
                TrocaDAO trocaDAO = new TrocaDAO();
                boolean sucesso = trocaDAO.atualizarStatus(idTroca, novoStatus);

                if (sucesso) {
                    System.out.println("Sucesso: Troca " + idTroca + " mudou para " + novoStatus);
                } else {
                    System.out.println("Falha: Nenhuma linha alterada no banco.");
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/principal.jsp");
    }
}