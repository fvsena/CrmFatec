package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RelatorioDAO;
import viewmodels.RelatorioContato;

@WebServlet("/Relatorio")
public class RelatorioController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RelatorioDAO relatorioDAO = new RelatorioDAO();
	private List<RelatorioContato> relatorio = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("Relatorio.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String dataInicio = request.getParameter("dataInicio");
			Date dtInicio = new SimpleDateFormat("yyyy-MM-dd").parse(dataInicio);
			
			String dataFim = request.getParameter("dataFim");
			Date dtFim = new SimpleDateFormat("yyyy-MM-dd").parse(dataFim);
			
			relatorio = relatorioDAO.gerarRelatorioContato(dtInicio, dtFim);
			request.getSession().setAttribute("relatorio", relatorio);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		doGet(request, response);
	}

}
