<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="order.CartManager" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
	<title>Cart Delete</title>
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
		if(request.getParameter("no")!=null)
		{
			int no = Integer.parseInt(request.getParameter("no"));

			boolean result = cartMgr.deleteCart(no);
			
			if(result) {
				%>
				<script>
					alert("상품이 삭제되었습니다.");
					location.href = "cartList.jsp";
				</script>
				<%
			} else {
				%>
				<script>
					alert("오류가 발생하였습니다.-1");
					location.href = "cartList.jsp";
				</script>
				<%
			}
		} else {
			boolean result = cartMgr.deleteCartAll(userID);
			if(result) {
				%>
				<script>
					alert("모든 상품이 삭제되었습니다.");
					location.href = "cartList.jsp";
				</script>
				<%
			} else {
				%>
				<script>
					alert("오류가 발생하였습니다. -2");
					location.href = "cartList.jsp";
				</script>
				<%
			}
		}
	}
%>
</body>
</html>
