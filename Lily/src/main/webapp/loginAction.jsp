<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberManager" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="member.MemberBean" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
<body>
<%
	MemberManager memberMgr = new MemberManager(); //인스턴스생성
	String memberID = request.getParameter("id");
	String memberPWD = request.getParameter("pwd");
	String idsave = request.getParameter("idsave");
	
	int result = memberMgr.login(memberID, memberPWD);
	//로그인 성공
	if(result == 1)
	{
		session.setAttribute("ID", memberID);
		
		MemberBean member = memberMgr.getOneUser(memberID);
		
		Cookie cookie = new Cookie("IDSAVE", memberID);
		if(idsave != null){
			cookie.setMaxAge(60*60); //60초
			response.addCookie(cookie); //저장
		} else {
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		String name = member.getName();
%>
		<script>
			alert("환영합니다 <%=name%>님, 릴리입니다.");
			location.href="index.jsp";
		</script>
<%
	}
	//로그인 실패
	else if(result == 0){
%>
		<script>
			alert("올바르지 않은 비밀번호입니다.")
			history.back();
		</script>
<%
	}
	//아이디 없음
	else if(result == -1){
%>
		<script>
			alert("존재하지 않는 아이디입니다.")
			history.back();
		</script>
<%
	}
	//DB오류
	else if(result == -2){
%>
		<script>
			alert("오류가 발생하였습니다.")
			history.back();
		</script>
<%
	}		
%>
</body>
</html>