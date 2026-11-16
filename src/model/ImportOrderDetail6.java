package model;

import java.io.Serializable;

public class ImportOrderDetail6 implements Serializable {
	private int id;
	private int quantity;
	private float importPrice;
	private Item6 item;

	public ImportOrderDetail6() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public float getImportPrice() {
		return importPrice;
	}

	public void setImportPrice(float importPrice) {
		this.importPrice = importPrice;
	}

	public Item6 getItem() {
		return item;
	}

	public void setItem(Item6 item) {
		this.item = item;
	}

	// thuoc tinh dan xuat, khong luu trong CSDL
	public float getAmount() {
		return quantity * importPrice;
	}
}
