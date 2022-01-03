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
	if(id==null) {
%>
		<script>
			alert("로그인 정보가 없습니다.");
			location.href("index.jsp");
		</script>
<%
	} else if(!id.equals(request.getParameter("id"))) {
%>
		<script>
			alert("가입된 정보와 입력한 아이디가 일치하지 않습니다.");
			history.back();
		</script>
<%
	} else {
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email_select");
		if(email2.equals("1"))
		{
			email2 = request.getParameter("email2");
		}
		String email = email1 + "@" + email2;
		
		MemberManager memberMgr = new MemberManager(); //인스턴스생성
		MemberBean member = memberMgr.getOneUser(id);
		
		String userName = member.getName();
		String userPwd = member.getPwd();
		String userEmail = member.getEmail();
		
		if(!name.equals(userName)) {
%>
			<script>
				alert("가입된 정보와 입력한 이름이 일치하지 않습니다.");
				history.back();
			</script>
<%
		} else if(!pwd.equals(userPwd)) {
%>
			<script>
				alert("가입된 정보와 입력한 비밀번호가 일치하지 않습니다.");
				history.back();
			</script>
<%
		} else if(!email.equals(userEmail)) {
%>
			<script>
				alert("가입된 정보와 입력한 이메일이 일치하지 않습니다.");
				history.back();
			</script>
<%
		} else {
			int delresult = memberMgr.delete(id);
			if(delresult == 0) {
%>
				<script>
					alert("회원 탈퇴가 완료되었습니다.");
					location.href="index.jsp";
				</script>
<%
				session.invalidate();
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