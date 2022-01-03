<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.QnaManager" %> <!-- qnadao의 클래스 가져옴 -->
<%@ page import="board.QnaBean" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QnA 글쓰기</title>
</head>
<body>
<%
	String userID = (String)session.getAttribute("ID");
	
	int no = 0;
	int ref = Integer.parseInt(request.getParameter("ref"));
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	if(userID == null)
	{
		%>
		<script>
			alert("로그인 정보가 없습니다.");
			location.href="login.jsp";
		</script>
		<%
	}
	if(request.getParameter("no") != null) {
		no = Integer.parseInt(request.getParameter("no"));
	}
	if(no==0)
	{
		%>
		<script>
			alert("유효하지 않은 글입니다.");
			location.href="qna.jsp";
		</script>
		<%
	} else {
		QnaManager QnaMgr = new QnaManager();
		int updateResult = QnaMgr.reWriteUpdate(ref, re_level);
		if(updateResult==-1)
		{
			%>
			<script>
				alert("오류가 발생하였습니다.-1");
				location.href="qna.jsp";
			</script>
			<%
		}
		
		QnaBean qna = QnaMgr.getQna(no);
		
		ref = qna.getRef();
		re_step = qna.getRe_step();
		re_level = qna.getRe_level();
		
		boolean result = QnaMgr.reInsertQna(request, ref, re_step, re_level);
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