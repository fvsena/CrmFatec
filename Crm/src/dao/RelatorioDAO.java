package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import viewmodels.RelatorioContato;

public class RelatorioDAO {
	public List<RelatorioContato> gerarRelatorioContato(Date dataInicio, Date dataFim){
		RelatorioContato r;
		List<RelatorioContato> relatorio = new ArrayList<>();
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			CallableStatement statement = conn.prepareCall("call getContactReport(?, ?)");
			statement.setDate(1, new java.sql.Date(dataInicio.getTime()));
			statement.setDate(2, new java.sql.Date(dataFim.getTime()));
			ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				r = new RelatorioContato();
				
				r.setDataContato(rs.getDate("Date"));
				r.setNome(rs.getString("Name"));
				r.setDocumento(rs.getString("DocumentNumber"));
				r.setGenero(rs.getString("Gender"));
				r.setDataNascimento(rs.getDate("BirthDate"));
				r.setLogradouro(rs.getString("PublicPlace"));
				r.setNumero(rs.getString("Number"));
				r.setBairro(rs.getString("Neighborhood"));
				r.setCidade(rs.getString("City"));
				r.setUf(rs.getString("State"));
				r.setDetalhe(rs.getString("Detail"));
				r.setNomeAgente(rs.getString("Agent"));
				
				relatorio.add(r);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return relatorio;
	}
}
