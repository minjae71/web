<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberManager" %> <!-- userdao의 클래스 가져옴 -->
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
	
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	String id = memberMgr.findId(name, email);
	//if(list.size()==0) {
	if(id=="") {
%>
		<script>
		alert("가입 정보가 없습니다.");
		history.back();
		</script>
<%
	} else if(id=="Err") {
%>
		<script>
		alert("오류가 발생하였습니다.");
		history.back();
		</script>
<%
	}
%>
	<div id="wrap">
		<%@include file = "header_noLogin.jsp" %>
		<div id="contentWrapper">
			<div id="C_Wrap">
				<h2>FIND ID</h2>
				<div class="findIdPwd_result">
					<p class="find_img-id">
						<img src="img/etc/find_img-id.png">
					</p>
					<div id="find_Success">
						<dl>
							<dt><span class="find_strong"><%=name%></span>님의 아이디 입니다.</dt>
							<dd>ID : <span class="find_strong"><%=id%></span></dd>
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