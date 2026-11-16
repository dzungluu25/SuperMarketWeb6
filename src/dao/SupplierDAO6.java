package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Supplier6;

public class SupplierDAO6 extends DAO6 {

	public SupplierDAO6() {
		super();
	}

	/**
	 * Tim cac nha cung cap co ten chua tu khoa
	 * @param key: tu khoa ten nha cung cap
	 * @return danh sach nha cung cap tim thay (rong neu khong co)
	 */
	public ArrayList<Supplier6> searchSupplier(String key) {
		ArrayList<Supplier6> kq = new ArrayList<Supplier6>();
		String sql = "{call searchSupplier6(?)}"; // su dung stored procedure
		try {
			CallableStatement cs = con.prepareCall(sql);
			cs.setString(1, key);
			ResultSet rs = cs.executeQuery();
			while (rs.next()) {
				Supplier6 s = new Supplier6();
				s.setId(rs.getInt("id"));
				s.setName(rs.getString("name"));
				s.setAddress(rs.getString("address"));
				s.setPhone(rs.getString("phone"));
				s.setEmail(rs.getString("email"));
				s.setDescription(rs.getString("description"));
				kq.add(s);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return kq;
	}
}
