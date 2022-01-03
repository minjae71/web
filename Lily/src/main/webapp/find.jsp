<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberManager" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="member.MemberBean" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="./img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/header.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/find.css">
	<link rel="stylesheet" type="text/css" href="css/footer.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<script src="js/script.js"></script>
	
	<title>아이디/비밀번호 찾기</title>
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
%>
	<div id="wrap">
	<%@include file = "header_noLogin.jsp" %>
		<div id="contentWrapper">
			<div id="C_Wrap" style="margin-top: 120px;">
				<section>
					<div class="contentBx">
						<div class="tabs">
							<h2>FIND</h2>
							<div class="big_tab">
								<ul>
									<li><a href="#tab01">ID</a></li>
									<li><a href="#tab02">PASSWORD</a></li>
								</ul> 
							</div>
							<div id="tab01" class="best bx_group">
								<div class="formBx">
									<form name="idFindForm" method="post" action="find_select-id.jsp">
										<div class="inputBx find_field">
											<input type="text" placeholder="NAME" name="name" autocomplete="off">
										</div>
										<div class="inputBx find_field">
											<input type="email" placeholder="E-MAIL" name="email" autocomplete="off">
										</div>
										<input type="hidden" name="type" value="1">
										<div class="inputBx btnBX">
											<input type="button" class="mgb10" value="조회하기" onclick = "checkIdFind()">
											<input type="reset" value="취소하기">
										</div>
									</form>
								</div> <!-- formBx -->
							</div>
							<div id="tab02" class="best bx_group">
								<div class="formBx">
									<form name="pwdFindForm" method="post" action="find_select-pass.jsp">
										<div class="inputBx find_field">
											<input type="text" placeholder="ID" name="id" autocomplete="off">
										</div>
										<div class="inputBx find_field">
											<input type="email" placeholder="E-MAIL" name="email" autocomplete="off">
										</div>
										<input type="hidden" name="type" value="2">
										<div class="inputBx btnBX">
											<input type="button" class="mgb10" value="조회하기" onclick = "checkPwdFind()">
											<input type="reset" value="취소하기">
										</div>
									</form>
								</div> <!-- formBx -->
							</div>
						</div>
					<script src="js/c-tab.js"></script>
					</div> <!-- contentBx -->
				</section>
			</div>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>