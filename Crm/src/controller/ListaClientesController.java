package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClienteDAO;
import model.Cliente;

@WebServlet("/ListaClientes")
public class ListaClientesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<Cliente> clientes = new ArrayList<Cliente>();
	private ClienteDAO clienteDAO = new ClienteDAO();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		clientes = clienteDAO.obterClientes();
		request.getSession().setAttribute("clientes", clientes);
		response.sendRedirect("ListaClientes.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cliente cliente = clienteDAO.obterCliente(Integer.parseInt(request.getParameter("cmd")));
		request.getSession().setAttribute("cliente", cliente);
		request.getSession().setAttribute("idCliente", cliente.getCodigo());
		request.getSession().setAttribute("nomeCliente", cliente.getNome());
		response.sendRedirect("Cliente.jsp");
	}

}
