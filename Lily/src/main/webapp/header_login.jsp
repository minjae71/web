<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberManager" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="member.MemberBean" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="css/header.css">
</head>
<body>
	<div id="MhdWrap">
		<div class="logo">
			<a href="index.jsp"><img src="img/logo.png"></a>
		</div> <!-- logo -->
		<a href="#navigation" class="nav-trigger">
			Menu <span></span>
		</a>
		<nav class="nav-container" id="navigation">
			<%@include file = "header_login_M.jsp" %>
		</nav>
		
		<div class="overlay"></div> <!-- improve main element 3d movement -->
		
		<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
		<script src="js/header.js"></script>
	</div>
	<div id="hdWrap">
		<div id="header" class="cboth">
			<div class = "header_01">
				<ul> <!-- 로그인 했을 경우 -->
					<li><a class="header-logout" href="logout.jsp"></a></li>
					<li><a class="header-modify" href="update.jsp"></a></li>
					<li><a class="header-cart" href="cartList.jsp"></a></li>
					<li><a class="header-order" href="orderList.jsp"></a></li>
					<li><a class="header-mypage" href="mypage.jsp"></a></li>
					<li><a class="header-notice" href="notice.jsp"></a></li>
					<li><a class="header-qa" href="qna.jsp" class = "last"></a></li>
				</ul>
			</div> <!-- header_01 -->
		</div>
		<div id="top">
			<div class="header_02">
				<div class="logo">
					<a href="index.jsp"><img src="img/logo.png"></a>
				</div> <!-- logo -->
			</div> <!-- header_02 -->
			
			<div class="gnb cboth">
				<nav class = "cboth header_inner">
					<ul class = "add_menu">
						<li class="cell"><a href="productList.jsp?type=0">Best & New</a></li>
						<li class="cell"><a href="productList.jsp?type=1">Tealight</a></li>
						<li class="cell"><a href="productList.jsp?type=2">Premium</a> <!-- Premium LJar, Large Jar 추가 -->
							<ul class="submenu" style="margin-top: 10px;">
								<li><a class="block" href="productList.jsp?type=2">Jar</a></li>
								<li><a class="block" href="productList.jsp?type=3">Large Jar</a></li>
							</ul>
						</li>
						<li class="cell"><a href="productList.jsp?type=4">Aroma Pillar</a></li>
						<li class="cell" style="padding-right: 0px;"><a href="productList.jsp?type=5">Acc</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div> <!--header-->
</body>
</html>