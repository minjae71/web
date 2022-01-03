<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="order.OrderManager" %>
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
		int no = 0;
		if(request.getParameter("no")!=null)
		{
			no = Integer.parseInt(request.getParameter("no"));
		}
		
		OrderManager orderMgr = new OrderManager();
		
		if(no==0)
		{
%>
			<script>
				alert("잘못된 접근입니다.");
				history.back();
			</script>
<%
		} else {
			int state = Integer.parseInt(request.getParameter("type"));
			orderMgr.updateOrder(no, state);
			
%>
			<script>
				alert("주문 상태가 변경되었습니다.");
				location.href="orderManager.jsp";
			</script>
<%
		}
	}
%>
</body>
</html>
