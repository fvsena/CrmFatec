package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.ConnectionManager;
import model.Cliente;

public class ClienteDAO {
	public Cliente gravarCliente(Cliente c) {
		String sql = "sp_GravarCliente ?, ?, ?, ?, ?";
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			CallableStatement statement = conn.prepareCall(sql);
			statement.setString(1, c.getNome());
			statement.setString(2, c.getGenero());
			statement.setString(3, c.getDocumento());
			statement.setDate(4, new java.sql.Date(c.getDataNascimento().getTime()));
			if(c.getCodigo() > 0) {
				statement.setInt(5, c.getCodigo());
			} else {
				statement.setNull(5, c.getCodigo());
			}
			
			ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				try {
                    c.setCodigo(rs.getInt("IdCustomer"));
                }
                catch (Exception ex) {
                    String erro = rs.getString("ErrorMessage");
                    System.out.println(erro);
                }
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return c;
	}
	
}
