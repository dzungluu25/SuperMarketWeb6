# Online Supermarket Management System

Web application built with JSP and JDBC following the MVC model on J2EE.

## Features

- **Register as a member:** customer fills in the registration form, confirms the information, and the account is saved.
- **Import goods from suppliers:** warehouse staff logs in, selects a supplier, adds items with quantity and import price, then submits; the import order is saved and stock is updated.

## Structure

```
database/       MySQL script (tables, stored procedures, data)
src/model/      entity classes
src/dao/        data access classes
WebContent/     JSP pages (nvkho/ for warehouse staff)
docs/           UI design and PlantUML diagrams
```

## Run

```bash
docker compose up -d --build
```

Open http://localhost:8080
