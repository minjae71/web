<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="member.MemberManager" %>
<%@ page import="member.MemberBean" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>20172178</title>
</head>
<body>

<%	
	String id = (String)session.getAttribute("ID");
	if(id==null || !id.equals("admin")) {
%>
		<script>
			alert("접근 권한이 없습니다.");
			location.href("index.jsp");
		</script>
<%
	} else {
		String memberId = request.getParameter("id");
		if(memberId == null)
		{
%>
			<script>
				alert("잘못된 접근입니다.");
				location.href("index.jsp");
			</script>
<%
		} else {
			MemberManager memberMgr = new MemberManager();
			int delresult = memberMgr.delete(memberId);
			if(delresult == 0) {
%>
				<script>
					alert("회원 삭제가 완료되었습니다.");
					location.href="memberManager_admin.jsp";
				</script>
<%
			} else {
%>
			<script>
				alert("오류가 발생하였습니다. -2");
				history.back();
			</script>
<%
			}
		}
		
	}
%>
</body>
</html>