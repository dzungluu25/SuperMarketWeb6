# Online Supermarket Management System

A web application for an online supermarket, built with JSP and JDBC following the MVC model on J2EE.

## Features

**Customer registers as a member**
Home → registration form → confirm information → the system checks for duplicate username, phone and email, then saves the customer.

**Warehouse staff imports goods from suppliers**
Login → warehouse staff home → search and select a supplier → search items and enter quantity and import price (repeat for every item) → Submit → the system saves the import order with its details and updates the stock quantity.

## Technology

| Layer | Content |
|---|---|
| View | `WebContent/UI*.jsp`, `WebContent/nvkho/UI*.jsp` |
| Controller | `WebContent/do*.jsp`, `WebContent/nvkho/do*.jsp` |
| Model | `src/model` (entity classes), `src/dao` (data access classes) |
| Database | MySQL 8.0: tables, stored procedures, sample data |

Runtime: Apache Tomcat 9, JDK 17, MySQL Connector/J 8.4.0.

## Project structure

```
database/supermarket6.sql      tables, stored procedures, sample data
src/model/                     Member6, Customer6, Staff6, WarehouseStaff6,
                               ItemCategory6, Item6, Supplier6,
                               ImportOrder6, ImportOrderDetail6
src/dao/                       DAO6, MemberDAO6, CustomerDAO6, SupplierDAO6,
                               ItemDAO6, ImportOrderDAO6
WebContent/                    UIHome6, UIRegistration6, UIConfirm6, doAddCustomer6,
                               UILogin6, doLogin6, style.css
WebContent/nvkho/              UIWarehouseHome6, UISearchSupplier6, UIImport6, doSaveImport6
docs/                          UI design images and PlantUML diagrams
```

## Run with Docker

```bash
docker compose up -d --build
```

Open http://localhost:8080

- Stop: `docker compose down`
- Reset the database to the sample data: `docker compose down -v`, then run the command above again.
- MySQL is available on host port `3307` (user `root`, password `123456`).

## Sample accounts

Password for all accounts: `123456`

| Role | Username |
|---|---|
| Warehouse staff | `kho1`, `kho2`, `kho3`, `kho4` |
| Customer | `khach1` … `khach5` |

Search examples: supplier `Anh`, `Van A`; item `Fish`, `Milk`.
