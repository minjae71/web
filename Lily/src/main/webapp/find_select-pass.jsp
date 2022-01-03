<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="member.MemberManager" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="member.MemberBean" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="./img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/header.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/find_select.css">
	<link rel="stylesheet" type="text/css" href="css/footer.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	
	<title>Lily</title>
</head>
<body>
<%
	MemberManager memberMgr = new MemberManager(); //인스턴스생성
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	
	String pwd = memberMgr.findPwd(id, email);
	
	
	if(pwd=="") {
%>
		<script>
		alert("가입 정보가 없습니다.");
		history.back();
		</script>
<%
	} else if(pwd=="Err") {
%>
		<script>
		alert("오류가 발생하였습니다.");
		history.back();
		</script>
<%
	}
	MemberBean member = memberMgr.getOneUser(id);
	String name = member.getName();
%>
	<div id="wrap">
		<%@include file = "header_noLogin.jsp" %>
		<div id="contentWrapper">
			<div id="C_Wrap">
				<h2>FIND PWD</h2>
				<div class="findIdPwd_result">
					<p class="find_img-pass">
						<img src="img/etc/find_img-pass.png">
					</p>
					<div id="find_Success">
						<dl>
							<dt><span class="find_strong"><%=name%></span>님의 비밀번호 입니다.</dt>
							<dd>PWD : <span class="find_strong"><%=pwd %></span></dd>
						</dl>
					</div>
					<!-- 아이디 찾을때 버튼 -->
					<div class="btn-login">
						<input type="button" class="mgb10" value="로그인" onclick = "location.href='login.jsp'">
					</div>
					<div class="btn-findpass">
						<input type="button" value="비밀번호 찾기" onclick = "location.href='find.jsp'">
					</div>
				</div>
			</div>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>