<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="order.CartManager" %>
<%@ page import="order.CartBean" %>
<%@ page import="java.util.ArrayList" %>
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
	
	CartManager cartMgr = new CartManager();
	ArrayList<CartBean> list = cartMgr.getList(userID);
	
	int product_no = 0;
	if (userID == null) {
		%>
		<script>
			alert("로그인 정보가 없습니다.");
			location.href = "login.jsp";
		</script>
		<%
	}
	
	if(request.getParameter("no") != null) {
		product_no = Integer.parseInt(request.getParameter("no"));
	}
	
	if(product_no == 0) {
		%>
		<script>
			alert("에러가 발생하였습니다. -1");
			history.back();
		</script>
		<%
	} else {
		if(list.size()!=0)
		{
			for(int i=0;i<list.size();i++)
			{
				int no = list.get(i).getNo();
				boolean result = cartMgr.orderClear(no);
			}
		}
		int quantity = 1;
		quantity = Integer.parseInt(request.getParameter("stock"));
		cartMgr.addCartDirect(product_no, quantity, userID);
%>
			<script>
				location.href = "order.jsp";
			</script>
<%
	} 
%>
</body>
</html>