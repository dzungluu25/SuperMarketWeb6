<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="dao.*,model.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	Member6 m = new Member6();
	m.setUsername(request.getParameter("username"));
	m.setPassword(request.getParameter("password"));

	boolean kq = (new MemberDAO6()).checkLogin(m);
	if (!kq) {
		response.sendRedirect("UILogin6.jsp?err=fail");
	} else if ("warehouse".equalsIgnoreCase(m.getRole())) {
		WarehouseStaff6 ws = new WarehouseStaff6();
		ws.setId(m.getId());
		ws.setUsername(m.getUsername());
		ws.setFullName(m.getFullName());
		ws.setRole(m.getRole());
		session.setAttribute("warehouseStaff", ws);
		response.sendRedirect("nvkho/UIWarehouseHome6.jsp");
	} else {
		// cac vai tro khac nam ngoai pham vi 2 module
		response.sendRedirect("UILogin6.jsp?err=role");
	}
%>
