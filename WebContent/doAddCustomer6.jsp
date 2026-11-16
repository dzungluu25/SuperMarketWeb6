<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="dao.*,model.*"%>
<%
	Customer6 c = (Customer6) session.getAttribute("newCustomer");
	if (c == null) {
		response.sendRedirect("UIHome6.jsp");
		return;
	}
	CustomerDAO6 dao = new CustomerDAO6();
	// trung ten dang nhap / so dien thoai / email: quay lai form de sua
	String err = dao.checkExisted(c);
	if (err != null) {
		session.setAttribute("regError", err);
		response.sendRedirect("UIRegistration6.jsp");
		return;
	}
	boolean ok = dao.addCustomer(c);
	if (ok)
		session.removeAttribute("newCustomer");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
	<% if (ok) { %>
	<script type="text/javascript">
		alert("Registered successfully!");
		window.location = "UIHome6.jsp";
	</script>
	<% } else { %>
	<script type="text/javascript">
		alert("Could not save your information, please try again!");
		window.location = "UIConfirm6.jsp";
	</script>
	<% } %>
</body>
</html>
