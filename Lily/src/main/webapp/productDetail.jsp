<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.ProductBean" %>
<%@ page import="product.ProductManager" %>
<%@ page import="java.text.NumberFormat" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/productDetail.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<script src="js/script.js?v=1.2"></script>
	
	<title>Lily</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id!=null)
	{
		if(u_id.equals("admin"))
		{
%>
			<%@include file = "header_admin.jsp" %>
<%
		} else {
%>
			<%@include file = "header_login.jsp" %>
<%
		}
	} else {
%>
		<%@include file = "header_noLogin.jsp" %>	
<%
	}
	// num를 초기화 시키고 'num'라는 데이터가 넘어온 것이 존재한다면 캐스팅하여 변수에 담음
	int no = 0;
	
	if(request.getParameter("no") == null)
	{
%>
		<script>
			alert("유효하지 않은 상품입니다.");
			history.back();
		</script>
<%
	} else {
		no = Integer.parseInt(request.getParameter("no"));
		ProductManager productMgr = new ProductManager();
		ProductBean product = productMgr.getProduct(no);
		int stock=1;
		
		if(request.getParameter("stock")!=null) {
			stock = Integer.parseInt(request.getParameter("stock"));
		}
	
		int totalPrice = stock*product.getPrice();
		
		int typeNum = 0;
		typeNum = product.getType();
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
		<div id="wrap">
			<div id="contentWrapper">
				<div id="C_Wrap">
					<div class="sang-detail">
						<dl class="loc-navi">
							<dt class="blind">현재 위치</dt>
							<dd>
								<a href="/">HOME </a>&gt;
								<a href="">All </a>&gt;
								<a href=""><%=nowType%> </a>&gt; <%=product.getName() %>
							</dd>
						</dl>
						<div class="listDetail">
							<div class="Detail-img">
								<div class="D-img-css"><img src="img/product/<%=product.getImage1()%>" width="100%"></div>
							</div>
							<div class="menu-flex">
								<div class="Detail-pro">
									<div class="pro_Dname"><%=product.getName() %></div>
									<div class="pro_Subname"><%=product.getDetail() %></div>
								</div>
								<form name="productFrm" method="post" id="" action="cartAction.jsp?product_no=<%=product.getNo()%>">
									<div class="prod-info">
										<div class="table-opt">
											<table id="prod-table" summary="판매가격, 적립금, 주문수량, 옵션, 사이즈, 상품조르기, sns">
												<caption>상품 옵션</caption>
												<colgroup>
													<col width="100">
													<col width="*">
												</colgroup>
												<tbody>
													<tr>
														<th scope="row"><div class="tb-left">판매가격</div></th>
														<td class="sell_price">
															<div class="tb-left"><%=NumberFormat.getInstance().format(product.getPrice()) %>원</div>
														</td>
													</tr>
													<tr>
														<th scope="row"><div class="tb-left">적립금</div></th>
														<td>
															<div class="tb-left"><%=NumberFormat.getInstance().format(product.getReserves()) %>원</div>
														</td>
													</tr>
													<tr>
														<td colspan="2" style="padding-top: 30px;">
															<div id="optAddWrap">
																<div class="innerOptWrap">
																	<div class="optMenu01">
																		<input type="hidden" id="keys_basic_0" value="0:0" class="basic_option">
																		<input type="hidden" id="no" value="<%=product.getNo() %>">
																		<input type="hidden" id="price" value="<%=NumberFormat.getInstance().format(product.getPrice()) %>">
																		<span class="p-name"><%=product.getName() %></span>
																	
																		<div class="qty-ctrl">
																			<input type="text" name="stock" value="<%=stock %>">
																			<%
																			if(stock<99)
																			{
																				stock++;
																			%>
																				<input type="button" value="+" onClick="stockPlus()">
																			<%
																			}
																			if(stock>1)
																			{
																				stock--;
																			%>
																				<input type="button" value="-" onClick="stockMinus()">
																			<%
																			}
																			%>
																		</div>
																		<strong class="price"><span id="p_price_basic_0"><%=NumberFormat.getInstance().format(totalPrice) %></span>원</strong>
																	</div>
																</div> 
																
																<div class="innerOptTotal">
																	<p class="totalLeft"><span class="txt-total">총 상품 금액</span></p>
																	<p class="totalRight">
																		<strong class="total" id="p_total"><%=NumberFormat.getInstance().format(totalPrice) %></strong>
																		<span class="txt-won">원</span>
																	</p>
																</div>
															</div>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
										<div class="cboth prd-btns">
											<button type="button" class="wish move" id="wishBtn">WISH LIST</button>
											<button type="button" class="basket move" id="cartBtn" onclick="submit()">BASKET</button>
											<button type="button" class="buy move" id="buyBtn" onclick="directOrder()">BUY IT NOW</button>
										</div>
									</div>
								</form>
							</div>
						</div>
	
						<ul class="cboth title_detail">
							<li class="selected"><a href="#title_01">상품상세정보</a></li>
						</ul>
						<div class="prd-detail">
							<div id="videotalk_area"></div>
								<center>
									<img src="img/product/<%=product.getImage5()%>"><br>
								</center>
								<!-- s: 상품 일반정보(상품정보제공 고시) -->
								<div id="productWrap">
									<table>
										<colgroup>
											<col width="210"><col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th><span>품명</span></th>
												<td><span>릴리 캔들</span></td>
											</tr>
											<tr>
												<th><span>KC 인증 필 유무</span></th>
												<td><span>자가검사번호 : D-2019-2106</span></td>
											</tr>
											<tr>
												<th><span>주요소재</span></th>
												<td><span>파라핀왁스,향료</span></td>
											</tr>
											<tr>
												<th><span>제조자</span></th>
												<td><span>HEECONG LIMITED</span></td>
											</tr>
											<tr>
												<th><span>제조국</span></th>
												<td><span>한국</span></td>
											</tr>
											<tr>
												<th><span>배송,설치비용</span></th>
												<td><span>상품 출고일 : 익일출고(공휴일/주말 제외) </span></td>
											</tr>
											<tr>
												<th><span>품질보증기준</span></th>
												<td><span>교환 및 반품 상품 수령일로부터 7일이내 신청가능</span></td>
											</tr>
											<tr>
												<th><span>A/S 책임자와 전화번호</span></th>
												<td><span>고객센터 : 031-299-3021</span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div> <!-- C_Wrap -->
			</div> <!-- contentWrapper -->
			<%@include file="footer.jsp" %>
		</div> <!--전체 페이지-->
<%
	}
%>
</body>
</html>