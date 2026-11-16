DROP DATABASE IF EXISTS supermarket6;
CREATE DATABASE supermarket6 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE supermarket6;

-- ===== Thanh vien va cac lop ke thua (moi lop 1 bang, bang con dung chung khoa voi bang cha) =====
CREATE TABLE tblMember6 (
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
	fullName VARCHAR(255) NOT NULL,
	address VARCHAR(255),
	phone VARCHAR(20) UNIQUE,
	email VARCHAR(255) UNIQUE,
	registerDate DATE,
	status VARCHAR(50)
);

CREATE TABLE tblCustomer6 (
	tblMember6id INT PRIMARY KEY,
	dateOfBirth DATE,
	FOREIGN KEY (tblMember6id) REFERENCES tblMember6(id)
);

CREATE TABLE tblStaff6 (
	tblMember6id INT PRIMARY KEY,
	staffCode VARCHAR(20),
	position VARCHAR(100),
	startDate DATE,
	FOREIGN KEY (tblMember6id) REFERENCES tblMember6(id)
);

CREATE TABLE tblWarehouseStaff6 (
	tblStaff6id INT PRIMARY KEY,
	FOREIGN KEY (tblStaff6id) REFERENCES tblStaff6(tblMember6id)
);

-- ===== Hang hoa, nha cung cap =====
CREATE TABLE tblCategory6 (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	description VARCHAR(255)
);

CREATE TABLE tblItem6 (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	unit VARCHAR(50),
	price DECIMAL(15,2),
	stockQuantity INT DEFAULT 0,
	description VARCHAR(255),
	status VARCHAR(50),
	tblCategory6id INT,
	FOREIGN KEY (tblCategory6id) REFERENCES tblCategory6(id)
);

CREATE TABLE tblSupplier6 (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	address VARCHAR(255),
	phone VARCHAR(20),
	email VARCHAR(255),
	description VARCHAR(255)
);

-- ===== Nhap hang (amount, totalAmount la thuoc tinh dan xuat nen khong luu) =====
CREATE TABLE tblImportOrder6 (
	id INT AUTO_INCREMENT PRIMARY KEY,
	importDate DATE NOT NULL,
	tblSupplier6id INT NOT NULL,
	tblWarehouseStaff6id INT NOT NULL,
	FOREIGN KEY (tblSupplier6id) REFERENCES tblSupplier6(id),
	FOREIGN KEY (tblWarehouseStaff6id) REFERENCES tblWarehouseStaff6(tblStaff6id)
);

CREATE TABLE tblImportOrderDetail6 (
	id INT AUTO_INCREMENT PRIMARY KEY,
	quantity INT NOT NULL,
	importPrice DECIMAL(15,2) NOT NULL,
	tblImportOrder6id INT NOT NULL,
	tblItem6id INT NOT NULL,
	FOREIGN KEY (tblImportOrder6id) REFERENCES tblImportOrder6(id),
	FOREIGN KEY (tblItem6id) REFERENCES tblItem6(id)
);

