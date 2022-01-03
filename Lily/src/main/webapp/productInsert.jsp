<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/productInsert.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<script src="js/script.js"></script>
	<script>
		function setReserves() {
			var price = $('#price').val();
			$('#reserves').val(parseInt(price/20));
		}
	</script>
	
	<title>상품등록</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(!u_id.equals("admin"))
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
%>
	<div id="wrap">
		<div id="contentWrapper">
			<div id="C_Wrap" style="margin-top: 120px;">
				<div class="p-update">
					<div class="tit-page-2">
						<h2>상품관리</h2>
						<p class="dsc"></p>
					</div>
					<div class="page-body">
						<!-- 문의 입력 폼 -->
						<form name="personal" id="personal_form" method="post" enctype="multipart/form-data" action="productInsertAction.jsp">
							<fieldset>
								<legend>상품 등록 폼</legend>
								<div class="table-d2-view">
									<table summary="">
										<caption>상품관리</caption>
										<colgroup>
											<col width="155">
											<col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><div class="tb-left">상품 종류</div></th>
												<td>
													<div class="tb-right">
														<select name="type" class="input_select" id="preface">
															<option value="-1" checked>선 택</option>
															<option value="1">Tealight</option>
															<option value="2">Premium Jar</option>
															<option value="3">Large Jar</option>
															<option value="4">Aroma Pillar</option>
															<option value="5">Acc</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row"><div class="tb-left">대표이미지</br></div></th>
												<td><div class="tb-right"><input type="file" name="image1" class="input_file" onfocus=""> </div></td>
											</tr>
											<tr>
												<th scope="row"><div class="tb-left">상세이미지</br></div></th>
												<td><div class="tb-right"><input type="file" name="image5" class="input_file" onfocus=""> </div></td>
											</tr>
											<tr>
												<th scope="row"><div class="tb-left">상품명</div></th>
												<td><div class="tb-right"><input type="text" name="name" class="input_txt txt-input2" id="" autocomplete="off"></div></td>
											</tr>
											<tr>
												<th scope="row"><div class="tb-left">가격</div></th>
												<td><div class="tb-right"><input type="text" name="price" class="input_txt txt-input2" id="price" autocomplete="off" oninput="setReserves()"></div></td>
											</tr>
											<tr>
												<th scope="row"><div class="tb-left">적립금</div></th>
												<td><div class="tb-right"><input type="text" name="reserves" class="input_txt txt-input2" id="reserves" autocomplete="off" readonly></div></td>
											</tr>
											<tr>
												<th scope="row"><div class="tb-left">상품설명</div></th>
												<td><div class="tb-right"><input type="text" name="detail" class="input_txt txt-input2" id="" autocomplete="off"></div></td>
											</tr>
										</tbody>
									</table>
								</div>
								
								<div class="foot_BTN-set">
									<div class="btn-foot01">
										<button type="button" class="btn-foot011" onclick = "location.href='productManagement.jsp'">목록</button>
									</div>
									<div class="btn-foot02">
										<button type="button" class="btn-foot021" onclick="checkValidationProduct()">등록</button>
										<button type="reset" class="btn-foot022">다시작성</button>
									</div>
								</div>
							</fieldset>
						</form>
					</div><!-- .page-body -->
				</div><!-- .p-update -->
			</div>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>