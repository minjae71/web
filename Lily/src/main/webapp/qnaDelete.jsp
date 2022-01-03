<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.QnaBean" %>
<%@ page import="board.QnaManager" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>20172178</title>
</head>
<body>
<%
	String userID = (String)session.getAttribute("ID");
	if (userID==null) {
%>
		<script>
			alert("접근 권한이 없습니다.-1");
			location.href="qna.jsp";
		</script>
<%
	} else {
		int no = 0;
		if(request.getParameter("no") != null) {
			no = Integer.parseInt(request.getParameter("no"));
		}
		
		if(no == 0) {
%>
			<script>
				alert("유효하지 않은 글입니다.");
				location.href="qna.jsp";
			</script>
<%
		}
		QnaBean qna = new QnaManager().getQna(no);
		QnaManager QnaMgr = new QnaManager();
		if(!userID.equals("admin") && !userID.equals(qna.getWriter())) {
%>
			<script>
				alert("접근 권한이 없습니다.-2");
				location.href = "qna.jsp";
			</script>
<%
		} else {
			if(qna.getRe_step()!=1)
			{			
				int result = QnaMgr.deleteOne(no);
				if (result == -1) {
%>
					<script>
						alert("오류가 발생하였습니다.-1");
						history.back();
					</script>
<%
				} else {
%>
					<script>
						alert("삭제되었습니다.");
						location.href="qna.jsp";
					</script>
<%
				}
			} else {
				int ref = qna.getRef();
				int result = QnaMgr.deleteAll(ref);
				if (result == -1) {
%>
					<script>
						alert("오류가 발생하였습니다.-1");
						history.back();
					</script>
<%
				} else {
%>
					<script>
						alert("삭제되었습니다.");
						location.href="qna.jsp";
					</script>
<%
				}
			}	
		}
	}
%>	
</body>
</html>