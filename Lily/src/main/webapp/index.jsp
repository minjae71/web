<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/header.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/c-tab.css">
	<link rel="stylesheet" type="text/css" href="css/footer.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="js/main_slider.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	
	<title>Lily</title>
</head>
<body>
	<div id="wrap">
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
%>
		<div id="contentWrapper">
			<div id="C_Wrap">
				<%@include file = "container.jsp" %>
				
				<div class="main_title cboth pdt70">
					<span class="f_title">Lily 공식몰만의 혜택</span>
					<span>사진 클릭으로 바로가기!</span>
					<a href="">이벤트 더보기 +</a>
				</div> <!--main title-->
				<div class="main_img cboth">
					<ul>
						<li>
							<a href="">
								<div class="ban_thumb">
									<img src="img/banner/ban_ev-10.png"><!--small event banner link-->
								</div><!--
								<div class="ban_txt fleft">
									<span>#한가위 기념</span>
									<span>최대 45% 할인!</span>
								</div>
								<div class="ev_ar fright">
									<img src="img/btn/ev_ar.png">--><!--small butten link
								</div>-->
							</a>
						</li>
						<li>
							<a href="">
								<div class="ban_thumb">
									<img src="img/banner/ban_ev-03.png"><!--small event banner link-->
								</div><!--
								<div class="ban_txt fleft">
									<span>#포토리뷰 이벤트 참여시</span>
									<span>50% 할인쿠폰 증정!</span>
								</div>
								<div class="ev_ar fright">
									<img src="img/btn/ev_ar.png">small butten link
								</div>-->
							</a>
						</li>
						<li>
							<a href="">
								<div class="ban_thumb">
									<img src="img/banner/ban_ev-08.png"><!--small event banner link-->
								</div><!--
								<div class="ban_txt fleft">
									<span>#3만원 이상 구매시</span>
									<span>당일 무료배송!</span>
								</div>
								<div class="ev_ar fright">
									<img src="img/btn/ev_ar.png">small butten link
								</div>-->
							</a>
						</li>
					</ul>
				</div>
				<div class="main_title cboth pdt100">
					<span>BEST CATEGORY</span>
					<span>가장 사랑받은 베스트 아이템</span>
				</div>
				
				<%@include file="c-tab.jsp" %>
				
				<div class="ban_event pdt100">
					<a href=""><div class="ban_event_inner"></div></a>
				</div>
				
				<div class="main_title cboth pdt100">
					<span>NEW ARRIVALS</span>
					<span>드디어 나왔다! 가을 신상</span>
				</div>
				<!-- Swiper -->
				<div class="swiper mySwiper">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="bx_group">
								<div class="new_menu">
									<div class="thumb salebox">
										<a href="productDetail.jsp?no=37"><img class="MS_prod_img_m" src="img/product/Premium-Large-Jar_Peach.png" alt="상품 섬네일"></a>
									</div>
									<ul class="info">
										<li class="dsc">릴리 프리미엄자 [피치]</li>
										<li class="brand"></li>
										<li class="price">8,900<span>원</span></li>
										<li class="icon">
											<span class="MK-product-icons">
												<!--<img src="img/btn/new-01.jpg" class="MK-product-icon-2">-->
											</span>
										</li>
									</ul>
								</div>
								<div class="new_menu">
									<div class="thumb salebox">
										<a href="productDetail.jsp?no=2"><img class="MS_prod_img_m" src="img/product/Rattan-Coaster-Round (beige).jpg" alt="상품 섬네일"></a>
									</div>
									<ul class="info">
										<li class="dsc">라탄 코스터 원형 (브라운)</li>
										<li class="brand"></li>
										<li class="price">6,000<span>원</span></li>
										<li class="icon">
											<span class="MK-product-icons">
												<!--<img src="img/btn/new-01.jpg" class="MK-product-icon-2">-->
											</span>
										</li>
									</ul>
								</div>
								<div class="new_menu">
									<div class="thumb salebox">
										<a href="productDetail.jsp?no=22"><img class="MS_prod_img_m" src="img/product/Big-White-Jasmine.png" alt="상품 섬네일"></a>
									</div>
									<ul class="info">
										<li class="dsc">릴리 필라/대 [화이트쟈스민]</li>
										<li class="brand"></li>
										<li class="price">5,900<span>원</span></li>
										<li class="icon">
											<span class="MK-product-icons">
												<!--<img src="img/btn/new-01.jpg" class="MK-product-icon-2">-->
											</span>
										</li>
									</ul>
								</div>
								<div class="new_menu">
									<div class="thumb salebox">
										<a href="productDetail.jsp?no=38"><img class="MS_prod_img_m" src="img/product/Premium-Large-Jar_Tea-Rose.png" alt="상품 섬네일"></a>
									</div>
									<ul class="info">
										<li class="dsc">릴리 프리미엄자  [티로즈]</li>
										<li class="brand"></li>
										<li class="price">8,900<span>원</span></li>
										<li class="icon">
											<span class="MK-product-icons">
												<!--<img src="img/btn/new-01.jpg" class="MK-product-icon-2">-->
											</span>
										</li>
									</ul>
								</div>
							</div>
						</div>
						
						<div class="swiper-slide">
							<div class="bx_group">
								<div class="new_menu">
									<div class="thumb salebox">
										<a href="productDetail.jsp?no=3"><img class="MS_prod_img_m" src="img/product/Rattan-Coaster-Round (brown).jpg" alt="상품 섬네일"></a>
									</div>
									<ul class="info">
										<li class="dsc">라탄 코스터 원형 (브라운)</li>
										<li class="brand"></li>
										<li class="price">6,000<span>원</span></li>
										<li class="icon">
											<span class="MK-product-icons">
												<!--<img src="img/btn/new-01.jpg" class="MK-product-icon-2">-->
											</span>
										</li>
									</ul>
								</div>
								<div class="new_menu">
									<div class="thumb salebox">
										<a href="productDetail.jsp?no=17"><img class="MS_prod_img_m" src="img/product/Small-Rose-Perfume.png" alt="상품 섬네일"></a>
									</div>
									<ul class="info">
										<li class="dsc">릴리 필라/소 [로즈퍼퓸]</li>
										<li class="brand"></li>
										<li class="price">5,900<span>원</span></li>
										<li class="icon">
											<span class="MK-product-icons">
												<!--<img src="img/btn/new-01.jpg" class="MK-product-icon-2">-->
											</span>
										</li>
									</ul>
								</div>
								<div class="new_menu">
									<div class="thumb salebox">
										<a href="productDetail.jsp?no=30"><img class="MS_prod_img_m" src="img/product/Large-Jar-Winter-Jasmine.png" alt="상품 섬네일"></a>
									</div>
									<ul class="info">
										<li class="dsc">릴리 라지자 [윈터 쟈스민]</li>
										<li class="brand"></li>
										<li class="price">17,500<span>원</span></li>
										<li class="icon">
											<span class="MK-product-icons">
												<!--<img src="img/btn/new-01.jpg" class="MK-product-icon-2">-->
											</span>
										</li>
									</ul>
								</div>
								<div class="new_menu">									<div class="thumb salebox">
										<a href="productDetail.jsp?no=4"><img class="MS_prod_img_m" src="img/product/Candle halogen lamp 35W.jpg" alt="상품 섬네일"></a>
									</div>
									<ul class="info">
										<li class="dsc">캔들 할로겐 전구 35W</li>
										<li class="brand"></li>
										<li class="price">3,300<span>원</span></li>
										<li class="icon">
											<span class="MK-product-icons">
												<!--<img src="img/btn/new-01.jpg" class="MK-product-icon-2">-->
											</span>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
				
				<!-- Swiper JS -->
				<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
				
				<!-- Initialize Swiper -->
				<script>
					var swiper = new Swiper(".mySwiper", {
					navigation: {
					nextEl: ".swiper-button-next",
					prevEl: ".swiper-button-prev",
					},
					});
				</script>
				<!---->
				<div class="long_ban_area cboth pdt100">
					<a href="">
						<div class="logn_ban_inner"></div>
					</a>
				</div>
			</div>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>