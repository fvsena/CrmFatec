package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Contato;

public class ContatoDAO {
	public Contato gravarContato(int codigoCliente, int codigoAgente, Contato c) {
		String sql = "sp_GravarContato ?, ?, ?";
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
}
