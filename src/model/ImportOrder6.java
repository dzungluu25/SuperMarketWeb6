package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class ImportOrder6 implements Serializable {
	private int id;
	private Date importDate;
	private Supplier6 supplier;
	private WarehouseStaff6 warehouseStaff;
	private ArrayList<ImportOrderDetail6> listDetail;

	public ImportOrder6() {
		super();
		listDetail = new ArrayList<ImportOrderDetail6>();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getImportDate() {
		return importDate;
	}

	public void setImportDate(Date importDate) {
		this.importDate = importDate;
	}

	public Supplier6 getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier6 supplier) {
		this.supplier = supplier;
	}

	public WarehouseStaff6 getWarehouseStaff() {
		return warehouseStaff;
	}

	public void setWarehouseStaff(WarehouseStaff6 warehouseStaff) {
		this.warehouseStaff = warehouseStaff;
	}

	public ArrayList<ImportOrderDetail6> getListDetail() {
		return listDetail;
	}

	public void setListDetail(ArrayList<ImportOrderDetail6> listDetail) {
		this.listDetail = listDetail;
	}

	// thuoc tinh dan xuat, khong luu trong CSDL
	public float getTotalAmount() {
		float total = 0;
		for (ImportOrderDetail6 d : listDetail)
			total += d.getAmount();
		return total;
	}
}
