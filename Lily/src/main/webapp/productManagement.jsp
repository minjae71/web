<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.ProductBean" %>
<%@ page import="product.ProductManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="./img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/producManager.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<script>
		function deleteProduct(productNo) {
			if(confirm("정말로 삭제하시겠습니까?")) {
				location.href="productDeleteAction.jsp?no=" + productNo;
			} else {
				alert("삭제가 취소되었습니다.");
			return false;
			}
		}
	</script>

	<title>Lily</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(!u_id.equals("admin"))
	{
%>
		<script>
			alert("접근 권한이 없습니다!");
			location.href = "index.jsp";
		</script>
<%
	} else {
%>
		<%@include file = "header_admin.jsp" %>	
<%
	}

	int pageSize = 10;

	String pageNum = request.getParameter("page");
	String type = request.getParameter("type");
	
	//페이지 넘버값이 있을 때
	if(pageNum == null)
	{
		pageNum = "1";
	}
	int count = 0;
	
	int currentPage = Integer.parseInt(pageNum);
	
	ProductManager productMgr = new ProductManager();
	
	count = productMgr.countProduct();
	
	int startRow = (currentPage - 1) * pageSize;	
	
	ArrayList<ProductBean> list = productMgr.getProductAll(startRow, pageSize);
%>
	<div id="wrap">
		<div id="contentWrapper">
			<div id="C_Wrap" style="margin-top: 120px;">
				<section class="content_section">
					<div class="content_row_2">
						<section class="sub_header_section">
							<h2>상품관리</h2>
						</section>
						<div class="search_box">
							<form action="#" method="get">
								<input type="search" name="gallery_search_window" class="search_window" autocomplete="off" placeholder="검색어">
							</form>
						</div>
						<div class="write_box"><a href="productInsert.jsp">상품등록</a></div>
					</div>					
	                <div class="content_row_1">
	                    <table class="prodList_table">
	                        <caption>상품관리</caption>
	                        <thead>
	                            <tr>
	                                <th>상품번호</th>
	                                <th>이미지</th>
	                                <th>상품명</th>
	                                <th>가격</th>
	                                <th>분류</th>
	                                <th>비고</th>
	                            </tr>
	                        </thead>
	                        <tbody>
<%
								for(int i=0;i<list.size();i++)
								{
%>
									<tr>
										<td><%=list.get(i).getNo() %></td>
										<td><img src="img/product/<%=list.get(i).getImage1()%>"></td>
										<td><%=list.get(i).getName() %></td>
										<td><a><%=NumberFormat.getInstance().format(list.get(i).getPrice()) %></a>원</td>
<%
										switch(list.get(i).getType())
										{
											case 1:
%>
												<td>Tealight</td>
<%
												break;
											case 2:
%>
												<td>Premium Jar</td>
<%
												break;
											case 3:
%>
												<td>Large Jar</td>
<%
												break;
											case 4:
%>
												<td>Aroma Pillar</td>
<%
												break;
											case 5:
%>
												<td>Acc</td>
<%
												break;	
										}
%>
										<td>
											<button type="" class="btn-update" onclick = "location.href='productUpdate.jsp?no=<%=list.get(i).getNo()%>'">수정</button>
											<button type="" class="btn-delect" onclick = "deleteProduct(<%=list.get(i).getNo()%>)">삭제</button>
										</td>
									</tr>
<%
								}
%>
	                        </tbody>
	                    </table>
	                </div>
					<div class="content_row_3">
					<%
						if (count > 0) {
							int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); //카운터링 숫자를 얼마까지 보여줄건지 결정
						
							//시작 페이지 숫자를 설정
							int startPage = 1;
							
							if (currentPage % 10 != 0) {
								startPage = (int) (currentPage / 10) * 10 + 1;
							} else {
								startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
							}
							
							int pageBlock = 10; //카운터링 처리 숫자
							int endPage = startPage + pageBlock - 1; //화면에 보여질 페이지의 마지막 숫자
							
							if (endPage > pageCount)
								endPage = pageCount;
							
							//이전이라는 링크를 만들건지 파악
							if (startPage > 10) {
%>
								<span class="FFist_prev_btn"><a href="productManagement.jsp?page=<%=startPage - 10%>">이전 버튼</a></span>
<%
							}
							if(currentPage>1)
							{
%>
								<span class="Fist_prev_btn"><a href="productManagement.jsp?page=<%=currentPage - 1%>">이전 버튼</a></span>
<%
							}
							
							//페이징 처리
							for (int i = startPage; i <= endPage; i++) {
%>
								<a href="productManagement.jsp?page=<%=i%>"><%=i%></a>
<%
							}
							if(currentPage<pageCount)
							{
%>
								<span class="List_next_btn"><a href="productManagement.jsp?page=<%=currentPage + 1%>">다음 버튼</a></span>
<%
							}
						
						
							//다음이라는 링크를 만들건지 파악
							if (endPage < pageCount) {
%>
								<span class="Llist_next_btn"><a href="productManagement.jsp?page=<%=startPage + 10%>">다음 버튼</a></span>
<%
							}
						
						}
%>	
					</div>
				</section>
			</div>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>