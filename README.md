# Online Supermarket Management System (Project 07)

Course project for **Analysis and Design of Information Systems**, PTIT.

- Student: Luu Anh Dung
- Project code: 07
- Class name suffix: `6`

## Implemented modules

1. **Customer registers as a member**: Home → Registration form → Confirm information → save customer.
2. **Warehouse staff imports goods from suppliers**: Login → Warehouse home → search and select supplier → search items and add quantity and import price (repeat) → Submit → save the import order and update stock.

## Technology (MVC on J2EE)

| Layer | Content |
|---|---|
| View | `WebContent/UI*.jsp` (customer and shared pages), `WebContent/nvkho/UI*.jsp` (warehouse staff pages) |
| Controller | `WebContent/do*.jsp`, `WebContent/nvkho/do*.jsp` |
| Model | `src/model` (entity classes), `src/dao` (data access classes, JDBC) |
| Database | MySQL 8.0, script `database/supermarket6.sql` (tables, stored procedures, sample data) |

The application runs on Apache Tomcat 9 with JDK 17 and uses MySQL Connector/J 8.4.0.

## Project structure

```
database/supermarket6.sql      tables, stored procedures, sample data
src/model/                     Member6, Customer6, Staff6, WarehouseStaff6,
                               ItemCategory6, Item6, Supplier6,
                               ImportOrder6, ImportOrderDetail6
src/dao/                       DAO6, MemberDAO6, CustomerDAO6, SupplierDAO6,
                               ItemDAO6, ImportOrderDAO6
WebContent/                    UIHome6, UIRegistration6, UIConfirm6, doAddCustomer6,
                               UILogin6, doLogin6
WebContent/nvkho/              UIWarehouseHome6, UISearchSupplier6, UIImport6, doSaveImport6
docs/                          UI design images and PlantUML source of the design diagrams
```

## Run with Docker

```bash
docker compose up -d --build
```

Then open http://localhost:8080

- MySQL is published on host port `3307` (user `root`, password `123456`).
- To reset the database: `docker compose down -v`, then run the command above again.

## Sample accounts (password `123456`)

| Role | Username |
|---|---|
| Warehouse staff | `kho1`, `kho2`, `kho3`, `kho4` |
| Customer (for testing duplicate username / phone / email on registration) | `khach1` … `khach5` |

Supplier search examples: `Anh`, `Van A`. Item search examples: `Fish`, `Milk`.
