<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="order.OrderManager" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>20172178</title>
</head>
<body>
<%
	String u_id = (String)session.getAttribute("ID");
	if (u_id == null) {
%>
		<script>
			alert("로그인 정보가 없습니다.");
			location.href="index.jsp";
		</script>
<%
	} else {
		int no = 0;
		if(request.getParameter("no") != null) {
			no = Integer.parseInt(request.getParameter("no"));
		}
		
		if(no == 0) {
%>
			<script>
				alert("유효하지 않은 상품입니다.");
				location.href="orderList.jsp";
			</script>
<%
		} else {
			OrderManager orderMgr = new OrderManager();
			int result = orderMgr.deleteOrder(no);
			if (result == -1) {
%>
				<script>
					alert("오류가 발생하였습니다.-1");
					history.back();
				</script>
<%
			} else {
%>
				<script>
					alert("삭제되었습니다.");
					location.href="orderList.jsp";
				</script>
<%
			}
		}
	}
%>
</body>
</html>