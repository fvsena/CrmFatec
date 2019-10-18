package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Telefone;

public class TelefoneDAO {
	public Telefone gravarTelefone(int codigoCliente, Telefone t) {
		String sql = "sp_GravarTelefone ?, ?";
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setInt(1, codigoCliente);
			statement.setString(2, t.getTelefone());

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
		return t;
	}
}
