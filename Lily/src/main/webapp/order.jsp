<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberManager" %>
<%@ page import="member.MemberBean" %>
<%@ page import="order.CartBean" %>
<%@ page import="order.CartManager" %>
<%@ page import="product.ProductBean" %>
<%@ page import="product.ProductManager" %>
<%@ page import="java.util.ArrayList" %>
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
	<link rel="stylesheet" type="text/css" href="css/order.css"> 
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="js/agree.js"></script>
	<script src="js/script.js"></script>
	
	<title>Lily</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id!=null)
	{
%>
		<%@include file = "header_login.jsp" %>
<%
	} else {
%>
		<%@include file = "header_noLogin.jsp" %>	
<%
	}

	MemberManager memberMgr = new MemberManager();

	String userID = (String)session.getAttribute("ID");

	if(userID==null)
	{
%>
		<script>
				alert("세션이 만료되었습니다!\n다시 로그인 해주세요.");
				location.href="index.jsp";
		</script>
<%
	} else {
		MemberBean member = memberMgr.getOneUser(userID);
		CartManager cartMgr = new CartManager();
		ProductManager productMgr = new ProductManager();
		ArrayList<CartBean> list = cartMgr.getList(userID);
		
		int totalPrice = 0;
		int count = 0;
		
		String email = member.getEmail();
		int strNum = email.indexOf("@");
		String email_id = email.substring(0,strNum);
		String email_domain = email.substring(strNum+1);
%>
	<div id="wrap">
		<div id="contentWrapper">
			<section class="content_section">
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>Order</h2>
					</div>
				</div>
				<div class="content_row_1">
					<form name="orderform" id="orderform" method="post" class="orderform" action="" onsubmit="">
						<table class="board_table">
							<caption>주문목록 게시판</caption>
							<colgroup>
								<col style="width: 50px">
								<col style="width: 200px">
								<col style="width: 80px">
								<col style="width: 80px">
								<col style="width: 50px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">이미지</th>
									<th scope="col">제품명</th>
									<th scope="col">수량</th>
									<th scope="col">적립</th>
									<th scope="col">가격</th>
								</tr>
							</thead>
							<tbody>
<%
								if(list.size()!=0)
								{
									for(int i=0;i<list.size();i++)
									{
										if(list.get(i).getIsOrder() == 1)
										{
											count++;
											int no = list.get(i).getNo();
											//해당 제품코드(키값)의 카트내용을 담음
											int product_no = list.get(i).getProduct_no();
											//해당 제품코드의 제품정보를 db에서 가져옴
											ProductBean product = productMgr.getProduct(product_no);
											
											int price = product.getPrice();
											int quantity = list.get(i).getQuantity();
											int subTotal = price * quantity;
											totalPrice += subTotal;
%>
											<tr class="row data">
												<td><img src="img/product/<%=product.getImage1()%>"></td>
												<td><a href=""><%=product.getName() %></a></td>
												<td><%=quantity%></td>
												<td><a href=""><%=NumberFormat.getInstance().format(subTotal/20) %></a></td>
												<td><a href=""><%=NumberFormat.getInstance().format(subTotal) %></a></td>
											</tr>
<%
										}
									}
								}
%>
							</tbody>
						</table>
						<div class="content_row_3">
							<div class="gkqrP_box">합계금액 : <%=NumberFormat.getInstance().format(totalPrice) %>원</div>
						</div>
					</form>
				</div>
				
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>주문 정보</h2>
					</div>
				</div>
				<div class="content_row_5">
					<form name="orderform1" id="orderform1" method="post" class="orderform" onsubmit="">
						<table class="board_table orderlist-table">
							<caption>주문목록</caption>
							<colgroup>
								<col style="width: 15%">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>주문하시는 분</th>
									<td><input type="text" placeholder="이름" name="userName" value="<%=member.getName() %>" maxlength="10" size="10" autocomplete="off" readonly></td>
								</tr>
								<tr>
									<th>주소</th>
									<td>
										<div class="arBX mgb10">
											<input class="input" type="text" name="userPostcode" value="<%=member.getPostcode() %>" id="postcode" maxlength="10" size="10" placeholder="우편번호" autocomplete="off" readonly>
										</div>
										<input type="text" class="input mgb10" maxlength="50" size="50" name="userAddress" value="<%=member.getAddress() %>" id="address" placeholder="주소" autocomplete="off" readonly><br>
										<input type="text" class="input mgb10" maxlength="50" size="50" name="userDetailAddress" value="<%=member.getDetailAddress() %>" id="detailAddress" placeholder="상세주소" autocomplete="off" readonly><br>
										<input type="text" class="input mgb10" maxlength="50" size="50" name="userExtraAddress" value="<%=member.getExtraAddress() %>" id="extraAddress" placeholder="참고항목" autocomplete="off" readonly>
									</td>
								</tr>
								<tr>
									<th>휴대전화</th>
									<td>
										<select class="ph1 sel-border" name = "userPhone1" id = "btn">
											<option value="<%=member.getPhone1()%>"><%=member.getPhone1() %></option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="019">019</option>
										</select>
										<label class="unB">-</label>
										<input type="text" class="ph2" id = "numin" name="userPhone2" value="<%=member.getPhone2() %>" maxlength = "4" autocomplete="off" readonly> <label class="unB">-</label>
										<input type="text" class="ph2" id = "numin" name="userPhone3" value="<%=member.getPhone3() %>" maxlength = "4" autocomplete="off" readonly>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
									<input id="email1" type="email" name="email1" value="<%=email_id %>" maxlength="20" placeholder="이메일" autocomplete="off" >
									<label class="unB">@</label>
									<input id="email2" type="text" name="email2" value="<%=email_domain %>" disabled>&nbsp;
									<select id="email_select" class="ph1 sel-border" name="email_select" onchange="email_change_order()" >
										<option value="1" selected>직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="daum.net">daum.net</option>
									</select>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
				
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>배송 정보</h2>
					</div>
				</div>
				<form name="orderFrm" id="orderFrm" method="post" class="orderform" action="orderView.jsp" onsubmit="">
					<div class="content_row_5">
						<table class="board_table orderlist-table">
							<caption>배송 정보</caption>
							<colgroup>
								<col style="width: 15%">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>배송지 선택</th>
									<td>
										<div class="address">
											<input type="checkbox" name="cb" id="cb"> &nbsp; 구매자 정보와 동일</h3>
											<!--<input id="sameaddr0" name="sameaddr" value="T" type="radio"><label for="sameaddr0">주문자 정보와 동일</label>
											
											<input id="recent_delivery" name="recent_delivery" value="284116" type="radio"><span class="icoDefault">기본&ensp;</span><label for="recent_delivery_info0">최희정</label>
											</span>  -->
										</div>
									</td>
								</tr>
								<tr>
									<th>받으시는 분</th>
									<td><input type="text" placeholder="이름" name="orderName" maxlength="10" size="10" autocomplete="off"></td>
								</tr>
								<tr>
									<th>주소</th>
										<td>
										<div class="arBX mgb10">
											<input class="input" type="text" name="orderPostcode" id="postcode" maxlength="10" size="10" placeholder="우편번호" autocomplete="off" readonly>
											<input type="button" class="input" value="주소 찾기" onclick="execDaumPostcode()" class="hg23" style="margin-left: 10px;">
										</div>
										<input type="text" class="input mgb10" maxlength="50" size="50" name="orderAddress" id="address" placeholder="주소" autocomplete="off" readonly><br>
										<input type="text" class="input mgb10" maxlength="50" size="50" name="orderDetailAddress" id="detailAddress" placeholder="상세주소" autocomplete="off"><br>
										<input type="text" class="input mgb10" maxlength="50" size="50" name="orderExtraAddress" id="extraAddress" placeholder="참고항목" autocomplete="off" readonly>
									</td>
								</tr>
								<tr>
									<th>휴대전화</th>
									<td>
										<select class="ph1 sel-border" name = "orderPhone1" id = "btn">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="019">019</option>
										</select> <label class="unB">-</label>
										<input type="text" class="ph2" id = "numin" name="orderPhone2" maxlength = "4" autocomplete="off"> <label class="unB">-</label>
										<input type="text" class="ph2" id = "numin" name="orderPhone3" maxlength = "4" autocomplete="off">
									</td>
								</tr>
								<tr>
									<th>배송메시지</th>
									<td><input type="text" placeholder="배송메시지" id="message" name="message" maxlength="100" cols="70" size="50" autocomplete="off"></td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="content_row_2">
						<div class="sub_header_section">
							<h2>결제 방법</h2>
						</div>
					</div>
	
					<div class="content_row_6">
						<div class="payArea">
							<div class="payment">
								<div class="method">
									<div class="usemapDiv vote_area">
										<div class="sbox" id="votelist">
											<ul>
												<li class="ec-base-label">
													<input type="radio" id="addr_paymethod1" name="voteName" fw-label="결제방식" class="radio" value="card"checked="checked"><label for="addr_paymethod1" class="paymethod1">카드 결제</label>
												</li>
												<li class="ec-base-label">
													<input type="radio" id="addr_paymethod2" name="voteName" fw-label="결제방식" class="radio" value="cash"><label for="addr_paymethod2" class="paymethod2">무통장 입금</label>
												</li>
											</ul>
										</div>
									</div>
									<!-- 카드사 직접결제 -->
									<div class="pay addr_paymethod1 on">
										<div class="ec-order-payment-card" id="ec-order-payment-directpay-card-form">
											<div class="ec-base-table tableClear">
												<table border="1" summary="">
													<caption>카드결제</caption>
													<colgroup>
														<col style="width:15%">
														<col style="width:auto">
													</colgroup>
													<tbody class="top">
														<tr>
															<th scope="row">카드선택</th>
															<td>
																<select class="cardSelect sel-border" id="directpay_card_code_select">
																	<option value="" selected="selected">선택해주세요.</option>
																	<option value="card_01">신한카드</option>
																	<option value="card_02">카카오뱅크</option>
																	<option value="card_03">우리카드</option>
																	<option value="card_04">KB국민카드</option>
																</select>
																<span class="cardMethod" id="ec-order-payment-directpay-card-method">
																	<span class="gLabel">
																		<input type="radio" name="directpay_card_method_radio" id="directpay_card_method_base" value="BASE" checked="checked">
																		<label for="directpay_card_method_base">일반결제</label>
																	</span>
																	<span class="gLabel">
																		<input type="radio" name="directpay_card_method_radio" id="directpay_card_method_app" value="APP">
																		<label for="directpay_card_method_app">앱카드</label>
																	</span>
																</span>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<div class="pay addr_paymethod2">
										<div class="ec-base-table">
											<!-- 무통장입금 -->
											<table border="1" summary="" id="payment_input_cash" style="">
												<caption>무통장입금</caption>
												<colgroup>
													<col style="width:139px">
													<col style="width:auto">
												</colgroup>
												<tbody>
													<tr>
														<th scope="row">입금자명</th>
														<td><input id="pname" name="pname" fw-label="무통장 입금자명" class="inputTypeText" autocomplete="off" placeholder="입금자명" size="15" maxlength="20" value="" type="text"></td>
													</tr>
													<tr>
														<th scope="row">입금은행</th>
														<td>
															<select id="bankaccount" class="sel-border" name="bankaccount" value="무통장 입금은행">
																<option value="-1">선택해 주세요.</option>
																<option value="신한은행:110-459-554944">신한은행:110-459-554944 주식회사릴리</option>
																<option value="카카오뱅크:3333-04-7907237">카카오뱅크:3333-04-7907237 주식회사릴리</option>
																<option value="우리은행:1002-855-597319">우리은행:1002-855-597319 주식회사릴리</option>
																<option value="국민은행:933502-00-604698">국민은행:933502-00-604698 주식회사릴리</option>
															</select>
														</td>
													</tr>
												</tbody>
											</table>
											
											<!-- 증명서류 발급 -->
											<div class="agree">
												<table border="1" summary="">
													<caption>증명서류 발급</caption>
													<!-- 청약철회방침 -->
													<tbody class="">
														<tr>
															<th scope="row">청약철회방침</th>
															<td>
																<div class="textArea">
																	<textarea id="subscription_terms" name="subscription_terms" maxlength="250" cols="70" readonly="1">
①“릴리”와 재화등의 구매에 관한 계약을 체결한 이용자는 수신확인의 통지를 받은 날부터 7일 이내에는 청약의 철회를 할 수 있습니다.

② 이용자는 재화등을 배송받은 경우 다음 각호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.
1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)
2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우
4. 같은 성능을 지닌 재화등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우

