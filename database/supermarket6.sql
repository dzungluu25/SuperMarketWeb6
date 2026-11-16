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

-- ===== Stored procedures =====
DELIMITER $$

CREATE PROCEDURE checkLogin6(IN usr VARCHAR(255), IN pwd VARCHAR(255))
BEGIN
	SELECT m.*,
		CASE
			WHEN w.tblStaff6id IS NOT NULL THEN 'warehouse'
			WHEN c.tblMember6id IS NOT NULL THEN 'customer'
			ELSE 'staff'
		END AS role
	FROM tblMember6 m
	LEFT JOIN tblCustomer6 c ON c.tblMember6id = m.id
	LEFT JOIN tblWarehouseStaff6 w ON w.tblStaff6id = m.id
	WHERE m.username = usr AND m.password = pwd;
END$$

CREATE PROCEDURE searchSupplier6(IN keyword VARCHAR(255))
BEGIN
	SELECT * FROM tblSupplier6
	WHERE name LIKE CONCAT('%', keyword, '%')
	ORDER BY name;
END$$

CREATE PROCEDURE searchItem6(IN keyword VARCHAR(255))
BEGIN
	SELECT * FROM tblItem6
	WHERE name LIKE CONCAT('%', keyword, '%')
	ORDER BY name;
END$$

DELIMITER ;

-- ===== Du lieu mau =====
-- Thanh vien: id 1-4 la nhan vien kho, id 5-9 la khach hang, id 10-14 la khach hang trung ten (mat khau mau: 123456)
INSERT INTO tblMember6(username, password, fullName, address, phone, email, registerDate, status) VALUES
('kho1', '123456', 'Nguyen Van A', 'Ha Noi', '0900000001', 'kho1@supermarket.com', '2024-01-01', 'active'),
('kho4', '123456', 'Nguyen Binh A', 'Ha Noi', '0900000004', 'kho4@supermarket.com', '2024-01-05', 'active'),
('kho2', '123456', 'Tran Thi B', 'Ha Noi', '0900000002', 'kho2@supermarket.com', '2024-02-15', 'active'),
('kho3', '123456', 'Le Van C', 'Hai Phong', '0900000003', 'kho3@supermarket.com', '2024-03-10', 'active'),
('khach1', '123456', 'Pham Minh D', 'Ha Noi', '0911000001', 'khach1@gmail.com', '2024-04-01', 'active'),
('khach2', '123456', 'Hoang Thi E', 'Da Nang', '0911000002', 'khach2@gmail.com', '2024-04-12', 'active'),
('khach3', '123456', 'Vu Van F', 'Ho Chi Minh', '0911000003', 'khach3@gmail.com', '2024-05-20', 'active'),
('khach4', '123456', 'Do Thi G', 'Hue', '0911000004', 'khach4@gmail.com', '2024-06-05', 'active'),
('khach5', '123456', 'Bui Van H', 'Can Tho', '0911000005', 'khach5@gmail.com', '2024-07-18', 'active');

INSERT INTO tblStaff6(tblMember6id, staffCode, position, startDate) VALUES
(1, 'NV001', 'Nhan vien kho', '2024-01-01'),
(2, 'NV004', 'Nhan vien kho', '2024-01-05'),
(3, 'NV002', 'Nhan vien kho', '2024-02-15'),
(4, 'NV003', 'Nhan vien kho', '2024-03-10');
INSERT INTO tblWarehouseStaff6(tblStaff6id) VALUES (1), (2), (3), (4);

INSERT INTO tblCustomer6(tblMember6id, dateOfBirth) VALUES
(5, '2000-05-10'), (6, '1999-11-21'), (7, '2001-03-02'), (8, '1998-08-15'), (9, '2002-12-30');

INSERT INTO tblCategory6(name, description) VALUES
('Thuc pham', 'Do an tuoi song'),
('Do uong', 'Nuoc giai khat, sua, nuoc ep'),
('Hai san', 'Ca, tom, muc'),
('Rau cu', 'Rau cu qua tuoi'),
('Gia vi', 'Gia vi va do kho'),
('Do gia dung', 'Vat dung trong gia dinh');

INSERT INTO tblItem6(name, unit, price, stockQuantity, description, status, tblCategory6id) VALUES
('Sea Fish', 'Kg', 120000, 50, 'Ca bien', 'active', 3),
('Gold Fish', 'Kg', 90000, 30, 'Ca vang', 'active', 3),
('Salmon Fish', 'Kg', 350000, 20, 'Ca hoi nhap khau', 'active', 3),
('Fish Sauce', 'Chai', 45000, 80, 'Nuoc mam', 'active', 5),
('Fresh Milk', 'Hop', 30000, 150, 'Sua tuoi', 'active', 2),
('Orange Juice', 'Chai', 25000, 100, 'Nuoc cam ep', 'active', 2),
('Mineral Water', 'Chai', 8000, 300, 'Nuoc khoang', 'active', 2),
('Tomato', 'Kg', 30000, 60, 'Ca chua', 'active', 4),
('Cabbage', 'Kg', 20000, 45, 'Bap cai', 'active', 4),
('Potato', 'Kg', 25000, 70, 'Khoai tay', 'active', 4),
('Rice', 'Kg', 18000, 500, 'Gao thom', 'active', 1),
('Egg', 'Vi', 35000, 120, 'Trung ga (10 qua)', 'active', 1),
('Chicken', 'Kg', 95000, 40, 'Ga ta', 'active', 1),
('Beef', 'Kg', 280000, 25, 'Thit bo', 'active', 1),
('Salt', 'Goi', 7000, 200, 'Muoi i-ot', 'active', 5),
('Dish Soap', 'Chai', 32000, 90, 'Nuoc rua chen', 'active', 6),
('Towel', 'Cai', 40000, 60, 'Khan tam', 'inactive', 6);

