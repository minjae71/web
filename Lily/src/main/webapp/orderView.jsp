<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.ProductManager" %>
<%@ page import="product.ProductBean" %>
<%@ page import="order.CartManager" %>
<%@ page import="order.CartBean" %>
<%@ page import="order.OrderManager" %>
<%@ page import="order.OrderBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
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
	<link rel="stylesheet" type="text/css" href="css/orderView.css">  
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
	}
	String name = request.getParameter("orderName");
	String tel1 = request.getParameter("orderPhone1");
	String tel2 = request.getParameter("orderPhone2");
	String tel3 = request.getParameter("orderPhone3");
	String postcode = request.getParameter("orderPostcode");
	String address = request.getParameter("orderAddress");
	String detailAddress = request.getParameter("orderDetailAddress");
	String extraAddress = request.getParameter("orderExtraAddress");
	String message = request.getParameter("message");
	if(message==null)
	{
		message = "없음";
	}
	
	CartManager cartMgr = new CartManager();
	ProductManager productMgr = new ProductManager();
	OrderManager orderMgr = new OrderManager();
	
	ArrayList<CartBean> list = cartMgr.getList(userID);
	
	boolean result = false;
	
	int price = 0;
	
	if(list.size()==0){
		%>
			<script>
				alert("주문 내역이 없습니다");
				location.href = "index.jsp";
			</script>
		<%
	} else {
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getIsOrder() == 1)
			{
				ProductBean product = productMgr.getProduct(list.get(i).getProduct_no());
				price += product.getPrice() * list.get(i).getQuantity();
				orderMgr.insertOrder(list.get(i).getProduct_no(), list.get(i).getQuantity(), list.get(i).getId(), name, tel1, tel2, tel3, postcode, address, detailAddress, extraAddress, message);
				result = cartMgr.deleteCart(list.get(i).getNo());//장바구니에서 삭제
			}
		}
		int reservesResult = memberMgr.getReserves(price/20, userID);
		if(reservesResult==-1){
			%>
			<script>
				alert("오류가 발생하였습니다.-1");
				location.href = "index.jsp";
			</script>
			<%
		}
	}
	if(!result)
	{
%>
		<script>
			alert("오류가 발생하였습니다.");
			history.back();
		</script>
<%
	}
	
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	String today = sf.format(now);
%>
	<div id="wrap">
		<div id="contentWrapper">
			<section class="content_section">
				<div class="content_row_1">
					<div class="sub_header_section">
						<h2>주문/결제가 <strong class="ordercolor">완료</strong>되었습니다.</h2>
							<dl>
								<dt>
									주문번호 : [<strong class="orderfont"><a href=""><%=today%></a></strong>]
								</dt>
								<dd>
									<strong class="orderfont">(주)Lily</strong>를 이용해 주셔서 감사합니다.
									<strong class="orderfont">주문</strong>하신 내역은 <strong class="orderfont">마이페이지 &gt; 구매내역</strong>에서 확인 가능합니다.
								</dd>
							</dl>
					</div>
				</div>
				<div class="content_row_5">
					<form name="orderform" id="orderform" method="post" class="orderform" onsubmit="">
						<table class="board_table orderlist-table">
							<caption>주문목록</caption>
							<colgroup>
								<col>
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>주문자</th>
									<td><%=name%></td>
								</tr>
								<tr>
									<th>배송지정보</th>
									<td>(<%=postcode %>) <%=address%> <%=detailAddress %> <%=extraAddress %></td>
								</tr>
								<tr>
									<th>배송 메세지</th>
									<td><%=message %></td>
								</tr>
								<tr>
									<th>결제방법</th>
									<td>
										<span>무통장입금<br></span>
										<span>예금주 : 최희정<br></span>
										<span>신한은행 : 110-459-554944 주식회사릴리</span>
									</td>
								</tr>
								<tr>
									<th>입금액</th>
									<td><%=NumberFormat.getInstance().format(price)%>원</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
				<div class="content_row_4">
					<div class="write_box1"><button class="order-detail-btn" onclick="location.href='orderList.jsp'">주문내역</button></div>
					<div class="write_box2"><button class="order-nt-btn" onclick="location.href='mypage.jsp'">홈으로</button></div>
				</div>
			</section>
		</div>
		<%@include file="footer.jsp" %>
	</div>
</body>
</html>