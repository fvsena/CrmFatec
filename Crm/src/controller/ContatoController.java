package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ContatoDAO;
import model.Contato;
import model.Telefone;
import model.Usuario;

@WebServlet("/Contato")
public class ContatoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ContatoDAO contatoDAO = new ContatoDAO();
	private Contato contato;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getSession().getAttribute("idCliente")==null) {
			response.sendRedirect("Cliente.jsp");
		}
		else {
			response.sendRedirect("Contato.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			contato = new Contato();
			contato.setDetalhe(request.getParameter("detalhe"));
			contatoDAO.gravarContato((int)request.getSession().getAttribute("idCliente"),
					((Usuario)request.getSession().getAttribute("usuario")).getCodigo(),
					contato);
		} catch (Exception e) {
			e.printStackTrace();
		}
		doGet(request, response);
	}

}
