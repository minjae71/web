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
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/login.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	
	<script src="js/script.js"></script>
	
	<title>로그인</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id!=null)
	{
%>
		<script>
		alert("이미 로그인 상태입니다!\n로그아웃 후 진행해 주세요!\n" + u_id);
		location.href="index.jsp";
		</script>
<%
	}
	String cookie = "";
	Cookie[] cookies = request.getCookies(); //쿠키생성
	if(cookies != null && cookies.length > 0)
	{
		for(int i=0;i<cookies.length;i++)
		{
			if(cookies[i].getName().equals("IDSAVE"))
			{
				cookie = cookies[i].getValue();
			}
		}
	} 
%>
	<div id="wrap">
		<%@include file = "header_noLogin.jsp" %>
			<div id="contentWrapper">
				<div id="C_Wrap">
					<section>
						<div class="contentBx">
							<div class="formBx">
								<h2>login</h2>
								<form name="loginform" method="post" action="loginAction.jsp">
									<div class="login_field line">
										<span class="bi bi-person-fill"></span>
										<input type="text" placeholder="ID" name="id" value="<%=cookie%>" autocomplete="off">
									</div>
									<div class="login_field line">
										<span class="bi bi-lock-fill"></span>
										<input type="password" class="pwd_unshow" onkeypress="enterLogin()" placeholder="PASSWORD" name="pwd" autocomplete="off">
										<span class="show bi bi-eye-fill"></span>
									</div>
									<div class="remember">
										<%
										if(cookie == "") 
										{
										%>
											<label><input type="checkbox" name="idsave">아이디 저장</label>
										<%
										} else {
										%>
											<label><input type="checkbox" name="idsave" checked/>아이디 저장</label>
										<%
										}
										%>
									</div>
									
									<div class="inputBx">
										<input type="button" class="mgb10" value="Login" onclick = "checkLogin()">
									</div>
									<div class="betweenBx">
										<p>아직 회원이 아니신가요? <a href="join.jsp">Sign up</a></p>
										<p class="mgt10"><a href="find.jsp">아이디/비밀번호</a> 찾기</p>
									</div>
								</form>
								<h3>다른 계정으로 로그인</h3>
								<ul class="sci">
									<li class="GG"><img src="img/svg/google.svg"></li>
									<li class="KT"><img src="img/svg/kakaotalk.svg"></li>
									<li class="N"><img src="img/svg/naver.svg"></li>
								</ul>
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