<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.ProductManager" %>
<%@ page import="product.ProductBean" %>
<%@ page import="order.CartManager" %>
<%@ page import="order.CartBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
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
	<link rel="stylesheet" type="text/css" href="css/cartList.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	
	<title>Cart List</title>
</head>
<body>
	<div id="wrap">
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
		String userID = (String)session.getAttribute("ID");
		
		if(userID==null)
		{
%>
			<script>
				alert("세션이 만료되었습니다!\n다시 로그인 해주세요.");
				location.href="../index.jsp";
			</script>
<%
		}
		
		CartManager cartMgr = new CartManager();
		ProductManager productMgr = new ProductManager();
		ArrayList<CartBean> list = cartMgr.getList(userID);
		
		if(request.getParameter("no") != null)
		{
			int changeNo = 0;
			int stock = 0;
			changeNo = Integer.parseInt(request.getParameter("no"));
			stock = Integer.parseInt(request.getParameter("stock"));
			
			if(stock>0)
			{
				cartMgr.updateCart(changeNo, stock);
%>
				<script>
					location.href="cartList.jsp";
				</script>
<%
			} else {
%>
				<script>
					alert("오류가 발생하였습니다.");
					history.back();
				</script>
<%
			}
		}
		
%>
		<div id="contentWrapper">
			<form name="orderform" id="orderform" method="post" class="orderform" action="checkCart.jsp" onsubmit="">
				<section class="content_section">
					<div class="content_row_2">
						<div class="sub_header_section">
							<h2>장바구니</h2>
						</div>
					</div>
					<div class="content_row_1">
						<table class="cart_table">
							<caption>주문목록 게시판</caption>
							<thead>
								<tr>
									<th>선택</th>
									<th>이미지</th>
									<th>제품명</th>
									<th>수량</th>
									<th>적립</th>
									<th>가격</th>
									<th>배송비</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
<%
								int totalPrice = 0;
								
								if(list.size()==0)
								{
%>
									<tr class="row data" height="100">
										<td colspan="8">장바구니가 비어 있습니다.</td>
									</tr>
<%
								} else {
									for(int i=0;i<list.size();i++)
									{
										int no = list.get(i).getNo();
										boolean result = cartMgr.orderClear(no);
										if(!result)
										{
%>
											<script>
												alert("오류가 발생하였습니다.");
												history.back();
											</script>
<%
										}
										//해당 제품코드(키값)의 카트내용을 담음
										int product_no = list.get(i).getProduct_no();
										//해당 제품코드의 제품정보를 db에서 가져옴
										ProductBean product = productMgr.getProduct(product_no);
										
										int price = product.getPrice();
										int quantity = list.get(i).quantity;
										int reserves = (price/20) * quantity;
										
										int subTotal = price * quantity;
										int subLength = Integer.toString(subTotal).length();
										totalPrice += subTotal;
%>
										<tr class="row data">
											<td><div class="check"><input type="checkbox" name="check" value="<%=no%>" checked>&nbsp;</div></td>
											<td><img src="img/product/<%=product.getImage1()%>"></td>
											<td><a href=""><%=product.getName() %></a></td>
											<td class="updown">
												<input type="text" name="p_num1" id="p_num1" size="2" maxlength="4" class="p_num" value="<%=quantity %>">
												<div class="ud-icon">
													<span onclick="location.href='cartList.jsp?no=<%=no%>&stock=<%=quantity+1%>'"><i class="bi bi-chevron-up"></i></span>
<%
													if(quantity>1)
													{
%>
														<span onclick="location.href='cartList.jsp?no=<%=no %>&stock=<%=quantity-1%>'"><i class="bi bi-chevron-down"></i></span>
<%
													} else {
%>
														<span onclick="#"><i class="bi bi-chevron-down"></i></span>
<%
													}				
%>
												</div>
											</td>
											<td><a href=""><%= NumberFormat.getInstance().format(reserves) %>원</a></td>
											<td><a href=""><%=NumberFormat.getInstance().format(product.getPrice() * list.get(i).getQuantity())%>원</a></td>
											<td><a href="">무료배송</a></td>
											<td><button type="button" class="btn-update" onclick = "deleteOne(<%=no%>)">삭제</button></td>
										</tr>
<%
									}
								}
%>
							</tbody>
						</table>
					</div>
					<div class="content_row_3">
						<div class="list-btn">
<%
							if(list.size()!=0)
							{
%>
								<button type="button" class="orderlist-btn" onclick = "deleteAll()">전체삭제</button>
<%
							}
%>
						</div>
						<div class="gkqrP_box">합계금액 : <%=NumberFormat.getInstance().format(totalPrice) %>원</div>
					</div>
					<div class="content_row_4">
<%
						if(list.size()!=0)
						{
%>
							<div class="write_box"><button class="order-btn" onclick="submit()">선택한 상품 주문</button></div>
<%
						}
%>
					</div>
				</section>
			</form>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
	
	<script>
		function deleteOne(no)
		{
			if(confirm("정말로 해당 상품을 삭제하시겠습니까?")) {
				location.href="cartDelete.jsp?no=" + no;
			} else {
				alert("삭제가 취소되었습니다.");
				return false;
			}
		}
		function deleteAll()
		{
			if(confirm("정말로 모든 상품을 삭제하시겠습니까?")) {
				location.href="cartDelete.jsp";
			} else {
				alert("삭제가 취소되었습니다.");
			}
		}
	</script>
</body>
</html>