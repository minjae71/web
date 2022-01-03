<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="order.OrderBean" %>
<%@ page import="order.OrderManager" %>
<%@ page import="product.ProductBean" %>
<%@ page import="product.ProductManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<% request.setCharacterEncoding("utf-8"); %><!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="img/lily_icon.png">
    <link rel="stylesheet" type="text/css" href="css/reset.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/orderList.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">

    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
    <title>Order List</title>
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
    	<script>
    		alert("로그인 후 이용해주세요.");
    		location.href="login.jsp";
    	</script>
<%
	}
	OrderManager orderMgr = new OrderManager();
	ArrayList<OrderBean> list = orderMgr.getOrder(u_id);
	ProductManager productMgr = new ProductManager();
	int count=0;
%>
	<div id="wrap">
		<div id="contentWrapper">
			<section class="content_section">
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>주문목록</h2>
					</div>
				</div>
				<div class="content_row_1">
					<table class="order_table">
						<caption>배송관리</caption>
						<thead>
							<tr>
								<th>주문일자</th>
								<th>이미지</th>
								<th>상품명</th>
								<th>결제수단</th>
								<th>주문상태(개수)</th>
								<th>결제여부</th>
								<th>현재상태</th>
								<th>-</th>
							</tr>
						</thead>
						<tbody>
<%
							if(list.size()!=0) {
								for (int i = 0; i < list.size(); i++) {
									String tel = list.get(i).getTel1() + "-" + list.get(i).getTel2() + "-" + list.get(i).getTel3();
									ProductBean product = productMgr.getProduct(list.get(i).getProduct_no());
									if(product!=null)
									{
										count++;
										int price = product.getPrice() * list.get(i).getQuantity();
										String state = "접수중";
										switch(Integer.parseInt(list.get(i).getState()))
										{
											case 1: state="주문접수"; break;
											case 2: state="입금확인"; break;
											case 3: state="배송준비"; break;
											case 4: state="배송중"; break;
											case 5: state="배송완료"; break;
											default: state="접수중"; break;
										}
	%>
										<tr>
											<td><%=list.get(i).getSdate().substring(0, 16)%></td>
											<td><img class="order-img" src="img/product/<%=product.getImage1()%>"></td>
											<td><a href="orderDetail.jsp?no=<%=list.get(i).getNo()%>"><%=product.getName() %></a></td>
											<td>무통장입금</td>
											<td><%=NumberFormat.getInstance().format(price)%>원(<%=list.get(i).getQuantity()%>개)</td>
											<td>결제완료</td>
											<td><%=state %></td>
											<td>
	<%
												if(state=="배송완료")
												{								
	%>
													<button type="button" class="ok-btn" onclick = "location.href='orderDeleteAction.jsp?no=<%=list.get(i).getNo()%>'">확인</button>
	<%
												} else {
	%>
													&nbsp;
	<%
												}
	%>
											</td>
										</tr>
	<%
										}
									}
								if(count==0)
								{
%>
									<tr style = "height: 100px;">
										<td colspan="8">주문목록이 없습니다.</td>
									</tr>
<%
								}
							} else {
%>
									<tr style = "height: 100px;">
										<td colspan="8">주문목록이 없습니다.</td>
									</tr>
<%
							}
%>
						</tbody>
					</table>
				</div>
			</section>
		</div>
    <%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>