<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="order.OrderManager" %>
<%@ page import="order.OrderBean" %>
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
	<link rel="stylesheet" type="text/css" href="css/orderManager.css">  
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	
	<title>배송관리</title>
</head>
<body>
	<div id="wrap">
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id==null || !u_id.equals("admin"))
	{
%>
		<script>
			alert("접근 권한이 없습니다!");
			history.back();
		</script>
<%
	} else {
%>
		<%@include file = "header_admin.jsp" %>	
<%
	}
		int pageSize = 10;
		
		String pageNum = request.getParameter("pageNum");
		
		//페이지 넘버값이 있을 때
		if(pageNum == null)
		{
			pageNum = "1";
		}
		int count = 0;
		int number = 0;
		
		int currentPage = Integer.parseInt(pageNum);
		
		OrderManager orderMgr = new OrderManager();
		ProductManager productMgr = new ProductManager();
		
		count = orderMgr.getCount();
		
		int startRow = (currentPage - 1) * pageSize;
		
		ArrayList<OrderBean> list = orderMgr.getOrderAll(startRow, pageSize);
		
		number = count - (currentPage - 1) * pageSize;
%>
		<div id="contentWrapper">
			<section class="content_section">
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>배송관리</h2>
					</div>
				</div>
				
				<div class="content_row_1">
					<table class="deliver_table">
						<caption>배송관리</caption>
						<thead>
							<tr>
								<th>주문일자</th>
								<th>이미지</th>
								<th>[상품번호] 상품명</th>
								<th>회원ID</th>
								<th>결제수단</th>
								<th>주문상태(개수)</th>
								<th>현재상태</th>
							</tr>
						</thead>
						<tbody>
<%
							if(list.size()!=0)
							{
								for(int i=0;i<list.size();i++)
								{
									ProductBean product =  productMgr.getProduct(list.get(i).getProduct_no());
									if(product!=null)
									{
										int quantity = list.get(i).getQuantity();
										int price = product.getPrice();
										int allPrice = quantity * price;
										
										String state = "접수중";
										int deliver = Integer.parseInt(list.get(i).getState());
										switch(deliver)
										{
											case 1: state="주문접수"; break;
											case 2: state="입금확인"; break;
											case 3: state="배송준비"; break;
											case 4: state="배송중"; break;
											case 5: state="배송완료"; break;
											default: state="접수중"; break;
										}
	%>
										<tr>
											<td><%=list.get(i).getSdate().substring(0, 16)%></td>
											<td><img class="delivery-img" src="img/product/<%=product.getImage1()%>"></td>
											<td><%=product.getName() %></td>
											<td><%=list.get(i).getId()%></td>
											<td>무통장입금</td>
											<td><%=NumberFormat.getInstance().format(allPrice)%>원(<%=quantity%>개)</td>
											<td>
												<form name="form<%=list.get(i).getNo()%>" action="orderManagerAction.jsp" method="post">
													<input type="hidden" name="no" value = "<%=list.get(i).getNo() %>">
													<div class="deliverBx DPset "> <!-- 배송상태 -->
														<select class="deliver-select" name = "deliver" id = "deliver">
															<option value="<%=deliver%>"><%=state%></option>
															<option value="1">주문접수</option>
															<option value="2">입금확인</option>
															<option value="3">배송준비</option>
															<option value="4">배송중</option>
															<option value="5">배송완료</option>
														</select>
														<button type="button" class="ok-btn" onclick = "change(this.form)">적용</button>
													</div>
												</form>
											</td>
										</tr>
	<%
									}
								}	
							} else {
%>
								<tr>
									<td colspan="4">주문 내역이 없습니다!</td>
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
							<span class="FFist_prev_btn"><a href="notice.jsp?page=<%=startPage - 10%>">이전 버튼</a></span>
<%
						}
						if(startPage>1)
						{
%>
							<span class="FFist_prev_btn"><a href="notice.jsp?page=<%=startPage - 1%>">이전 버튼</a></span>
<%
						}
						//페이징 처리
						for (int i = startPage; i <= endPage; i++) {
%>
							<a href="notice.jsp?page=<%=i%>"><%=i%></a>
<%
						}
						if(currentPage<pageCount)
						{
%>
							<span class="FFist_prev_btn"><a href="notice.jsp?page=<%=startPage - 1%>">이전 버튼</a></span>
<%
						}
						//다음이라는 링크를 만들건지 파악
						if (endPage < pageCount) {
%>
							<span class="Llist_next_btn"><a href="notice.jsp?page=<%=startPage + 10%>">다음 버튼</a></span>
<%
						}
					}
%>
				</div>
			</section>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
	<script>
		function change(form)
		{
			var no = form.no.value;
			var type = form.deliver.value;
			
			location.href = "orderManagerAction.jsp?no=" + no + "&type=" + type;
		}
	</script>
</body>
</html>