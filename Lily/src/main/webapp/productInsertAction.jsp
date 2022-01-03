<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="productmanager" class="product.ProductManager"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>20172178</title>
</head>
<body>
<%
	boolean result = productmanager.insertProduct(request);
	if(result) {
%>
		<script>
			alert("상품이 등록되었습니다.");
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