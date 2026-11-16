<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.*"%>
<%@include file="../escape.jsp"%>
<%
	WarehouseStaff6 ws = (WarehouseStaff6) session.getAttribute("warehouseStaff");
	if (ws == null) {
		response.sendRedirect("../UILogin6.jsp?err=timeout");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Warehouse staff home</title>
<link rel="stylesheet" href="../style.css">
</head>
<body>
	<div class="box">
		<h2>Warehouse staff home</h2>
		<p class="notice">Warehouse staff: <b><%=esc(ws.getFullName())%></b></p>
		<div class="actions">
			<form action="../UILogin6.jsp" method="get">
				<input type="hidden" name="logout" value="1" />
				<input type="submit" value="Logout" />
			</form>
			<form action="UISearchSupplier6.jsp" method="get">
				<input type="submit" value="Import goods" />
			</form>
		</div>
	</div>
</body>
</html>
