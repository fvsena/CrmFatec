package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TelefoneDAO;
import model.Endereco;
import model.Telefone;

@WebServlet("/Telefone")
public class TelefoneController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TelefoneDAO telefoneDAO = new TelefoneDAO();
    private Telefone telefone;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getSession().getAttribute("idCliente")==null) {
			response.sendRedirect("Cliente.jsp");
		}
		else {
			response.sendRedirect("Telefone.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		telefone = new Telefone();
		telefone.setDdd(request.getParameter("ddd"));
		telefone.setFone(request.getParameter("fone"));
		telefoneDAO.gravarTelefone((int)request.getSession().getAttribute("idCliente"), telefone);
		request.getSession().setAttribute("telefone", telefone);
		doGet(request, response);
	}

}
