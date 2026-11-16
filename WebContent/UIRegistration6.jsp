<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.text.SimpleDateFormat,model.*"%>
<%@include file="escape.jsp"%>
<%
	// vao tu trang chu: xoa du lieu dang ki cu
	if (request.getParameter("new") != null) {
		session.removeAttribute("newCustomer");
		session.removeAttribute("regError");
	}
	// quay lai tu trang xac nhan hoac bi loi: dien lai thong tin da nhap
	Customer6 c = (Customer6) session.getAttribute("newCustomer");
	String err = (String) session.getAttribute("regError");
	session.removeAttribute("regError");
	String dob = "";
	if (c != null && c.getDateOfBirth() != null)
		dob = new SimpleDateFormat("yyyy-MM-dd").format(c.getDateOfBirth());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member registration</title>
</head>
<body>
	<h2>Member registration</h2>
	<% if (err != null) { %>
	<p style="color: red"><%=esc(err)%></p>
	<% } %>
	<form action="UIConfirm6.jsp" method="post">
		<table>
			<tr>
				<td>Full name:</td>
				<td><input type="text" name="name" value="<%=c != null ? esc(c.getFullName()) : ""%>" required /></td>
			</tr>
			<tr>
				<td>Date of birth:</td>
				<td><input type="date" name="dob" value="<%=dob%>" required /></td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><input type="text" name="address" value="<%=c != null ? esc(c.getAddress()) : ""%>" required /></td>
			</tr>
			<tr>
				<td>Phone:</td>
				<td><input type="text" name="phone" value="<%=c != null ? esc(c.getPhone()) : ""%>" required /></td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input type="email" name="email" value="<%=c != null ? esc(c.getEmail()) : ""%>" required /></td>
			</tr>
			<tr>
				<td>Username:</td>
				<td><input type="text" name="username" value="<%=c != null ? esc(c.getUsername()) : ""%>" required /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="password" required /></td>
			</tr>
			<tr>
				<td>Confirm password:</td>
				<td><input type="password" name="confirmPassword" required /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Add" /></td>
			</tr>
		</table>
	</form>
	<p><a href="UIHome6.jsp">Back to home</a></p>
</body>
</html>
