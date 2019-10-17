package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClienteDAO;
import model.Cliente;

@WebServlet("/cliente")
public class ClienteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ClienteDAO clienteDAO = new ClienteDAO();
	private Cliente cliente = new Cliente();
    public ClienteController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("Cliente.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			cliente = new Cliente();
			cliente.setNome(request.getParameter("nome"));
			cliente.setDocumento(request.getParameter("documento"));
			cliente.setGenero(request.getParameter("genero"));
			String dataNascimento = request.getParameter("dataNascimento");
			Date dataNascto = new SimpleDateFormat("yyyy-MM-dd").parse(dataNascimento);
			cliente.setDataNascimento(dataNascto);
			clienteDAO.gravarCliente(cliente);
		} catch (ParseException e) {
			e.printStackTrace();
		}  
		doGet(request, response);
	}

}
