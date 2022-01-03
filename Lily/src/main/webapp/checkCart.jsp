<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="order.CartManager" %>
<%@ page import="order.CartBean" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
	<title>Cart</title>
</head>
<body>
<%
	String userID = (String)session.getAttribute("ID");

	if(userID==null)
	{
%>
	<script>
		alert("로그인 정보가 없습니다.");
		location.href="index.jsp";
	</script>
<%
	} else {
		CartManager cartMgr = new CartManager();
		ArrayList<CartBean> list = cartMgr.getList(userID);
		
		if(list.size()==0)
		{
%>
			<script>
				alert("장바구니에 상품이 없습니다.");
				location.href="cartList.jsp";
			</script>
<%
		} else {
			for(int i=0;i<list.size();i++)
			{
				int no = list.get(i).getNo();
				cartMgr.orderClear(no);
			}
			String[] num = request.getParameterValues("check");
			if(num==null)
			{
%>
				<script>
					alert("선택된 상품이 없습니다.");
					location.href="cartList.jsp";
				</script>
<%
			} else {
				for(int i=0;i<num.length;i++)
				{
					int no = Integer.parseInt(num[i]);
					cartMgr.cartToOrder(no);
				}
%>
				<script>
					location.href="order.jsp";
				</script>
<%
			}
		}
	}
%>
</body>
</html>
