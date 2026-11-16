package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model.Customer6;

public class CustomerDAO6 extends DAO6 {

	public CustomerDAO6() {
		super();
	}

	/**
	 * Kiem tra username, so dien thoai, email da duoc dang ki hay chua
	 * @param c: khach hang can kiem tra
	 * @return null neu chua ton tai, nguoc lai tra ve thong bao loi tuong ung
	 */
	public String checkExisted(Customer6 c) {
		String sql = "SELECT username, phone, email FROM tblMember6 WHERE username=? OR phone=? OR email=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, c.getUsername());
			ps.setString(2, c.getPhone());
			ps.setString(3, c.getEmail());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (c.getUsername().equals(rs.getString("username")))
					return "Username already exists!";
				if (c.getPhone().equals(rs.getString("phone")))
					return "Phone number is already registered!";
				if (c.getEmail().equals(rs.getString("email")))
					return "Email is already registered!";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "Database connection error!";
		}
		return null;
	}

	/**
	 * Luu khach hang moi: them 1 dong vao tblMember6 va 1 dong vao tblCustomer6
	 * @param c: khach hang can luu (chua co id)
	 * @return true neu luu thanh cong; khi do c duoc gan id moi
	 */
	public boolean addCustomer(Customer6 c) {
		if (checkExisted(c) != null)
			return false;
		boolean kq = false;
		String sqlMember = "INSERT INTO tblMember6(username, password, fullName, address, phone, email, registerDate, status) "
				+ "VALUES(?,?,?,?,?,?,?,?)";
		String sqlCustomer = "INSERT INTO tblCustomer6(tblMember6id, dateOfBirth) VALUES(?,?)";
		try {
			con.setAutoCommit(false);
			PreparedStatement psMember = con.prepareStatement(sqlMember, Statement.RETURN_GENERATED_KEYS);
			psMember.setString(1, c.getUsername());
			psMember.setString(2, c.getPassword());
			psMember.setString(3, c.getFullName());
			psMember.setString(4, c.getAddress());
			psMember.setString(5, c.getPhone());
			psMember.setString(6, c.getEmail());
			psMember.setDate(7, new java.sql.Date(c.getRegisterDate().getTime()));
			psMember.setString(8, c.getStatus());
			psMember.executeUpdate();

			ResultSet keys = psMember.getGeneratedKeys();
			if (keys.next()) {
				c.setId(keys.getInt(1));
				PreparedStatement psCustomer = con.prepareStatement(sqlCustomer);
				psCustomer.setInt(1, c.getId());
				psCustomer.setDate(2, new java.sql.Date(c.getDateOfBirth().getTime()));
				psCustomer.executeUpdate();
				con.commit();
				kq = true;
			} else {
				con.rollback();
			}
		} catch (Exception e) {
			try {
				con.rollback();
			} catch (Exception ee) {
				ee.printStackTrace();
			}
			e.printStackTrace();
			kq = false;
		} finally {
			try {
				con.setAutoCommit(true);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return kq;
	}
}
