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
	<link rel="stylesheet" type="text/css" href="css/join.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="js/agree.js"></script>
	<script src="js/script.js"></script>

	<title>회원가입</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id!=null)
	{
%>
		<script>
		alert("이미 로그인 상태입니다!\n로그아웃 후 진행해 주세요!");
		location.href="index.jsp";
		</script>
<%
	}
%>
	<div id="wrap">
		<%@include file = "header_noLogin.jsp" %>
		<div id="contentWrapper">
			<div id="C_Wrap">
				<section>
					<div class="contentBx">
						<div class="formBx">
							<h2>JOIN US</h2>
							<form name="joinForm" method="post" action="joinAction.jsp">
								<div class="inputBx join_field"> <!-- 아이디 -->
									<input type="text" placeholder="아이디" name="id" id="id" onkeyup="idCheck()" autocomplete="off">
									<input type="hidden" name="idcheck" id="idcheck" value="0">
								</div>
								<span id="idMessage"></span>
								
								<div class="inputBx join_field"> <!-- 비밀번호 -->
									<input type = "password" placeholder="비밀번호" id="pwd1" onkeyup="valPwd()" name = "pwd" autocomplete="off">
								</div>
								<span id="pwdMessage"></span>
								
								<div class="inputBx join_field"> <!-- 비밀번호 확인 -->
									<input type = "password" placeholder="비밀번호 확인" id="pwd2" onkeyup="checkPwd()" name = "pwdck" autocomplete="off">
								</div>
								<span id="pwdCheckMessage"></span>
								
								<div class="inputBx join_field"> <!-- 이름 -->
									<input type="text" placeholder="이름" name="name" maxlength="10" size="10" autocomplete="off">
								</div>
								
								<div class="inputBx DPset join_field"> <!-- 생년월일 -->
									<select name="birthYear" class="new-birth">
										<option value="">생년</option>
										<option value="2010">2010</option>
										<option value="2009">2009</option>
										<option value="2008">2008</option>
										<option value="2007">2007</option>
										<option value="2006">2006</option>
										<option value="2005">2005</option>
										<option value="2004">2004</option>
										<option value="2003">2003</option>
										<option value="2002">2002</option>
										<option value="2001">2001</option>
										<option value="2000">2000</option>
										<option value="1999">1999</option>
										<option value="1998">1998</option>
										<option value="1997">1997</option>
										<option value="1996">1996</option>
										<option value="1995">1995</option>
										<option value="1994">1994</option>
										<option value="1993">1993</option>
										<option value="1992">1992</option>
										<option value="1991">1991</option>
										<option value="1990">1990</option>
										<option value="1989">1989</option>
										<option value="1988">1988</option>
										<option value="1987">1987</option>
										<option value="1986">1986</option>
										<option value="1985">1985</option>
										<option value="1984">1984</option>
										<option value="1983">1983</option>
										<option value="1982">1982</option>
										<option value="1981">1981</option>
										<option value="1980">1980</option>
										<option value="1979">1979</option>
										<option value="1978">1978</option>
										<option value="1977">1977</option>
										<option value="1976">1976</option>
										<option value="1975">1975</option>
										<option value="1974">1974</option>
										<option value="1973">1973</option>
										<option value="1972">1972</option>
										<option value="1971">1971</option>
										<option value="1970">1970</option>
										<option value="1969">1969</option>
										<option value="1968">1968</option>
										<option value="1967">1967</option>
										<option value="1966">1966</option>
										<option value="1965">1965</option>
										<option value="1964">1964</option>
										<option value="1963">1963</option>
										<option value="1962">1962</option>
										<option value="1961">1961</option>
										<option value="1960">1960</option>
										<option value="1959">1959</option>
										<option value="1958">1958</option>
										<option value="1957">1957</option>
										<option value="1956">1956</option>
										<option value="1955">1955</option>
										<option value="1954">1954</option>
										<option value="1953">1953</option>
										<option value="1952">1952</option>
										<option value="1951">1951</option>
										<option value="1950">1950</option>
										<option value="1949">1949</option>
										<option value="1948">1948</option>
										<option value="1947">1947</option>
										<option value="1946">1946</option>
										<option value="1945">1945</option>
										<option value="1944">1944</option>
										<option value="1943">1943</option>
										<option value="1942">1942</option>
										<option value="1941">1941</option>
										<option value="1940">1940</option>
										<option value="1939">1939</option>
										<option value="1938">1938</option>
										<option value="1937">1937</option>
										<option value="1936">1936</option>
										<option value="1935">1935</option>
										<option value="1934">1934</option>
										<option value="1933">1933</option>
										<option value="1932">1932</option>
										<option value="1931">1931</option>
										<option value="1930">1930</option>
										<option value="1929">1929</option>
										<option value="1928">1928</option>
										<option value="1927">1927</option>
										<option value="1926">1926</option>
										<option value="1925">1925</option>
										<option value="1924">1924</option>
										<option value="1923">1923</option>
										<option value="1922">1922</option>
										<option value="1921">1921</option>
										<option value="1920">1920</option>
										<option value="1919">1919</option>
										<option value="1918">1918</option>
										<option value="1917">1917</option>
										<option value="1916">1916</option>
										<option value="1915">1915</option>
										<option value="1914">1914</option>
										<option value="1913">1913</option>
										<option value="1912">1912</option>
										<option value="1911">1911</option>
										<option value="1910">1910</option>
										<option value="1909">1909</option>
										<option value="1908">1908</option>
										<option value="1907">1907</option>
										<option value="1906">1906</option>
										<option value="1905">1905</option>
										<option value="1904">1904</option>
										<option value="1903">1903</option>
										<option value="1902">1902</option>
										<option value="1901">1901</option>
										<option value="1900">1900</option>
									</select> 
									<label class="unB">&nbsp;</label>
									<select name="birthMonth" class="new-birth">
										<option on value="">월</option>
										<option value="01">1</option>
										<option value="02">2</option>
										<option value="03">3</option>
										<option value="04">4</option>
										<option value="05">5</option>
										<option value="06">6</option>
										<option value="07">7</option>
										<option value="08">8</option>
										<option value="09">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>
									<label class="unB">&nbsp;</label>
									<select name="birthDay" class="new-birth">
										<option on value="">일</option>
										<option value="01">1</option>
										<option value="02">2</option>
										<option value="03">3</option>
										<option value="04">4</option>
										<option value="05">5</option>
										<option value="06">6</option>
										<option value="07">7</option>
										<option value="08">8</option>
										<option value="09">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="12">13</option>
										<option value="12">14</option>
										<option value="12">15</option>
										<option value="12">16</option>
										<option value="12">17</option>
										<option value="12">18</option>
										<option value="12">19</option>
										<option value="12">20</option>
										<option value="12">21</option>
										<option value="12">22</option>
										<option value="12">23</option>
										<option value="12">24</option>
										<option value="12">25</option>
										<option value="12">26</option>
										<option value="12">27</option>
										<option value="12">28</option>
										<option value="12">29</option>
										<option value="12">30</option>
										<option value="12">31</option>
									</select>
								</div>
								
								<div class="inputBx DPset "> <!-- 이메일 -->
									<input id="email1" type="email" name="email1" maxlength="20" placeholder="이메일" autocomplete="off" style="width:90%;">
									<label class="unB">@</label>
									<input id="email2" type="text" name="email2" value="naver.com" style="width:70%;" autocomplete="off" disabled>&nbsp;
									<select id="email_select" class="ph1" name="email_select" onchange="email_change()" style="width:85%;">
										<option value="1">직접입력</option>
										<option value="naver.com" selected>naver.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="daum.net">daum.net</option>
									</select>
								</div>
								
								<div class="inputBx addBX"> <!-- 주소 -->
									<div class="arBX mgb10">
										<input class="input" type="text" name="postcode" id="postcode" maxlength="10" size="10" placeholder="우편번호" autocomplete="off" readonly>
										<input type="button" class="input" value="주소 찾기" onclick="execDaumPostcode()" class="hg23" style="margin-left: 10px;">
									</div>
									<input type="text" class="input mgb10" maxlength="50" size="50" name="address" id="address" placeholder="주소" autocomplete="off" readonly>
									<input type="text" class="input mgb10" maxlength="50" size="50" name="detailAddress" id="detailAddress" placeholder="상세주소" autocomplete="off">
									<input type="text" class="input mgb10" maxlength="50" size="50" name="extraAddress" id="extraAddress" placeholder="참고항목" autocomplete="off" readonly>
								</div>
								<div class="inputBx DPset mgb10"> <!-- 휴대전화 -->
									<select class="ph1" name = "phone1" id = "btn">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="019">019</option>
									</select> <label class="unB">-</label>
									<input type="text" class="ph2" id = "numin" name="phone2" maxlength = "4" autocomplete="off"> <label class="unB">-</label>
									<input type="text" class="ph2" id = "numin" name="phone3" maxlength = "4" autocomplete="off">
								</div>

								<fieldset class="agreeform">
									<legend>약관 동의 폼</legend>
									<div class="privercy_contract">
										<div id="chkwrap">
											<div class="all-chk">
												<label><input type="checkbox" name="every_agree" id="every_agree" value="agr_all" class="input-cbox new_every_agree"> 약관 전체동의</label>
											</div>
											<div class="cont pbl10">
												<ul>
													<li class="agreeflex mgl30 pdt10">
														<label><input type="checkbox" name="ck1" id="ck1" value="Y" class="input-cbox every_agree ck1txt"> 이용약관 (필수)</label>
														<button type="button" onclick="agree1_popup()" class="popupBX">내용보기</button>
													</li>
													<li class="agreeflex mgl30 pdt10">
														<label><input type="checkbox" name="ck2" id="ck2" value="Y" class="input-cbox every_agree ck2txt"> 개인정보 수집 및 이용 안내 (필수)</label>
														<button type="button" onclick="agree1_popup()" class="popupBX">내용보기</button>
													</li>
													<li class="agreeflex mgl30 pdt10">
														<label><input type="checkbox" name="ck3" id="ck3" value="" class="input-cbox every_agree ck3txt"> 개인정보 제3자 제공 (필수)</label>
														<button type="button" onclick="agree1_popup()" class="popupBX">내용보기</button>
													</li>
												</ul>
												<div class="marketing">
													<div class="mk-wrap">
														<label class="mk-all"><input type="checkbox" name="ad_every_agree" id="ad_every_agree" value="ad_all" class="input-cbox every_agree new_every_agree">
															<strong>마케팅 수신동의 (선택)</strong>
														</label>
														<div style="display:inline;">
															<br style="display: none;">&emsp;( <label><input type="checkbox" name="ad_ck1" id="ad_ck1" class="input-cbox every_agree ad_every_agree"> 이메일</label>
															<label class="pl-30"><input type="checkbox" name="ad_ck2" id="ad_ck2" class="input-cbox every_agree ad_every_agree"> SMS</label>
															<label class="pl-30"><input type="checkbox" name="ad_ck3" id="ad_ck3" class="input-cbox every_agree ad_every_agree"> 앱Push알림</label>)
														</div>
													</div>
												</div>                        
											</div>
										</div>
									</div>
								</fieldset>
								
								<div class="inputBx btnBX">
									<input type="button" class="mgb10" value="JOIN US" onclick = "checkValidationJoin()">
									<input type="reset" value="RESET">
								</div>
							</form>
							
							<h3>간편 회원가입</h3>
							<ul class="sci">
								<li class="GG"><img src="img/svg/google.svg"></li>
								<li class="KT"><img src="img/svg/kakaotalk.svg"></li>
								<li class="N"><img src="img/svg/naver.svg"></li>
							</ul>
						</div> <!-- formBx -->
					</div> <!-- contentBx -->
				</section>
			</div>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>