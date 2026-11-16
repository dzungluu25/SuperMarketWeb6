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

