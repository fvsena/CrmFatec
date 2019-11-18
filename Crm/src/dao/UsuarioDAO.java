package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Usuario;

public class UsuarioDAO {
	public Usuario validarLogin(Usuario u) {
		if (u.getLogin() != null && !u.getLogin().isEmpty()) {
			String sql = "call sp_ValidarLogin (?, ?)";
			try {
				Connection conn = ConnectionManager.getInstance().getConnection();
				PreparedStatement statement = conn.prepareStatement(sql);
				statement.setString(1, u.getLogin());
				statement.setString(2, u.getSenha());
				ResultSet rs = statement.executeQuery();
				while(rs.next()) {
					u.setCodigo(rs.getInt("IdAgent"));
					u.setNome(rs.getString("Name"));
					u.setValido(true);
				}
				statement.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return u;
	}
}
