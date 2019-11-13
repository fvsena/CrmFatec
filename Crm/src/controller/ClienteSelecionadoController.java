package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ClienteSelecionado")
public class ClienteSelecionadoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ClienteSelecionadoController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().removeAttribute("cliente");
		request.getSession().removeAttribute("idCliente");
		request.getSession().removeAttribute("nomeCliente");
		response.sendRedirect("ListaClientes.jsp");
		doGet(request, response);
	}

}
