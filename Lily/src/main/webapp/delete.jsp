<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/header.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/delete.css">
	<link rel="stylesheet" type="text/css" href="css/footer.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	
	<script src="js/script.js"></script>
	
	<title>회원탈퇴</title>
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
%>
	<div id="wrap">
		<%@include file = "header_noLogin.jsp" %>
			<div id="contentWrapper">
				<div id="C_Wrap">
					<section>
						<div class="contentBx">
							<div class="formBx">
								<h2>회원탈퇴</h2>
								<form name="loginform" method="post" action="deleteAction.jsp">
									<div class="inputBx join_field"> <!-- 아이디 -->
										<input type="text" placeholder="아이디" name="id" id="id" autocomplete="off">
										<span id="idMessage"></span>
									</div>
									<div class="inputBx join_field"> <!-- 이름 -->
										<input type="text" placeholder="이름" name="name" maxlength="10" size="10" autocomplete="off">
									</div>
									<div class="inputBx join_field"> <!-- 비밀번호 -->
										<input type = "password" placeholder="비밀번호" id="pwd1" name = "pwd" autocomplete="off">
										<span id="pwdMessage"></span>
									</div>
									<div class="inputBx join_field"> <!-- 비밀번호 확인 -->
										<input type = "password" placeholder="비밀번호 확인" id="pwd2" name = "pwdck" autocomplete="off">
										<span id="pwdCheckMessage"></span>
									</div>
									<div class="inputBx DPset "> <!-- 이메일 -->
									<input id="email1" type="email" name="email1" maxlength="20" placeholder="이메일" autocomplete="off" style="width:100%;">
									<label class="unB">@</label>
									<input id="email2" type="text" name="email2" value="naver.com" style="width:100%;" disabled>&nbsp;
									<select id="email_select" class="ph1" name="email_select" onchange="email_change_login()" style="width:100%;">
										<option value="1">직접입력</option>
										<option value="naver.com" selected>naver.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="daum.net">daum.net</option>
									</select>
								</div>
									<div class="delete-btn">
										<div class="inputBx2">
											<input type="button" class="mgb10" value="탈퇴" onclick = "checkValidationDelete()">
										</div>
										<div class="inputBx3">
											<input type="button" class="mgb10" value="취소" onclick = "location.href='index.jsp'">
										</div>
									</div>
								</form>
							</div> <!-- formBx -->
						</div> <!-- contentBx -->
					</section>
					<script>
						const pass_field = document.querySelector('.pwd_unshow');
						const show_btn = document.querySelector('.show');
						show_btn.addEventListener('click', function(){
							if(pass_field.type === "password") {
								pass_field.type = "text";
								show_btn.style.color = "#a3a591";
							} else {
								pass_field.type = "password"
								show_btn.style.color = "#222";
							}
						});
					</script>
				</div>
			</div>
			<%@include file="footer.jsp" %>
		</div>
	</body>
</html>