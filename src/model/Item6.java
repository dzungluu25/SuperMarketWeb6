package model;

import java.io.Serializable;

public class Item6 implements Serializable {
	private int id;
	private String name;
	private String unit;
	private float price;
	private int stockQuantity;
	private String description;
	private String status;
	private ItemCategory6 category;

	public Item6() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public int getStockQuantity() {
		return stockQuantity;
	}

	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public ItemCategory6 getCategory() {
		return category;
	}

	public void setCategory(ItemCategory6 category) {
		this.category = category;
	}
}
