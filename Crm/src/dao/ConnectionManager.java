package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionManager {
	private static ConnectionManager instance;
	private Connection conn;
	//private final String csCrmJava = "jdbc:sqlserver://localhost:1433;instance=sqlexpress;databaseName=CrmJava;";
//<<<<<<< HEAD
	//private final String csCrmJava = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=CrmJava;integratedSecurity=true;";
	private final String csCrmJava = "jdbc:mysql://localhost/crm";
	private final String user = "root";
	private final String pass = "admin";
//=======
//	private final String csCrmJava = "jdbc:sqlserver://SENA-LAPTOP\\SQLEXPRESS:1433;databaseName=Crm;integratedSecurity=true;";
//>>>>>>> af292cef985b4c0b88b85e0db3d2860d47949b5e
	
	private ConnectionManager() {
		try {
			//Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Driver Carregado");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static ConnectionManager getInstance() {
		if (instance == null) {
			instance = new ConnectionManager();
		}
		return instance;
	}

	public Connection getConnection() throws SQLException {
		if (conn == null || conn.isClosed()) {
			conn = DriverManager.getConnection(csCrmJava, user, pass);
			System.out.println("Gerada uma nova conexão");
		} else {
			System.out.println("Reusando uma conexão existente");
		}
		return conn;
	}
}