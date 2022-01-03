<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.QnaManager" %> <!-- qnadao의 클래스 가져옴 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QnA</title>
</head>
<body>
<%
	String u_id = (String)session.getAttribute("ID");
	if (u_id==null) {
%>
		<script>
			alert("로그인 후 글쓰기가 가능합니다.");
			location.href="index.jsp";
		</script>
<%
	} else {
		QnaManager QnaMgr = new QnaManager();
		boolean result = QnaMgr.insertQna(request);
		if(result) {
	%>
			<script>
				alert("게시글이 등록되었습니다.");
				location.href = "qna.jsp";
			</script>
	<%
		} else {
	%>
			<script>
				alert("오류가 발생하였습니다.");
				location.href = "qna.jsp";
			</script>
	<%
		}
	}
%>
</body>
</html>