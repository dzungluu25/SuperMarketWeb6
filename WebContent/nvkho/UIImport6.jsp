<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%@include file="../escape.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	WarehouseStaff6 ws = (WarehouseStaff6) session.getAttribute("warehouseStaff");
	if (ws == null) {
		response.sendRedirect("../UILogin6.jsp?err=timeout");
		return;
	}

	String msg = null;
	String keyword = request.getParameter("keyword");
	String action = request.getParameter("action");

	if (request.getParameter("idSupplier") != null) {
		// goi tu trang tim nha cung cap: tao phieu nhap moi voi nha cung cap da chon
		int idSupplier = Integer.parseInt(request.getParameter("idSupplier"));
		ArrayList<Supplier6> listSupplier = (ArrayList<Supplier6>) session.getAttribute("listSupplier");
		Supplier6 chosen = null;
		if (listSupplier != null)
			for (Supplier6 s : listSupplier)
				if (s.getId() == idSupplier)
					chosen = s;
		if (chosen == null) {
			response.sendRedirect("UISearchSupplier6.jsp");
			return;
		}
		ImportOrder6 io = new ImportOrder6();
		io.setSupplier(chosen);
		io.setWarehouseStaff(ws);
		session.setAttribute("importOrder", io);
		session.removeAttribute("listItem");
	}

	ImportOrder6 io = (ImportOrder6) session.getAttribute("importOrder");
	if (io == null) {
		response.sendRedirect("UISearchSupplier6.jsp");
		return;
	}

	if ("search".equals(action) && keyword != null) {
		// tim mat hang theo ten
		ArrayList<Item6> listItem = (new ItemDAO6()).searchItem(keyword.trim());
		session.setAttribute("listItem", listItem);
		if (listItem.size() == 0)
			msg = "No item found.";
	} else if ("add".equals(action)) {
		// them 1 dong vao phieu nhap
		ArrayList<Item6> listItem = (ArrayList<Item6>) session.getAttribute("listItem");
		try {
			int idItem = Integer.parseInt(request.getParameter("idItem"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			float price = Float.parseFloat(request.getParameter("price"));
			if (quantity <= 0 || price < 0)
				throw new NumberFormatException();
			Item6 item = null;
			if (listItem != null)
				for (Item6 it : listItem)
					if (it.getId() == idItem)
						item = it;
			if (item != null) {
				ImportOrderDetail6 existed = null;
				for (ImportOrderDetail6 d : io.getListDetail())
					if (d.getItem().getId() == idItem)
						existed = d;
				if (existed != null) {
					// mat hang da co trong phieu: cong them so luong, cap nhat don gia
					existed.setQuantity(existed.getQuantity() + quantity);
					existed.setImportPrice(price);
				} else {
					ImportOrderDetail6 d = new ImportOrderDetail6();
					d.setItem(item);
					d.setQuantity(quantity);
					d.setImportPrice(price);
					io.getListDetail().add(d);
				}
				session.removeAttribute("listItem");
			}
			// tranh them trung khi tai lai trang
			response.sendRedirect("UIImport6.jsp");
			return;
		} catch (NumberFormatException e) {
			msg = "Quantity must be greater than 0 and price must not be negative!";
		}
	}
	ArrayList<Item6> listItem = (ArrayList<Item6>) session.getAttribute("listItem");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Import order</title>
<link rel="stylesheet" href="../style.css">
</head>
<body>
	<div class="box wide">
	<h2>Import order</h2>
	<p class="info">Supplier: <b><%=esc(io.getSupplier().getName())%></b> - <%=esc(io.getSupplier().getAddress())%></p>
	<p class="info">Warehouse staff: <b><%=esc(ws.getFullName())%></b></p>
	<% if (msg != null) { %>
	<p class="error"><%=esc(msg)%></p>
	<% } %>

	<div class="search">
		<form action="UIImport6.jsp" method="get">
			<input type="hidden" name="action" value="search" />
			Item name: <input type="text" name="keyword" value="<%=esc(keyword)%>" required />
			<input type="submit" value="Search" />
		</form>
	</div>

	<% if (listItem != null && listItem.size() > 0) { %>
	<h3>Search results</h3>
	<table class="list">
		<tr>
			<th>Id</th><th>Name</th><th>Unit</th><th>In stock</th><th>Quantity</th><th>Import price</th><th></th>
		</tr>
		<% for (Item6 it : listItem) { %>
		<tr>
			<td><%=it.getId()%></td>
			<td><%=esc(it.getName())%></td>
			<td><%=esc(it.getUnit())%></td>
			<td><%=it.getStockQuantity()%></td>
			<td><input type="number" name="quantity" min="1" required form="add<%=it.getId()%>" /></td>
			<td><input type="number" name="price" min="0" step="any" required form="add<%=it.getId()%>" /></td>
			<td>
				<form id="add<%=it.getId()%>" action="UIImport6.jsp" method="post">
					<input type="hidden" name="action" value="add" />
					<input type="hidden" name="idItem" value="<%=it.getId()%>" />
					<input type="submit" value="Add" />
				</form>
			</td>
		</tr>
		<% } %>
	</table>
	<% } %>

	<h3>Imported items</h3>
	<table class="list">
		<tr>
			<th>No.</th><th>Item</th><th>Unit</th><th>Quantity</th><th>Unit price</th><th>Amount</th>
		</tr>
		<% int i = 0;
		for (ImportOrderDetail6 d : io.getListDetail()) { %>
		<tr>
			<td><%=++i%></td>
			<td><%=esc(d.getItem().getName())%></td>
			<td><%=esc(d.getItem().getUnit())%></td>
			<td class="num"><%=d.getQuantity()%></td>
			<td class="num"><%=String.format("%,.0f", d.getImportPrice())%></td>
			<td class="num"><%=String.format("%,.0f", d.getAmount())%></td>
		</tr>
		<% } %>
		<% if (io.getListDetail().size() == 0) { %>
		<tr><td colspan="6" class="notice">No item added yet.</td></tr>
		<% } %>
	</table>
	<p class="total">Total amount: <b><%=String.format("%,.0f", io.getTotalAmount())%></b></p>

	<div class="actions">
		<form action="UISearchSupplier6.jsp" method="get">
			<input type="submit" value="Back" />
		</form>
		<form action="doSaveImport6.jsp" method="post">
			<input type="submit" value="Submit" <%=io.getListDetail().size() == 0 ? "disabled" : ""%> />
		</form>
		<form action="UIWarehouseHome6.jsp" method="get">
			<input type="submit" value="Cancel" />
		</form>
	</div>
	</div>
</body>
</html>
