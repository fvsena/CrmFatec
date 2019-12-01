package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ContatoDAO;
import model.Contato;

@WebServlet("/ListaContatos")
public class ListaContatosController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<Contato> contatos = new ArrayList<Contato>();
	private ContatoDAO contatoDAO = new ContatoDAO();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getSession().getAttribute("idCliente")==null) {
			response.sendRedirect("Cliente.jsp");
		}
		else {
			contatos = contatoDAO.obterContatos((int)request.getSession().getAttribute("idCliente"));
			request.getSession().setAttribute("contatos", contatos);
			response.sendRedirect("ListaContatos.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
