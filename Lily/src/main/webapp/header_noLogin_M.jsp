<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<link rel='stylesheet' type="text/css" href='https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css'>
	<link rel='stylesheet' type="text/css" href='https://fonts.googleapis.com/css?family=Open+Sans'>
</head>
<body>
	<div class="accordion js-accordion">
		<div class="accordion__item js-accordion-item">
			<div class="accordion-header js-accordion-header">MENU</div> 
			<div class="accordion-body js-accordion-body">
				<div class="accordion-body__contents"><a href="productList.jsp?type=0">Best & New</a></div>
				<div class="accordion-body__contents"><a href="productList.jsp?type=1">Tealight</a></div>
				<div class="accordion js-accordion">
					<div class="accordion__item js-accordion-item">
						<div class="accordion-header js-accordion-header"><a href="productList.jsp?type=2">Premium</a></div> 
						<div class="accordion-body js-accordion-body">
							<div class="accordion-body__contents"><a class="block" href="productList.jsp?type=2">Jar</a></div>
							<div class="accordion-body__contents"><a class="block" href="productList.jsp?type=3">Large Jar</a></div>
						</div>
					</div>
					<div class="accordion__item js-accordion-item">
						<div class="accordion-body__contents"><a href="productList.jsp?type=4">Aroma Pillar</a></div>
						<div class="accordion-body__contents"><a href="productList.jsp?type=5">Acc</a></div>
					</div>
				</div>
			</div>
		</div>
		<div class="accordion__item js-accordion-item active">
			<div class="accordion-header js-accordion-header">INFO</div> 
			<div class="accordion-body js-accordion-body">
				<div class="accordion-body__contents">
					<a class="header-login" href="login.jsp"></a>
				</div>
				<div class="accordion-body__contents">
					<a class="header-modify" href="javascript:alert('로그인 후 이용 가능합니다.');"></a>
				</div>
				<div class="accordion-body__contents">
					<a class="header-cart" href="javascript:alert('로그인 후 이용 가능합니다.');"></a>
				</div>
				<div class="accordion-body__contents">
					<a class="header-order" href="javascript:alert('로그인 후 이용 가능합니다.');"></a>
				</div>
				<div class="accordion-body__contents">
					<a class="header-mypage" href="javascript:alert('로그인 후 이용 가능합니다.');"></a>
				</div>
				<div class="accordion-body__contents">
					<a class="header-notice" href="notice.jsp"></a>
				</div>
				<div class="accordion-body__contents">
					<a class="header-qa" href="qna.jsp" class = "last"></a>
				</div>
			</div><!-- end of accordion body -->
		</div><!-- end of accordion item -->
	</div><!-- end of accordion -->
</body>
</html>