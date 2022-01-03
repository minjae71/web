<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="order.CartManager" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>20172178</title>
</head>
<body>
	<%
	String flag = request.getParameter("flag");	
	String userID = (String)session.getAttribute("ID");
	int product_no = 0;
	if (userID == null) {
		%>
		<script>
			alert("로그인 정보가 없습니다.");
			location.href = "login.jsp";
		</script>
		<%
	}
	
	if(request.getParameter("product_no") != null) {
		product_no = Integer.parseInt(request.getParameter("product_no"));
	}
	
	if(product_no == 0) {
		%>
		<script>
			alert("에러가 발생하였습니다. -1");
			location.href="productDetail.jsp";
		</script>
		<%
	} else {
		CartManager cartMgr = new CartManager();
		int quantity = Integer.parseInt(request.getParameter("stock"));
		// 카트에 상품담기
		if(flag==null) {
			int result = cartMgr.checkCart(userID, product_no);
			if(result==-1) {
			%>
				<script>
					alert("오류가 발생하였습니다.");
					history.back();
				</script>
			<%
			} else if(result==1) {
				int cart_no = cartMgr.getCartNo(userID, product_no);
				cartMgr.plusCart(cart_no, quantity);
			} else {
				cartMgr.addCart(product_no, quantity, userID);
			}
			%>
			<script>
				alert("장바구니에 담았습니다.");
				location.href = "cartList.jsp";
			</script>
			<%
		// 카트 상품 수정
		} 
	}
	%>
</body>
</html>