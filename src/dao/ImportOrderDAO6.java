package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model.ImportOrder6;
import model.ImportOrderDetail6;

public class ImportOrderDAO6 extends DAO6 {

	public ImportOrderDAO6() {
		super();
	}

	/**
	 * Luu phieu nhap cung cac dong chi tiet va cap nhat so luong ton kho cua tung mat hang.
	 * Tat ca thuc hien trong 1 transaction: loi o bat ki buoc nao thi huy toan bo.
	 * @param io: phieu nhap da co nha cung cap, nhan vien kho, danh sach chi tiet
	 * @return true neu luu thanh cong; khi do io duoc gan id moi
	 */
	public boolean saveImport(ImportOrder6 io) {
		if (io == null || io.getListDetail() == null || io.getListDetail().size() == 0)
			return false;
		boolean kq = false;
		String sqlOrder = "INSERT INTO tblImportOrder6(importDate, tblSupplier6id, tblWarehouseStaff6id) VALUES(?,?,?)";
		String sqlDetail = "INSERT INTO tblImportOrderDetail6(quantity, importPrice, tblImportOrder6id, tblItem6id) VALUES(?,?,?,?)";
		String sqlStock = "UPDATE tblItem6 SET stockQuantity = stockQuantity + ? WHERE id = ?";
		try {
			con.setAutoCommit(false);
			// them phieu nhap
			PreparedStatement psOrder = con.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
			psOrder.setDate(1, new java.sql.Date(io.getImportDate().getTime()));
			psOrder.setInt(2, io.getSupplier().getId());
			psOrder.setInt(3, io.getWarehouseStaff().getId());
			psOrder.executeUpdate();
			ResultSet keys = psOrder.getGeneratedKeys();
			if (!keys.next()) {
				con.rollback();
				return false;
			}
			io.setId(keys.getInt(1));

			// them tung dong chi tiet va cong ton kho
			PreparedStatement psDetail = con.prepareStatement(sqlDetail);
			PreparedStatement psStock = con.prepareStatement(sqlStock);
			for (ImportOrderDetail6 d : io.getListDetail()) {
				psDetail.setInt(1, d.getQuantity());
				psDetail.setFloat(2, d.getImportPrice());
				psDetail.setInt(3, io.getId());
				psDetail.setInt(4, d.getItem().getId());
				psDetail.executeUpdate();

				psStock.setInt(1, d.getQuantity());
				psStock.setInt(2, d.getItem().getId());
				psStock.executeUpdate();
			}
			con.commit();
			kq = true;
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
