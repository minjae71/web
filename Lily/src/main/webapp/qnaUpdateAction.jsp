<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.QnaManager" %> <!-- qnadao의 클래스 가져옴 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QnA 글쓰기</title>
</head>
<body>
<%
	QnaManager QnaMgr = new QnaManager();
	boolean result = QnaMgr.updateQna(request);
	if(result) {
%>
		<script>
			alert("게시글이 수정되었습니다.");
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
%>
</body>
</html>