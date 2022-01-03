<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberManager" %>
<%@ page import="member.MemberBean" %>
<%@ page import="java.text.NumberFormat" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
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
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id==null)
	{
%>
    	<script>
    		alert("로그인 정보가 없습니다.");
    		history.back();
    	</script>
<%
	} else {
%>
		
<%
		MemberManager memberMgr = new MemberManager();
		MemberBean member = memberMgr.getOneUser(u_id);
%>
		<div id="wrap">
			<%@include file = "header_login.jsp" %>
			<div id="contentWrap">
				<h2 class="aside-tit">MY PAGE</h2>
				<div id="content">
					<div id="mypage">
						<div class="page-body">
							<!-- 회원 정보 -->
							<div class="info">
								<div class="user">
									<div class="user-img"></div>
									<div class="user-info">
										<p><%=member.getName() %>[<a href="mypage.jsp"><%=u_id %></a>]님 <a href="update.jsp" class="btn-css btn-basic">EDIT</a></p>
										<div class="box">
											<dl>
												<dt>전 &nbsp;&nbsp;&nbsp; 화</dt>
												<dd><%=member.getPhone1()%>-<%=member.getPhone2()%>-<%=member.getPhone3()%></dd>
											</dl>
											<dl>
												<dt>이 메 일</dt>
												<dd><%=member.getEmail()%></dd>
											</dl>
											<dl>
												<dt>주 &nbsp;&nbsp;&nbsp; 소</dt>
												<dd>(<%=member.getPostcode()%>) <%=member.getAddress()%><br/><%=member.getDetailAddress()%> <%=member.getExtraAddress()%></dd>
											</dl>
										</div>
									</div>
								</div>
								<dl class="order">
									<dt class="tot">총 주문금액 :</dt>
									<dd class="tot"><strong><%=NumberFormat.getInstance().format(member.getReserves() * 20) %></strong>원</dd>
		
									<dt>적 립 금</dt>
									<dd><a href=""><strong><%=NumberFormat.getInstance().format(member.getReserves()) %></strong>원</a></dd>
		
									<dt>쿠 &nbsp;&nbsp;&nbsp; 폰</dt>
									<dd><a href=""><strong>0</strong>개</a></dd>
								</dl>
							</div>
							<!-- //회원 정보 -->
						</div><!-- .page-body -->
					</div><!-- #mypage -->
				</div><!-- #content -->
				<hr>
				<div id="aside">
					<div class="lnb-wrap">
						<div class="lnb-bx">
							<h2 class="txt txt1">SHOPPING INFO</h2>
							<div class="lnb">
								<ul>
									<li class="first"><a href="orderList.jsp">주문내역</a></li>
									<li><a href="cartList.jsp">장바구니</a></li>
								</ul>
							</div>
						</div>
						<div class="lnb-bx">
							<h2 class="txt txt2">SHOPPING QUESTION</h2>
							<div class="lnb">
								<ul>
									<li class="first"><a href="qnaWrite.jsp">문의하기</a></li>
									<li><a href="qna.jsp">QnA</a></li>
									<li><a href="notice.jsp">Notice</a></li>
								</ul>
							</div>
						</div>
						<div class="lnb-bx">
							<h2 class="txt txt3">CUSTOMER INFO</h2>
							<div class="lnb">
								<ul>
									<li class="first"><a href="update.jsp">회원정보변경</a></li>
									<li><a href="delete.jsp">회원탈퇴</a></li>
								</ul>
							</div>
						</div>
					</div><!-- .lnb-wrap -->
				</div><!-- #aside -->
			</div>
		    <%@include file="footer.jsp" %>
		</div> <!--전체 페이지-->
<%
	}
%>
</body>
</html>