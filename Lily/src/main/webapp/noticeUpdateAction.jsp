<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.NoticeManager" %> <!-- qnadao의 클래스 가져옴 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Q&A</title>
</head>
<body>
<%
	NoticeManager NoticeMgr = new NoticeManager();
	boolean result = NoticeMgr.updateNotice(request);
	if(result) {
%>
		<script>
			alert("게시글이 수정되었습니다.");
			location.href = "notice.jsp";
		</script>
<%
	} else {
%>
		<script>
			alert("오류가 발생하였습니다.");
			location.href = "notice.jsp";
		</script>
<%
	}
%>
</body>
</html>