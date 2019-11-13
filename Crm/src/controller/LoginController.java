package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UsuarioDAO;
import model.Usuario;

@WebServlet("/Login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsuarioDAO usuarioDAO = new UsuarioDAO();
	private Usuario usuario;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("Login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login = request.getParameter("Login");
		String senha = request.getParameter("Senha");
		usuario = usuarioDAO.validarLogin(new Usuario(login, senha));
		if (usuario.isValido()) {
			request.getSession().setAttribute("usuario", usuario);
			response.sendRedirect("ListaClientes.jsp");
		}
		else
		{
			response.getOutputStream().write("<script>alert('Usuário e/ou senha incorretos!');</script>".getBytes());
			response.sendRedirect("Login.jsp");
		}
	}

}
