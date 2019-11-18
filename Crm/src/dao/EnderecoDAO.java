package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Endereco;

public class EnderecoDAO {
	public Endereco gravarEndereco(int codigoCliente, Endereco e) {
		String sql = "call sp_GravarEndereco (?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setInt(1, codigoCliente);
			statement.setString(2, e.getCep());
			statement.setString(3, e.getLogradouro());
			statement.setString(4, e.getNumero());
			statement.setString(5, e.getBairro());
			statement.setString(6, e.getComplemento());
			statement.setString(7, e.getCidade());
			statement.setString(8, e.getUf());

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
		return e;
	}
}
