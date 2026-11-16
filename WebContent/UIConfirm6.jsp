<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.text.SimpleDateFormat,java.util.Date,model.*"%>
<%@include file="escape.jsp"%>
<%!
	String param(HttpServletRequest req, String name) {
		String v = req.getParameter(name);
		return v == null ? "" : v.trim();
	}
%>
<%
	request.setCharacterEncoding("UTF-8");
	Customer6 c = (Customer6) session.getAttribute("newCustomer");

	// goi tu form dang ki: dong goi thong tin va kiem tra du lieu nhap
	if (request.getParameter("username") != null) {
		c = new Customer6();
		c.setFullName(param(request, "name"));
		c.setAddress(param(request, "address"));
		c.setPhone(param(request, "phone"));
		c.setEmail(param(request, "email"));
		c.setUsername(param(request, "username"));
		c.setPassword(request.getParameter("password") == null ? "" : request.getParameter("password"));
		c.setRegisterDate(new Date());
		c.setStatus("active");
		String err = null;
		try {
			c.setDateOfBirth(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dob")));
		} catch (Exception e) {
			err = "Invalid date of birth!";
		}
		if (c.getFullName().isEmpty() || c.getUsername().isEmpty() || c.getPhone().isEmpty()
				|| c.getEmail().isEmpty() || c.getPassword().isEmpty())
			err = "Please fill in all required fields!";
		else if (!c.getPassword().equals(request.getParameter("confirmPassword")))
			err = "Password and confirm password do not match!";

		session.setAttribute("newCustomer", c);
		if (err != null) {
			session.setAttribute("regError", err);
			response.sendRedirect("UIRegistration6.jsp");
			return;
		}
	}
	if (c == null) {
		response.sendRedirect("UIHome6.jsp");
		return;
	}
	String dob = new SimpleDateFormat("dd/MM/yyyy").format(c.getDateOfBirth());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Confirm information</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="box">
	<h2>Confirm information</h2>
	<table class="form">
		<tr><td>Full name:</td><td><%=esc(c.getFullName())%></td></tr>
		<tr><td>Date of birth:</td><td><%=dob%></td></tr>
		<tr><td>Address:</td><td><%=esc(c.getAddress())%></td></tr>
		<tr><td>Phone:</td><td><%=esc(c.getPhone())%></td></tr>
		<tr><td>Email:</td><td><%=esc(c.getEmail())%></td></tr>
		<tr><td>Username:</td><td><%=esc(c.getUsername())%></td></tr>
	</table>
	<div class="actions">
		<form action="UIRegistration6.jsp" method="get">
			<input type="submit" value="Cancel" />
		</form>
		<form action="doAddCustomer6.jsp" method="post">
			<input type="submit" value="Confirm" />
		</form>
	</div>
	</div>
</body>
</html>
