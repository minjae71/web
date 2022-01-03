<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>로그아웃</title>
</head>
<body>
<%
	String id = (String)session.getAttribute("ID");
	if(id!=null) {
		session.invalidate();
%>
		<script>
			alert("로그아웃 되었습니다.");
			location.href="index.jsp";
		</script>
<%
	} else {
%>
		<script>
			alert("이미 로그아웃된 상태입니다!");
			location.href="index.jsp";
		</script>
<%
	}
%>
</body>
</html>