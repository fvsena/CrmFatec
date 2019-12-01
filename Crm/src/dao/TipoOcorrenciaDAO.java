package dao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.GrupoOcorrencia;
import model.SubGrupoOcorrencia;

public class TipoOcorrenciaDAO {
	
	public List<GrupoOcorrencia> obterGrupos(){
		GrupoOcorrencia g;
		List<GrupoOcorrencia> grupos = new ArrayList<>();
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			CallableStatement statement = conn.prepareCall("call getGroupOccurrences()");
			ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				g = new GrupoOcorrencia();
				g.setCodigo(rs.getInt("IdGrupo"));
				g.setDescricao(rs.getString("Grupo"));
				grupos.add(g);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grupos;
	}
	
	public List<SubGrupoOcorrencia> obterSubGrupos(int codigoGrupo){
		SubGrupoOcorrencia s;
		List<SubGrupoOcorrencia> subGrupos = new ArrayList<>();
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			CallableStatement statement = conn.prepareCall("call getSubGroupOccurrences(?)");
			statement.setInt(1, codigoGrupo);
			ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				s = new SubGrupoOcorrencia();
				s.setCodigo(rs.getInt("IdSubGrupo"));
				s.setDescricao(rs.getString("SubGrupo"));
				subGrupos.add(s);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return subGrupos;
	}
	
	public int gravarGrupoOcorrencia(String grupo) {
		String sql = "call saveGroupOccurence (?)";
		int linesAffected = 0;
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, grupo);

			linesAffected = statement.executeUpdate();
			statement.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return linesAffected;
	}
	
	public int gravarSubGrupoOcorrencia(int idGrupo, String subGrupo) {
		String sql = "call saveSubGroupOccurrence (?, ?)";
		int linesAffected = 0;
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setInt(1, idGrupo);
			statement.setString(2, subGrupo);

			linesAffected = statement.executeUpdate();
			statement.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return linesAffected;
	}
	
	public int gravarDetalheOcorrencia(int idGrupo, int idSubGrupo, String detalhe) {
		String sql = "call saveOccurenceDetails (?, ?, ?)";
		int linesAffected = 0;
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setInt(1, idGrupo);
			statement.setInt(2, idSubGrupo);
			statement.setString(3, detalhe);

			linesAffected = statement.executeUpdate();
			statement.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return linesAffected;
	}
}
