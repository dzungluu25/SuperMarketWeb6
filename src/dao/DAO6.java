package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO6 {
	public static Connection con;

	public DAO6() {
		if (con == null) {
			// chay bang Docker thi lay tu bien moi truong, chay tren may thi dung gia tri mac dinh
			String dbUrl = env("DB_URL",
					"jdbc:mysql://localhost:3306/supermarket6?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8");
			String dbUser = env("DB_USER", "root");
			String dbPassword = env("DB_PASSWORD", "123456");
			String dbClass = "com.mysql.cj.jdbc.Driver";
			try {
				Class.forName(dbClass);
				con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private static String env(String name, String defaultValue) {
		String v = System.getenv(name);
		return (v == null || v.isEmpty()) ? defaultValue : v;
	}
}
