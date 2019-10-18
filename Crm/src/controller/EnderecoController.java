package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EnderecoDAO;
import model.Cliente;
import model.Endereco;

@WebServlet("/Endereco")
public class EnderecoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private EnderecoDAO enderecoDAO = new EnderecoDAO();
	private Endereco endereco;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getSession().getAttribute("idCliente")==null) {
			response.sendRedirect("Cliente.jsp");
		} else {
			response.sendRedirect("Endereco.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		endereco = new Endereco();
		endereco.setCep(request.getParameter("cep"));
		endereco.setLogradouro(request.getParameter("logradouro"));
		endereco.setNumero(request.getParameter("numero"));
		endereco.setComplemento(request.getParameter("complemento"));
		endereco.setBairro(request.getParameter("bairro"));
		endereco.setCidade(request.getParameter("cidade"));
		endereco.setUf(request.getParameter("uf"));
		enderecoDAO.gravarEndereco((int)request.getSession().getAttribute("idCliente"), endereco);
		request.getSession().setAttribute("endereco", endereco);
		doGet(request, response);
	}

}
