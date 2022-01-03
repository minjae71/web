<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="img/lily_icon.png">
    <link rel="stylesheet" type="text/css" href="css/reset.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/mypage.css"> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">

    <link rel="stylesheet" href="css/swiper-bundle.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
    <title>Lily</title>
</head>
<body>
	<div id="wrap">
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id==null || !u_id.equals("admin"))
	{
%>
		<script>
			alert("접근 권한이 없습니다!");
			history.back();
		</script>
<%
	} else {
%>
		<%@include file = "header_admin.jsp" %>	
<%
	}
%>
		<div id="contentWrap">
			<div id="aside">
				<h2 class="aside-tit">MY PAGE</h2>
				<div class="lnb-wrap">
					<div class="lnb-bx">
						<h2 class="txt txt1">SHOPPING INFO</h2>
						<div class="lnb">
							<ul>
								<li class="first"><a href="productManagement.jsp">상품관리</a></li>
								<li><a href="productInsert.jsp">상품등록</a></li>
								<li><a href="productList.jsp">상품내역</a></li>
							</ul>
						</div>
					</div>
					<div class="lnb-bx">
						<h2 class="txt txt2">SHOPPING QUESTION</h2>
						<div class="lnb">
							<ul>
								<li class="first"><a href="notice.jsp">공지사항</a></li>
								<li><a href="qna.jsp">QnA</a></li>
							</ul>
						</div>
					</div>
					<div class="lnb-bx">
						<h2 class="txt txt3">USER INFO</h2>
						<div class="lnb">
							<ul>
								<li class="first"><a href="memberManager_admin.jsp">회원관리</a></li>
								<li><a href="orderManager.jsp">배송관리</a></li>
							</ul>
						</div>
					</div>
				</div><!-- .lnb-wrap -->
			</div><!-- #aside -->
		</div>
	    <%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>