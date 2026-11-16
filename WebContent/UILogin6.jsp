<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="box">
		<h2>Login</h2>
		<%
			// dang xuat: xoa thong tin nhan vien kho trong session
			if (request.getParameter("logout") != null)
				session.invalidate();
			String err = request.getParameter("err");
			if ("timeout".equalsIgnoreCase(err)) {
		%>
		<p class="notice">Session expired. Please log in again!</p>
		<% } else if ("fail".equalsIgnoreCase(err)) { %>
		<p class="error">Wrong username or password!</p>
		<% } else if ("role".equalsIgnoreCase(err)) { %>
		<p class="error">This account is not allowed to import goods!</p>
		<% } %>
		<form id="loginForm" action="doLogin6.jsp" method="post">
			<table class="form">
				<tr>
					<td>Username:</td>
					<td><input type="text" name="username" required /></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type="password" name="password" required /></td>
				</tr>
			</table>
		</form>
		<div class="actions">
			<form action="UIHome6.jsp" method="get">
				<input type="submit" value="Back" />
			</form>
			<input type="submit" value="Login" form="loginForm" />
		</div>
	</div>
</body>
</html>
