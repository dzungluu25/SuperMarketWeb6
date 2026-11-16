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
</head>
<body>
	<h2>Warehouse staff home</h2>
	<p>Hello: <%=esc(ws.getFullName())%></p>
	<form action="UISearchSupplier6.jsp" method="get">
		<input type="submit" value="Import goods" />
	</form>
</body>
</html>
