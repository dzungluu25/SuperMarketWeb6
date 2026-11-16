<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.Date,dao.*,model.*"%>
<%
	WarehouseStaff6 ws = (WarehouseStaff6) session.getAttribute("warehouseStaff");
	if (ws == null) {
		response.sendRedirect("../UILogin6.jsp?err=timeout");
		return;
	}
	ImportOrder6 io = (ImportOrder6) session.getAttribute("importOrder");
	if (io == null) {
		response.sendRedirect("UIWarehouseHome6.jsp");
		return;
	}
	io.setImportDate(new Date());
	boolean ok = (new ImportOrderDAO6()).saveImport(io);
	if (ok) {
		session.removeAttribute("importOrder");
		session.removeAttribute("listItem");
		session.removeAttribute("listSupplier");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Save import order</title>
</head>
<body>
	<% if (ok) { %>
	<script type="text/javascript">
		alert("Goods imported successfully!");
		window.location = "UIWarehouseHome6.jsp";
	</script>
	<% } else { %>
	<script type="text/javascript">
		alert("Could not save the import order, please try again!");
		window.location = "UIImport6.jsp";
	</script>
	<% } %>
</body>
</html>
