<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<%
		String err = request.getParameter("err");
		if ("timeout".equalsIgnoreCase(err)) {
	%>
	<h4>Session expired. Please log in again!</h4>
	<% } else if ("fail".equalsIgnoreCase(err)) { %>
	<h4 style="color: red">Wrong username or password!</h4>
	<% } else if ("role".equalsIgnoreCase(err)) { %>
	<h4 style="color: red">This account is not allowed to import goods!</h4>
	<% } %>
	<h2>Login</h2>
	<form action="doLogin6.jsp" method="post">
		<table>
			<tr>
				<td>Username:</td>
				<td><input type="text" name="username" required /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="password" required /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Login" /></td>
			</tr>
		</table>
	</form>
</body>
</html>
