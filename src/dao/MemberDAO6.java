package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;

import model.Member6;

public class MemberDAO6 extends DAO6 {

	public MemberDAO6() {
		super();
	}

	/**
	 * Kiem tra dang nhap bang username va password
	 * @param m: doi tuong Member6 da co username, password
	 * @return true neu dung tai khoan; khi do m duoc bo sung id, fullName, role
	 */
	public boolean checkLogin(Member6 m) {
		boolean kq = false;
		String sql = "{call checkLogin6(?,?)}"; // su dung stored procedure
		try {
			CallableStatement cs = con.prepareCall(sql);
			cs.setString(1, m.getUsername());
			cs.setString(2, m.getPassword());
			ResultSet rs = cs.executeQuery();
			if (rs.next()) {
				m.setId(rs.getInt("id"));
				m.setFullName(rs.getString("fullName"));
				m.setAddress(rs.getString("address"));
				m.setPhone(rs.getString("phone"));
				m.setEmail(rs.getString("email"));
				m.setStatus(rs.getString("status"));
				m.setRole(rs.getString("role"));
				kq = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			kq = false;
		}
		return kq;
	}
}
