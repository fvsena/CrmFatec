package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.ConnectionManager;
import model.Cliente;

public class ClienteDAO {
	public Cliente gravarCliente(Cliente c) {
		String sql = "call saveCustomer (?, ?, ?, ?, ?)";
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
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return c;
	}
	
	public List<Cliente> obterClientes(){
		Cliente c;
		List<Cliente> clientes = new ArrayList<Cliente>();
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			CallableStatement statement = conn.prepareCall("call getCustomers()");
			ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				c = new Cliente();
				c.setCodigo(rs.getInt("Codigo"));
				c.setNome(rs.getString("Nome"));
				c.setGenero(rs.getString("Genero"));
				c.setDocumento(rs.getString("Documento"));
				c.setDataNascimento(rs.getDate("DataNascimento"));
				clientes.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return clientes;
	}
	
	public Cliente obterCliente(int codigoCliente){
		Cliente c = new Cliente();
		try {
			Connection conn = ConnectionManager.getInstance().getConnection();
			CallableStatement statement = conn.prepareCall("call getCustomer (?)");
			statement.setInt(1, codigoCliente);
			ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				c.setCodigo(rs.getInt("Codigo"));
				c.setNome(rs.getString("Nome"));
				c.setGenero(rs.getString("Genero"));
				c.setDocumento(rs.getString("Documento"));
				c.setDataNascimento(rs.getDate("DataNascimento"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}
}
