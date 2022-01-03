<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberManager" %> <!-- userdao의 클래스 가져옴 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>정보 수정</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id==null)
	{
	%>
		<script>
			alert("로그인 정보가 없습니다.");
			location.href="login.jsp";
		</script>
	<%
	}
	
	MemberManager memberMgr = new MemberManager(); //인스턴스생성
	
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String birthYear = request.getParameter("birthYear");
	String birthMonth = request.getParameter("birthMonth");
	String birthDay = request.getParameter("birthDay");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email_select");
	if(email2.equals("1"))
	{
		email2 = request.getParameter("email2");
	}
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String detailAddress = request.getParameter("detailAddress");
	String extraAddress = request.getParameter("extraAddress");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	
	String email = email1 + "@" + email2;
	
	int result = memberMgr.update(id, pwd, name, birthYear, birthMonth, birthDay, email, postcode, address, detailAddress, extraAddress, phone1, phone2, phone3);
	
	if(result == -1){
%>
		<script>
			alert("오류가 발생하였습니다.");
			history.back();
		</script>
<%
	}
%>
	<script>
		alert("정보 수정이 완료되었습니다.");
<%
		if(u_id.equals("admin"))
		{
%>
			location.href="mypage_admin.jsp";
<%
		} else {
%>
			location.href="mypage.jsp";
<%
		}
%>
	</script>
</body>
</body>
</html>