INSERT INTO tblSupplier6(name, address, phone, email, description) VALUES
('Nguyen Anh', 'Tran Phu, Ha Noi', '012345678', 'anhsupplier@gmail.com', 'Cung cap hai san'),
('Tran Binh', 'Cau Giay, Ha Noi', '098765432', 'binhsupplier@gmail.com', 'Cung cap sua'),
('Le Hoa Farm', 'Da Lat, Lam Dong', '0263111222', 'hoafarm@gmail.com', 'Rau cu sach'),
('Anh Duong Food', 'Thanh Xuan, Ha Noi', '0243555666', 'duongfood@gmail.com', 'Thuc pham, gia vi'),
('Viet Beverage', 'Ba Dinh, Ha Noi', '0243777888', 'vietbev@gmail.com', 'Nuoc giai khat'),
('Sao Mai Meat', 'Long Bien, Ha Noi', '0243999000', 'saomai@gmail.com', 'Thit, trung'),
('Hai Long Home', 'Hai Phong', '0225123456', 'hailong@gmail.com', 'Do gia dung');

-- Nha cung cap trung ten / giong ten (de thu tim kiem theo ten)
INSERT INTO tblSupplier6(name, address, phone, email, description) VALUES
('Nguyen Van A', 'Dong Da, Ha Noi', '0901111001', 'nguyenvana1@gmail.com', 'Cung cap hai san'),
('Nguyen Van A', 'Quan 1, Ho Chi Minh', '0901111002', 'nguyenvana2@gmail.com', 'Cung cap rau cu'),
('Tran Van A', 'Hai Chau, Da Nang', '0901111003', 'tranvana@gmail.com', 'Cung cap sua'),
('Le Van A', 'Ninh Kieu, Can Tho', '0901111004', 'levana@gmail.com', 'Cung cap gia vi'),
('Pham Van A', 'Hue', '0901111005', 'phamvana@gmail.com', 'Cung cap do uong'),
('Nguyen Van B', 'Cau Giay, Ha Noi', '0901111006', 'nguyenvanb@gmail.com', 'Cung cap thit');

-- Khach hang trung ten / giong ten (username, so dien thoai, email van khac nhau)
INSERT INTO tblMember6(username, password, fullName, address, phone, email, registerDate, status) VALUES
('nguyenvana1', '123456', 'Nguyen Van A', 'Ha Noi', '0922000001', 'nguyenvana1@mail.com', '2024-08-10', 'active'),
('nguyenvana2', '123456', 'Nguyen Van A', 'Hai Phong', '0922000002', 'nguyenvana2@mail.com', '2024-08-11', 'active'),
('tranvana', '123456', 'Tran Van A', 'Da Nang', '0922000003', 'tranvana@mail.com', '2024-08-12', 'active'),
('levana', '123456', 'Le Van A', 'Hue', '0922000004', 'levana@mail.com', '2024-08-13', 'active'),
('tranvanb', '123456', 'Tran Van B', 'Ho Chi Minh', '0922000005', 'tranvanb@mail.com', '2024-08-14', 'active');
INSERT INTO tblCustomer6(tblMember6id, dateOfBirth) VALUES
(10, '1997-01-15'), (11, '1996-06-20'), (12, '1995-09-09'), (13, '2000-02-28'), (14, '1999-12-12');

-- Mat hang giong ten
INSERT INTO tblItem6(name, unit, price, stockQuantity, description, status, tblCategory6id) VALUES
('Fresh Milk', 'Chai', 28000, 80, 'Sua tuoi chai thuy tinh', 'active', 2),
('Fresh Milk Sweet', 'Hop', 32000, 90, 'Sua tuoi co duong', 'active', 2),
('Sea Fish Fillet', 'Kg', 180000, 15, 'Phi le ca bien', 'active', 3);

-- Phieu nhap mau (2 phieu, tong tinh tu cac dong chi tiet)
INSERT INTO tblImportOrder6(importDate, tblSupplier6id, tblWarehouseStaff6id) VALUES
('2024-08-01', 1, 1),
('2024-08-05', 2, 2);

INSERT INTO tblImportOrderDetail6(quantity, importPrice, tblImportOrder6id, tblItem6id) VALUES
(20, 100000, 1, 1),
(10, 70000, 1, 2),
(100, 22000, 2, 5);
