<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.NoticeManager" %> <!-- qnadao의 클래스 가져옴 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Notice</title>
</head>
<body>
<%
	String u_id = (String)session.getAttribute("ID");
	if (!u_id.equals("admin")) {
%>
		<script>
			alert("작성 권한이 없습니다.");
			location.href="index.jsp";
		</script>
<%
	} else {
		NoticeManager NoticeMgr = new NoticeManager();
		boolean result = NoticeMgr.insertNotice(request);
		if(result) {
%>
			<script>
				alert("게시글이 등록되었습니다.");
				location.href="notice.jsp";
			</script>
<%
		} else {
%>
			<script>
				alert("오류가 발생하였습니다.");
				location.href="notice.jsp";
			</script>
<%
		}
	}
%>
</body>
</html>