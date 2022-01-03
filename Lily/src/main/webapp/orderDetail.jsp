<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberManager" %>
<%@ page import="member.MemberBean" %>
<%@ page import="order.OrderBean" %>
<%@ page import="order.OrderManager" %>
<%@ page import="product.ProductBean" %>
<%@ page import="product.ProductManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/orderDetail.css">  
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<title>Order</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id!=null)
	{
%>
		<%@include file = "header_login.jsp" %>
<%
	} else {
%>
		<%@include file = "header_noLogin.jsp" %>	
<%
	}
	int no = 0;
	if(request.getParameter("no")!=null)
	{
		no = Integer.parseInt(request.getParameter("no"));
	}
	if(no==0)
	{
		%>
		<script>
			alert("유효하지 않은 상품입니다.");
			history.back();
		</script>
		<%
	}
	else {

	MemberManager memberMgr = new MemberManager();

	String userID = (String)session.getAttribute("ID");

	if(userID==null)
	{
%>
		<script>
				alert("세션이 만료되었습니다!\n다시 로그인 해주세요.");
				location.href="index.jsp";
		</script>
<%
	} else {
		MemberBean member = memberMgr.getOneUser(userID);
		OrderManager orderMgr = new OrderManager();
		ProductManager productMgr = new ProductManager();
		OrderBean order = orderMgr.getOneOrder(no);
		
		int totalPrice = 0;
		int count = 0;
		
		String email = member.getEmail();
		int strNum = email.indexOf("@");
		String email_id = email.substring(0,strNum);
		String email_domain = email.substring(strNum+1);
		
		String state = "접수중";
		switch(Integer.parseInt(order.getState()))
		{
			case 1: state="주문접수"; break;
			case 2: state="입금확인"; break;
			case 3: state="배송준비"; break;
			case 4: state="배송중"; break;
			case 5: state="배송완료"; break;
			default: state="접수중"; break;
		}
%>
	<div id="wrap">
		<div id="contentWrapper">
			<section class="content_section">
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>Order Detail</h2>
					</div>
				</div>
				<div class="content_row_1">
					<table class="order_table">
						<caption>결제목록</caption>
						<thead>
							<tr>
								<th>이미지</th>
								<th>상품명</th>
								<th>수량</th>
								<th>판매가</th>
								<th>배송구분</th>
								<th>주문처리상태</th>
								<th>-</th>
							</tr>
						</thead>
						<tbody>
<%
									//해당 제품코드(키값)의 카트내용을 담음
									int product_no = order.getProduct_no();
									//해당 제품코드의 제품정보를 db에서 가져옴
									ProductBean product = productMgr.getProduct(product_no);
									
									int price = product.getPrice();
									int quantity = order.getQuantity();
									int subTotal = price * quantity;
									totalPrice += subTotal;
%>
									<tr>
										<td><img src="img/product/<%=product.getImage1()%>"></td>
										<td><a href=""><%=product.getName() %></a></td>
										<td>1</td>
										<td><a href=""><%=NumberFormat.getInstance().format(price*quantity) %></a></td>
										<td>무료배송</td>
										<td><%=state %></td>
										<td></td>
									</tr>
						</tbody>
					</table>
				</div>
				
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>주문 정보</h2>
					</div>
				</div>
				<%
				
				
			%>
				<div class="content_row_5">
					<form name="orderform" id="orderform" method="post" class="orderform" onsubmit="">
						<table class="board_table orderlist-table">
							<caption>주문정보</caption>
							<tbody>
								<tr>
									<th>주문번호</th>
									<td>2021000001</td>
								</tr>
								<tr>
									<th>주문일자</th>
									<td><%=member.getPostcode() %></td>
								</tr>
								<tr>
									<th>주문자</th>
									<td><%=member.getName() %></td>
								</tr>
								<tr>
									<th>주문처리상태</th>
									<td><%=state %></td>
							</tbody>
						</table>
					</form>
				</div>
				
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>배송 정보</h2>
					</div>
				</div>
				<form name="orderform" id="orderform" method="post" class="orderform" action="" onsubmit="">
					<div class="content_row_5">
						<table class="board_table orderlist-table">
							<caption>배송 정보</caption>
							<tbody>
								<tr>
									<th>받으시는 분</th>
									<td><%=member.getName() %></td>
								</tr>
								<tr>
									<th>우편번호</th>
									<td><%=member.getPostcode() %></td>
								</tr>
								<tr>
									<th>주소</th>
									<td><%=member.getAddress() %> <%=member.getDetailAddress() %><br class="M-add"><%=member.getExtraAddress() %></td>
								</tr>
								<tr>
									<th>휴대전화</th>
									<td><%=member.getPhone1()%>-<%=member.getPhone2() %>-<%=member.getPhone3() %></td>
								</tr>
								<tr>
									<th>이메일</th>
									<td><%=email_id %>@<%=email_domain %></td>
								</tr>
								<tr>
									<th>배송메시지</th>
									<td>배송 전 연락주세요.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</form>
				
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>결제 정보</h2>
					</div>
				</div>
				<form name="orderform" id="orderform" method="post" class="orderform" action="" onsubmit="">
					<div class="content_row_5">
						<table class="board_table orderlist-table">
							<caption>결제 정보</caption>
							<tbody>
								<tr>
									<th>결제수단</th>
									<td>무통장입금</td>
								</tr>
								<tr>
									<th>총 주문금액</th>
									<td><%=NumberFormat.getInstance().format(totalPrice) %></td>
								</tr>
							</tbody>
						</table>
					</div>
				</form>
				<div class="content_row_4">
					<div class="write_box1"><button class="order-detail-btn" onclick="location.href='orderList.jsp'">주문목록</button></div>
					<div class="write_box2"><button class="order-nt-btn" onclick="location.href='mypage.jsp'">홈으로</button></div>
				</div>
			</section>
		</div>
		<%@include file="footer.jsp" %>
	</div>
<%
		}
	}
%>
	<script>
		$(document).ready(function(){
			$("#cb").change(function(){
				if($("#cb").is(":checked")){
					$("input[name=orderName]").val($("input[name=userName]").val());
					$("input[name=orderPhone1]").val($("input[name=userPhone1]").val());
					$("input[name=orderPhone2]").val($("input[name=userPhone2]").val());
					$("input[name=orderPhone3]").val($("input[name=userPhone3]").val());
					$("input[name=orderPostcode]").val($("input[name=userPostcode]").val());
					$("input[name=orderAddress]").val($("input[name=userAddress]").val());
					$("input[name=orderDetailAddress]").val($("input[name=userDetailAddress]").val());
					$("input[name=orderExtraAddress]").val($("input[name=userExtraAddress]").val());
				} else {
					$("input[name=orderName]").val('');
					$("input[name=orderPhone1]").val('010');
					$("input[name=orderPhone2]").val('');
					$("input[name=orderPhone3]").val('');
					$("input[name=orderPostcode]").val('');
					$("input[name=orderAddress]").val('');
					$("input[name=orderDetailAddress]").val('');
					$("input[name=orderExtraAddress]").val('');
				}
			});
		});
	</script>
</body>
</html>