③ 제2항제2호 내지 제4호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회등이 제한되지 않습니다.

④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화등을 공급받은 날부터 3월이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.


제16조(청약철회 등의 효과)
① “릴리”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화등의 대금을 환급합니다. 이 경우 “몰”이 이용자에게 재화등의 환급을 지연한 때에는 그 지연기간에 대하여 공정거래위원회가 정하여 고시하는 지연이자율을 곱하여 산정한 지연이자를 지급합니다.

② “릴리”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화등의 대금을 지급한 때에는 지체없이 당해 결제수단을 제공한 사업자로 하여금 재화등의 대금의 청구를 정지 또는 취소하도록 요청합니다.

③ 청약철회등의 경우 공급받은 재화등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게 청약철회등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회등을 하는 경우 재화등의 반환에 필요한 비용은 “릴리”이 부담합니다.

④ 이용자가 재화등을 제공받을때 발송비를 부담한 경우에 “몰”은 청약 철회시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.
																	</textarea>
																	<p>
																		<input type="button" value="전체보기" class="popupBX" onclick="agree_popup()">
																	</p>
																</div>
															</td>
														</tr>
													</tbody>
												</table> 
											</div>
										</div>
									</div>
								</div> <!-- method -->
								<div class="total">
									<h4>
										<div class="resultArea">
											<p><strong id="current_pay_name" class="paybold">카드 결제</strong></p>
											<p><strong id="current_pay_name">무통장 입금</strong></p>
											<span>최종결제 금액</span>
										</div>
									</h4>
									<p class="price">
										<span class="allpaymoney"><%=NumberFormat.getInstance().format(totalPrice) %></span>
										<span>원</span>
									</p>
									<div class="content_row_4">
										<div class="write_box"><button class="order-btn" onclick="checkValidationOrder()">선택한 상품 주문</button></div>
									</div>
									<div class="mileage ">
										<dl class="ec-base-desc gLarge right">
											<dt><strong>총 적립예정금액</strong></dt>
											<dd id="mAllMileageSum" style=""><%=NumberFormat.getInstance().format(totalPrice/20) %></dd>
										</dl>
										<dl class="ec-base-desc gLarge right">
											<dt>회원 적립금</dt>
											<dd id="mMemberMileage"><%=NumberFormat.getInstance().format(totalPrice/20) %></dd>
										</dl>
									</div> <!-- mileage -->
								</div>
							</div>
						</div>
					</div>
					<script src="js/tab.js"></script>
				</form>
			</section>
		</div>
		<%@include file="footer.jsp" %>
	</div>
<%
	}
%>
	<script>
		$(document).ready(function(){
			$("#cb").change(function(){
				if($("#cb").is(":checked")){
					$("input[name=orderName]").val($("input[name=userName]").val());
					$("input[name=orderPhone1]").val($("input[name=userPhone1]").val());
					$("input[name=orderPhone2]").val($("input[name=userPhone2]").val());
					$("input[name=orderPhone3]").val($("input[name=userPhone3]").val());
					$("input[name=orderPostcode]").val($("input[name=userPostcode]").val());
					$("input[name=orderAddress]").val($("input[name=userAddress]").val());
					$("input[name=orderDetailAddress]").val($("input[name=userDetailAddress]").val());
					$("input[name=orderExtraAddress]").val($("input[name=userExtraAddress]").val());
				} else {
					$("input[name=orderName]").val('');
					$("input[name=orderPhone1]").val('010');
					$("input[name=orderPhone2]").val('');
					$("input[name=orderPhone3]").val('');
					$("input[name=orderPostcode]").val('');
					$("input[name=orderAddress]").val('');
					$("input[name=orderDetailAddress]").val('');
					$("input[name=orderExtraAddress]").val('');
				}
			});
		});
	</script>
</body>
</html>