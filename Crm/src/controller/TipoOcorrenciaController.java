package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.ConnectionManager;
import dao.TipoOcorrenciaDAO;
import model.DetalheOcorrencia;
import model.GrupoOcorrencia;
import model.SubGrupoOcorrencia;
import model.Telefone;

@WebServlet("/TipoOcorrencia")
public class TipoOcorrenciaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TipoOcorrenciaDAO tipoOcorrenciaDAO = new TipoOcorrenciaDAO();
    private List<GrupoOcorrencia> grupos = new ArrayList<>();
    private List<SubGrupoOcorrencia> subGrupos = new ArrayList<>();
    private List<DetalheOcorrencia> detalhes = new ArrayList<>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = "";
		if(request.getParameter("cmd") != null) {
			cmd = request.getParameter("cmd");
			switch(cmd) {
				case "subgrupo":
					PrintWriter out = response.getWriter();
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					out.print(obterSubGrupos(request.getParameter("grupo")));
					out.flush();
					break;
				default:
					break;
			}
			return;
		}
		grupos = tipoOcorrenciaDAO.obterGrupos();
		request.getSession().setAttribute("grupos", grupos);
		response.sendRedirect("TipoOcorrencia.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String cmd = request.getParameter("cmd");
			switch(cmd) {
				case "GravarGrupo":
					gravarGrupoOcorrencia(
							request.getParameter("grupo"));
					break;
				case "GravarSubGrupo":
					gravarSubGrupoOcorrencia(
							Integer.parseInt(request.getParameter("grupos")),
							request.getParameter("subGrupo"));
					break;
				case "GravarDetalhe":
					gravarDetalheOcorrencia(
							Integer.parseInt(request.getParameter("grupos_detalhe")),
							Integer.parseInt(request.getParameter("subGrupos")),
							request.getParameter("detalhe"));
					break;
				default:
					break;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		response.sendRedirect("TipoOcorrencia.jsp");
	}
	
	private void gravarGrupoOcorrencia(String grupo) {
		try {
			tipoOcorrenciaDAO.gravarGrupoOcorrencia(grupo);
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	private void gravarSubGrupoOcorrencia(int grupo, String subGrupo) {
		try {
			tipoOcorrenciaDAO.gravarSubGrupoOcorrencia(grupo, subGrupo);
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	private void gravarDetalheOcorrencia(int grupo, int subGrupo, String detalhe) {
		try {
			tipoOcorrenciaDAO.gravarDetalheOcorrencia(grupo, subGrupo, detalhe);
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	private String obterSubGrupos(String idGrupo)
    {
        subGrupos = tipoOcorrenciaDAO.obterSubGrupos(Integer.parseInt(idGrupo));
        Gson gson = new Gson();
        String json = gson.toJson(subGrupos);
        return json;
    }

}
