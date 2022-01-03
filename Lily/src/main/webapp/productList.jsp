<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.ProductManager" %>
<%@ page import="product.ProductBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/productList.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	
	<title>상품페이지</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id!=null)
	{
		if(!u_id.equals("admin"))
		{
%>
			<%@include file = "header_login.jsp" %>
<%
		} else {
%>
			<%@include file = "header_admin.jsp" %>
<%
		}
	} else {
%>
		<%@include file = "header_noLogin.jsp" %>	
<%
	}
	int pageSize = 12;
	
	String pageNum = request.getParameter("page");
	String type = request.getParameter("type");
	
	//페이지 넘버값이 있을 때
	if(pageNum == null)
	{
	pageNum = "1";
	}
	if(type == null)
	{
	type = "0";
	}
	
	int count = 0;
	int number = 0;
	
	int currentPage = Integer.parseInt(pageNum);
	int typeNum = Integer.parseInt(type);
	
	ProductManager productMgr = new ProductManager();
	
	ArrayList<ProductBean> list;
	
	int startRow = (currentPage - 1) * pageSize;
	
	if(typeNum==0)
	{
	list = productMgr.getProductAll(startRow, pageSize);
	count = productMgr.countProduct();
	}
	else
	{
	list = productMgr.getProductType(startRow, pageSize, typeNum);
	count = productMgr.countProductType(typeNum);
	}
	
	
	number = count - (currentPage - 1) * pageSize;
%>
	<div id="wrap">
		<div id="contentWrapper">
			<div id="C_Wrap">
				<div id="wh1200">
					<div class="content_section">
						<div class="listBX1 con">
							<div class="content_row_1">
								<div class="prd-class-hd">
									<dl class="loc-navi">
										<dt class="blind">현재 위치</dt>
										<dd>
											<a href="index.jsp">HOME</a>
											&gt; <a href="productList.jsp?type=0">All</a>
											<%
											String nowType = "ALL";
											switch(typeNum)
											{
												case 1: nowType="Tealight"; break;
												case 2: nowType="Premium Jar"; break;
												case 3: nowType="Large Jar"; break;
												case 4: nowType="Aroma Pillar"; break;
												case 5: nowType="Acc"; break;
												default: nowType="All"; break;
											}
											%>
											&gt; <a href="productList.jsp?type=0"><%=nowType%></a>
										</dd>
									</dl>
								</div>
								<div class="item-info">
									<dl class="item-order sort">
									<dt class="blind">검색결과 정렬</dt>
									<dd>
										<ul>
											<li class="nobg"><a href=""><span>신상품</span></a></li>
											<li><a href=""><span>상품명</span></a></li>
											<li><a href=""><span>클릭순</span></a></li>
											<li><a href=""><span>베스트</span></a></li>
											<li><a href=""><span>높은가격</span></a></li>
											<li class="nobg2"><a href=""><span>낮은가격</span></a></li>
										</ul>
									</dd>
									</dl><!-- .total-sort -->
								</div>

							</div>
<%
							if(list.size()==0) {
%>
								<div class="content_row_2">상품 준비중입니다!</div>
<%
							} else {
%>
								<div class="content_row_2">
								<ul class="gallery_list">
<%
								for(int i=0;i<list.size();i++)
								{
%>
									<li class="txtCT">
										<div class="pimgBX">
											<a href="productDetail.jsp?no=<%=list.get(i).getNo()%>"><img src="img/product/<%=list.get(i).getImage1()%>" alt=""></a>
										</div>
										<div class="info">
											<a class="reod-name"><%=list.get(i).getName() %></a>
											<a class="prod-price"><%=NumberFormat.getInstance().format(list.get(i).getPrice()) %><span> 원</span></a>
											<a class="icon">
												<span class="MK-product-icons">
													<!--<img src="./img/small_img01.jpg" class="MK-product-icon-2">-->
												</span>
											</a>
										</div>
									</li>
<%
								}
%>
								</ul>
								</div>
<%
							}
%>				
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
										<span class="FFist_prev_btn"><a href="productList.jsp?type=<%=typeNum%>&page=<%=startPage - 10%>">이전 버튼</a></span>
<%
									}
									if(currentPage>1)
									{
%>
										<span class="Fist_prev_btn"><a href="productList.jsp?type=<%=typeNum%>&page=<%=startPage - 1%>">이전 버튼</a></span>
<%
									}
									
									//페이징 처리
									for (int i = startPage; i <= endPage; i++) {
%>
										<a href="productList.jsp?type=<%=typeNum%>&page=<%=i%>"><%=i%></a>
<%
									}
									if(currentPage<pageCount)
									{
%>
										<span class="List_next_btn"><a href="productList.jsp?type=<%=typeNum%>&page=<%=startPage + 1%>">다음 버튼</a></span>
<%
									}
									
									//다음이라는 링크를 만들건지 파악
									if (endPage < pageCount) {
%>
										<span class="Llist_next_btn"><a href="productList.jsp?type=<%=typeNum%>&page=<%=startPage + 10%>">다음 버튼</a></span>
<%
									}									
								}
%>					
							</div>
						</div> <!-- listBX1 -->
					</div>
				</div>
			</div> <!-- C_Wrap -->
		</div> <!-- contentWrapper -->
		<%@include file="footer.jsp" %>
		
	</div> <!--전체 페이지-->
</body>
</html>