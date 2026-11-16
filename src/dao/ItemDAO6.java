package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Item6;

public class ItemDAO6 extends DAO6 {

	public ItemDAO6() {
		super();
	}

	/**
	 * Tim cac mat hang co ten chua tu khoa
	 * @param key: tu khoa ten mat hang
	 * @return danh sach mat hang tim thay (rong neu khong co)
	 */
	public ArrayList<Item6> searchItem(String key) {
		ArrayList<Item6> kq = new ArrayList<Item6>();
		String sql = "{call searchItem6(?)}"; // su dung stored procedure
		try {
			CallableStatement cs = con.prepareCall(sql);
			cs.setString(1, key);
			ResultSet rs = cs.executeQuery();
			while (rs.next()) {
				Item6 it = new Item6();
				it.setId(rs.getInt("id"));
				it.setName(rs.getString("name"));
				it.setUnit(rs.getString("unit"));
				it.setPrice(rs.getFloat("price"));
				it.setStockQuantity(rs.getInt("stockQuantity"));
				it.setDescription(rs.getString("description"));
				it.setStatus(rs.getString("status"));
				kq.add(it);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return kq;
	}
}
