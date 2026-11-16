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
	String keyword = request.getParameter("keyword");
	ArrayList<Supplier6> listSupplier = null;
	if (keyword != null) {
		listSupplier = (new SupplierDAO6()).searchSupplier(keyword.trim());
		session.setAttribute("listSupplier", listSupplier);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search supplier</title>
<link rel="stylesheet" href="../style.css">
</head>
<body>
	<div class="box wide">
	<h2>Search supplier</h2>
	<div class="search">
		<form action="UISearchSupplier6.jsp" method="get">
			Supplier name: <input type="text" name="keyword" value="<%=esc(keyword)%>" required />
			<input type="submit" value="Search" />
		</form>
		<form action="UIWarehouseHome6.jsp" method="get">
			<input type="submit" value="Back" />
		</form>
	</div>

	<% if (listSupplier != null && listSupplier.size() == 0) { %>
	<p class="error">No supplier found.</p>
	<% } else if (listSupplier != null) { %>
	<table class="list">
		<tr>
			<th>Id</th><th>Name</th><th>Address</th><th>Phone</th><th>Email</th><th></th>
		</tr>
		<% for (Supplier6 s : listSupplier) { %>
		<tr>
			<td><%=s.getId()%></td>
			<td><%=esc(s.getName())%></td>
			<td><%=esc(s.getAddress())%></td>
			<td><%=esc(s.getPhone())%></td>
			<td><%=esc(s.getEmail())%></td>
			<td><a href="UIImport6.jsp?idSupplier=<%=s.getId()%>">Select</a></td>
		</tr>
		<% } %>
	</table>
	<% } %>
	</div>
</body>
</html>
