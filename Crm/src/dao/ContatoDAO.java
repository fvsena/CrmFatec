package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Cliente;
import model.Contato;

public class ContatoDAO {
	public Contato gravarContato(int codigoCliente, int codigoAgente, Contato c) {
		String sql = "call saveContact (?, ?, ?)";
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setInt(1, codigoCliente);
			statement.setInt(2, codigoAgente);
			statement.setString(3, c.getDetalhe());

			ResultSet rs = statement.executeQuery();
			try {
				while(rs.next()) {
					try {
						String erro = rs.getString("ErrorMessage");
				        System.out.println(erro);
				    }
				    catch (Exception ex) {
				    	continue;
				    }
				}
			} catch (Exception e1) {
			}
			statement.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return c;
	}

	public List<Contato> obterContatos(int codigoCliente){
		Contato c;
		List<Contato> contatos = new ArrayList<Contato>();
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			CallableStatement statement = conn.prepareCall("call getContacts (?)");
			statement.setInt(1, codigoCliente);
			ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				c = new Contato();
				c.setCodigo(rs.getInt("IdContact"));
				c.setNomeAgente(rs.getString("Name"));
				c.setDataContato(rs.getDate("ContactDate"));
				c.setDetalhe(rs.getString("Detail"));
				contatos.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return contatos;
	}
}
