<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="product.ProductManager" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>20172178</title>
</head>
<body>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	ProductManager productMgr = new ProductManager();
	boolean result = productMgr.deleteProduct(no);
	if(result) {
%>
		<script>
			alert("상품이 삭제되었습니다.");
			location.href = "productList.jsp";
		</script>
<%
	} else {
%>
		<script>
			alert("오류가 발생하였습니다.");
			location.href = "productList.jsp";
		</script>
<%
	}
%>
</body>
</html>