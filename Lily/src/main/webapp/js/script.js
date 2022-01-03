/*************************  login.jsp *************************/
function checkLogin() {
	var form = document.loginform;
	if(form.id.value == "") {
		alert("아이디를 입력해 주시기 바랍니다.");
		form.id.focus();
		return false;
	}
	if(form.pwd.value == "") {
		alert("비밀번호를 입력해 주시기 바랍니다!");
		form.pwd.focus();
		return false;
	}
	form.submit();
}
function enterLogin() {
	if(window.event.keyCode==13) {
		checkLogin();
	}
}
/*************************  find.jsp *************************/
function checkIdFind() {
	var form = document.idFindForm;
	if(form.name.value == "") {
		alert("이름을 입력하세요.");
		form.name.focus();
		return false;
	}
	if(form.email.value == "") {
		alert("이메일을 입력하세요.");
		form.email.focus();
		return false;
	}
	form.submit();
}

function checkPwdFind() {
	var form = document.pwdFindForm;
	if(form.id.value == "") {
		alert("아이디를 입력하세요.");
		form.id.focus();
		return false;
	}
	if(form.email.value == "") {
		alert("이메일을 입력하세요.");
		form.email.focus();
		return false;
	}
	form.submit();
}
/*************************  join.jsp *************************/
function idCheck() {
	var memberID = $('#id').val();
	var regExpId = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,10}$/;

	if(memberID == "") {
		$('#id').css('background-color', '#FFC6C6');
		$('#idMessage').css('color','red');
		$('#idMessage').html('아이디를 입력하여 주시기 바랍니다.');
	} else if(!regExpId.test(memberID)) {
		$('#id').css('background-color', '#FFC6C6');
		$('#idMessage').css('color','red');
		$('#idMessage').html('6~10자의 영문, 숫자로만 입력해주세요.');
	} else {
		$.ajax({ 
			type:"get", 
			url:"checkId.jsp?id=" + memberID,
			dataType:"text",
			data:{id:memberID},
			success: function(data, textStatus){ 
				if(data == 0) { 
					$('#id').css('background-color', '#CCE1AF');
					$('#idMessage').css('color','green');
					$("#idMessage").text('');
					$('#idcheck').val('1');
				} else {
					$('#id').css('background-color', '#FFC6C6');
					$('#idMessage').css('color','red');
					$("#idMessage").text("이미 사용중인 아이디입니다.");
					$('#idcheck').val('0');
				}
			},
			error:function (data, textStatus) {
				console.log('error');
			}
		}) 
	}
}
function valPwd() {
	var pwd1 = $('#pwd1').val();
	var pwd2 = $('#pwd2').val();
	var regExpPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,10}$/;
	
	if(pwd2!="") {
		$('#pwd2').css('background-color', '#FFC6C6');
		$('#pwdCheckMessage').css('color', 'red');
		$('#pwdCheckMessage').html('비밀번호 확인이 일치하지 않습니다.');
	}
	
	if(pwd1=="") {
		$('#pwd1').css('background-color', '#FFC6C6');
		$('#pwdMessage').css('color', 'red');
		$('#pwdMessage').html('비밀번호를 입력하여 주시기 바랍니다.');
	}
	else if(!regExpPwd.test(pwd1)) {
		$('#pwd1').css('background-color', '#FFC6C6');
		$('#pwdMessage').css('color', 'red');
		$('#pwdMessage').html('6~10자의 영문, 숫자, 특수문자를 모두 포함해 주시기 바랍니다.');
	} else {
		$('#pwd1').css('background-color', '#CCE1AF');
		$('#pwdMessage').css('color', 'green');
		$('#pwdMessage').html('');
	}
}

function checkPwd() {
	var regExpPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,10}$/;
	var pwd1 = $('#pwd1').val();
	var pwd2 = $('#pwd2').val();
	
	if(pwd1!=pwd2) {
		$('#pwd2').css('background-color', '#FFC6C6');
		$('#pwdCheckMessage').css('color', 'red');
		$('#pwdCheckMessage').html('비밀번호 확인이 일치하지 않습니다.');
	} else if(!regExpPwd.test(pwd2)) {
		$('#pwd2').css('background-color', '#FFC6C6');
		$('#pwdCheckMessage').css('color', 'red');
		$('#pwdCheckMessage').html('비밀번호 형식이 올바르지 않습니다.');
	} else {
		$('#pwd2').css('background-color', '#CCE1AF');
		$('#pwdCheckMessage').css('color', 'green');
		$('#pwdCheckMessage').html('');
	}
}

function checkValidationJoin() {
	var form = document.joinForm;

	var regExpId = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,10}$/;
	var regExpName = /^[가-힣]{2,4}$/;
	var regExpPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,10}$/;
	var regExpHpNum = /^[0-9]*$/;
	var memberID = form.id.value;
	var memberPWD = form.pwd.value;
	var name = form.name.value;
	var year = form.birthYear.value;
	var month = form.birthMonth.value;
	var day = form.birthDay.value;
	var email1 = form.email1.value;
	var email2 = form.email2.value;
	var postcode = form.postcode.value;
	var detailAddress = form.detailAddress.value;
	var tel2 = form.phone2.value;
	var tel3 = form.phone3.value;
	

	if(memberID == "") {
		alert("아이디를 입력하여 주시기 바랍니다.");
		form.memberID.focus();
		return false;
	} else if(!regExpId.test(memberID)) {
		alert("아이디 형식이 올바르지 않습니다.\n6~10자의 영문, 숫자를 모두 포함해야 합니다.");
		form.memberID.focus();
		return false;
	} else if(form.idcheck.value=="0") {
		alert("이미 사용중인 아이디입니다.");
		return false;
	} else if(memberPWD == "") {
		alert("비밀번호를 입력하여 주시기 바랍니다.");
		form.memberPWD.focus();
		return false;
	} else if(!regExpPwd.test(memberPWD)) {
		alert("비밀번호 형식이 올바르지 않습니다.\n6~10자의 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
		form.memberPWD.focus();
		return false;
	} else if(memberPWD.search(/\s/)!=-1) {
		alert("비밀번호 형식이 올바르지 않습니다.\n6~10자의 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
		form.memberPWD.focus();
		return false;
	} else if(memberPWD.length < 6 || memberPWD.length > 10) {
		alert("비밀번호 형식이 올바르지 않습니다.\n6~10자의 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
		form.memberPWD.focus();
		return false;                    
	} else if(memberPWD != form.pwdck.value) {
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		form.pwdcheck.focus();
		return false;
	} else if(name == "") {
		alert("이름을 입력하여 주시기 바랍니다.");
		form.name.focus();
		return false;
	} else if(!regExpName.test(name)) {
		alert("이름 형식이 올바르지 않습니다.\n2~4자의 한글만 가능합니다.");
		form.name.focus();
		return false;
	}  else if(year == "") {
		alert("태어난 년도를 선택해 주시기 바랍니다.");
		form.year.focus();
		return false;
	} else if(month == "") {
		alert("태어난 월을 선택해 주시기 바랍니다.");
		form.month.focus();
		return false;
	} else if(day == "") {
		alert("태어난 일을 선택해 주시기 바랍니다.");
		form.day.focus();
		return false;
	} else if(email1 == "") {
		alert("이메일을 입력하여 주시기 바랍니다.");
		form.email1.focus();
		return false;
	} else if(email2 == "") {
		alert("이메일을 입력하여 주시기 바랍니다.");
		form.email2.focus();
		return false;
	} else if(email2.indexOf(".")==-1) {
		alert("이메일 형식이 올바르지 않습니다.");
		form.email2.focus();
		return false;
	} else if(postcode == "") {
		alert("주소를 입력해 주시기 바랍니다.");
		form.postcode.focus();
		return false;
	} else if(detailAddress == "") {
		alert("상세주소를 입력해 주시기 바랍니다.");
		form.detailAddress.focus();
		return false;
	} else if(tel2 == "") {
		alert("연락처를 입력하여 주시기 바랍니다.");
		form.tel2.focus();
		return false;
	} else if(tel2.length < 3) {
		alert("연락처 형식이 올바르지 않습니다.");
		form.tel2.focus();
		return false;
	} else if(!regExpHpNum.test(tel2)) {
		alert("연락처는 숫자만 입력해 주시기 바랍니다.");
		form.tel2.focus();
		return false;
	} else if(tel3 == "") {
		alert("연락처를 입력하여 주시기 바랍니다.");
		form.tel3.focus();
		return false;
	} else if(tel3.length < 4) {
		alert("연락처 형식이 올바르지 않습니다");
		form.tel3.focus();
		return false;
	} else if(!regExpHpNum.test(tel3)) {
		alert("연락처는 숫자만 입력해 주시기 바랍니다.");
		form.tel3.focus();
		return false;
	} else if(!form.ck1.checked) {
		alert("릴리 이용 약관에 동의하지 않으셨습니다.");
		return false;
	} else if(!form.ck2.checked) {
		alert("개인정보 수집 및 이용 약관에 동의하지 않으셨습니다.");
		return false;
	} else if(!form.ck3.checked) {
		alert("개인정보 제 3자 제공 약관에 동의하지 않으셨습니다.");
		return false;
	}
	form.submit();
}

function checkValidationUpdate() {
	var form = document.joinForm;

	var regExpId = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,10}$/;
	var regExpName = /^[가-힣]{2,4}$/;
	var regExpPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,10}$/;
	var regExpHpNum = /^[0-9]*$/;
	var memberID = form.id.value;
	var memberPWD = form.pwd.value;
	var name = form.name.value;
	var year = form.birthYear.value;
	var month = form.birthMonth.value;
	var day = form.birthDay.value;
	var email1 = form.email1.value;
	var email2 = form.email2.value;
	var postcode = form.postcode.value;
	var detailAddress = form.detailAddress.value;
	var tel2 = form.phone2.value;
	var tel3 = form.phone3.value;
	

	if(memberID == "") {
		alert("아이디를 입력하여 주시기 바랍니다.");
		form.memberID.focus();
		return false;
	} else if(!regExpId.test(memberID)) {
		alert("아이디 형식이 올바르지 않습니다.\n6~10자의 영문, 숫자를 모두 포함해야 합니다.");
		form.memberID.focus();
		return false;
	} else if(form.idcheck.value=="0") {
		alert("이미 사용중인 아이디입니다.");
		return false;
	} else if(memberPWD == "") {
		alert("비밀번호를 입력하여 주시기 바랍니다.");
		form.memberPWD.focus();
		return false;
	} else if(!regExpPwd.test(memberPWD)) {
		alert("비밀번호 형식이 올바르지 않습니다.\n6~10자의 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
		form.memberPWD.focus();
		return false;
	} else if(memberPWD.search(/\s/)!=-1) {
		alert("비밀번호 형식이 올바르지 않습니다.\n6~10자의 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
		form.memberPWD.focus();
		return false;
	} else if(memberPWD.length < 6 || memberPWD.length > 10) {
		alert("비밀번호 형식이 올바르지 않습니다.\n6~10자의 영문, 숫자, 특수문자를 모두 포함해야 합니다.");
		form.memberPWD.focus();
		return false;                    
	} else if(memberPWD != form.pwdck.value) {
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		form.pwdcheck.focus();
		return false;
	} else if(name == "") {
		alert("이름을 입력하여 주시기 바랍니다.");
		form.name.focus();
		return false;
	} else if(!regExpName.test(name)) {
		alert("이름 형식이 올바르지 않습니다.\n2~4자의 한글만 가능합니다.");
		form.name.focus();
		return false;
	} else if(year == "") {
		alert("태어난 년도를 선택해 주시기 바랍니다.");
		form.year.focus();
		return false;
	} else if(month == "") {
		alert("태어난 월을 선택해 주시기 바랍니다.");
		form.month.focus();
		return false;
	} else if(day == "") {
		alert("태어난 일을 선택해 주시기 바랍니다.");
		form.day.focus();
		return false;
	} else if(email1 == "") {
		alert("이메일을 입력하여 주시기 바랍니다.");
		form.email1.focus();
		return false;
	} else if(email2 == "") {
		alert("이메일을 입력하여 주시기 바랍니다.");
		form.email2.focus();
		return false;
	} else if(email2.indexOf(".")==-1) {
		alert("이메일 형식이 올바르지 않습니다.");
		form.email2.focus();
		return false;
	} else if(postcode == "") {
		alert("주소를 입력해 주시기 바랍니다.");
		form.postcode.focus();
		return false;
	} else if(detailAddress == "") {
		alert("상세주소를 입력해 주시기 바랍니다.");
		form.detailAddress.focus();
		return false;
	} else if(tel2 == "") {
		alert("연락처를 입력하여 주시기 바랍니다.");
		form.tel2.focus();
		return false;
	} else if(tel2.length < 3) {
		alert("연락처 형식이 올바르지 않습니다.");
		form.tel2.focus();
		return false;
	} else if(!regExpHpNum.test(tel2)) {
		alert("연락처는 숫자만 입력해 주시기 바랍니다.");
		form.tel2.focus();
		return false;
	} else if(tel3 == "") {
		alert("연락처를 입력하여 주시기 바랍니다.");
		form.tel3.focus();
		return false;
	} else if(tel3.length < 4) {
		alert("연락처 형식이 올바르지 않습니다");
		form.tel3.focus();
		return false;
	} else if(!regExpHpNum.test(tel3)) {
		alert("연락처는 숫자만 입력해 주시기 바랍니다.");
		form.tel3.focus();
		return false;
	}
	form.submit();
}

function checkValidationDelete() {
	var form = document.loginform;

	var memberID = form.id.value;
	var memberPWD = form.pwd.value;
	var name = form.name.value;
	var email1 = form.email1.value;
	var email2 = form.email2.value;	

	if(memberID == "") {
		alert("아이디를 입력하여 주시기 바랍니다.");
		form.memberID.focus();
		return false;
	} else if(name == "") {
		alert("이름을 입력하여 주시기 바랍니다.");
		form.name.focus();
		return false;
	} else if(memberPWD == "") {
		alert("비밀번호를 입력하여 주시기 바랍니다.");
		form.memberPWD.focus();
		return false;
	} else if(memberPWD != form.pwdck.value) {
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		form.pwdcheck.focus();
		return false;
	} else if(email1 == "") {
		alert("이메일을 입력하여 주시기 바랍니다.");
		form.email1.focus();
		return false;
	} else if(email2 == "") {
		alert("이메일을 입력하여 주시기 바랍니다.");
		form.email2.focus();
		return false;
	} else if(email2.indexOf(".")==-1) {
		alert("이메일 형식이 올바르지 않습니다.");
		form.email2.focus();
		return false;
	}
	
	form.submit();
}

function checkValidationOrder() {
	var form = document.orderFrm;
	
	var regExpName = /^[가-힣]{2,4}$/;
	var regExpHpNum = /^[0-9]*$/;

	var name = form.name.value;
	var postcode = form.postcode.value;
	var detailAddress = form.detailAddress.value;
	var tel2 = form.phone2.value;
	var tel3 = form.phone3.value;
	

	if(name == "") {
		alert("이름을 입력하여 주시기 바랍니다.");
		form.name.focus();
		return false;
	} else if(!regExpName.test(name)) {
		alert("이름 형식이 올바르지 않습니다.\n2~4자의 한글만 가능합니다.");
		form.name.focus();
		return false;
	} else if(postcode == "") {
		alert("주소를 입력해 주시기 바랍니다.");
		form.postcode.focus();
		return false;
	} else if(detailAddress == "") {
		alert("상세주소를 입력해 주시기 바랍니다.");
		form.detailAddress.focus();
		return false;
	} else if(tel2 == "") {
		alert("연락처를 입력하여 주시기 바랍니다.");
		form.tel2.focus();
		return false;
	} else if(tel2.length < 3) {
		alert("연락처 형식이 올바르지 않습니다.");
		form.tel2.focus();
		return false;
	} else if(!regExpHpNum.test(tel2)) {
		alert("연락처는 숫자만 입력해 주시기 바랍니다.");
		form.tel2.focus();
		return false;
	} else if(tel3 == "") {
		alert("연락처를 입력하여 주시기 바랍니다.");
		form.tel3.focus();
		return false;
	} else if(tel3.length < 4) {
		alert("연락처 형식이 올바르지 않습니다");
		form.tel3.focus();
		return false;
	} else if(!regExpHpNum.test(tel3)) {
		alert("연락처는 숫자만 입력해 주시기 바랍니다.");
		form.tel3.focus();
		return false;
	}
	form.submit();
}

/************************* 이미지 처리 *************************/
var xhr;
function noticeFilePreview() {

	//form 전체를 formData 객체로 전환
	var form = document.personal;
	var formData = new FormData(form);
	formData.append("upload_file",form.image.files[0]);
	

	//xhr 객체 생성
	xhr = new XMLHttpRequest();
	
	//데이터를 전달할 타겟 설정
	xhr.open("post", "noticePreviewImage.jsp", true);
	
	//데이터가 정상적으로 전달 됐을 때  결과값을 받아왔을때의 실행내용
	xhr.onreadystatechange = function() { //폴백
		if (xhr.readyState == 4) {
			if (xhr.status == 200) { //200은 잘넘어왔단 것이다.
				previewProcess(form);
			} else {
				alert("요청오류 : " + xhr.status);
			}
		}
	}
	//데이터 전송
	xhr.send(formData);
}

function qnaFilePreview() {

	//form 전체를 formData 객체로 전환
	var form = document.personal;
	var formData = new FormData(form);
	formData.append("upload_file",form.image.files[0]);
	

	//xhr 객체 생성
	xhr = new XMLHttpRequest();
	
	//데이터를 전달할 타겟 설정
	xhr.open("post", "qnaPreviewImage.jsp", true);
	
	//데이터가 정상적으로 전달 됐을 때  결과값을 받아왔을때의 실행내용
	xhr.onreadystatechange = function() { //폴백
		if (xhr.readyState == 4) {
			if (xhr.status == 200) { //200은 잘넘어왔단 것이다.
				previewProcess(form);
			} else {
				alert("요청오류 : " + xhr.status);
			}
		}
	}
	//데이터 전송
	xhr.send(formData);
}

//비동기 방식으로 받아온 데이터를 처리
function previewProcess(form){
	//결과값은 저장된 preview 파일 이름
	var data = xhr.responseText;
	var previewName = data.trim();
	//preview image에 preview 폴더에 들어간 파일을 가져와서 뿌려줌
	form.preview.src = "img/preview/"+previewName;
}

//리셋버튼 누를 경우 미리보기 리셋
function resetInsertData(){
	document.personal.preview.src="";
}

/* 추가된 내용 1 직접입력 */
function email_change() {
	var form = document.joinForm;
	if(form.email_select.options[form.email_select.selectedIndex].value == '1') {
		form.email2.disabled = false;
		form.email2.value = "";
		form.email2.focus();
	} else {
		form.email2.disabled = true;
		form.email2.value = form.email_select.options[form.email_select.selectedIndex].value;
	}
}

function email_change_login() {
	var form = document.loginform;
	if(form.email_select.options[form.email_select.selectedIndex].value == '1') {
		form.email2.disabled = false;
		form.email2.value = "";
		form.email2.focus();
	} else {
		form.email2.disabled = true;
		form.email2.value = form.email_select.options[form.email_select.selectedIndex].value;
	}
}

function email_change_order() {
	var form = document.orderform1;
	if(form.email_select.options[form.email_select.selectedIndex].value == '1') {
		form.email2.disabled = false;
		form.email2.value = "";
		form.email2.focus();
	} else {
		form.email2.disabled = true;
		form.email2.value = form.email_select.options[form.email_select.selectedIndex].value;
	}
}

function checkValidationBoard()
{
	var form = document.personal;
	
	var subject = form.subject.value;
	var content = form.content.value;
	if(subject == "")
	{
		alert("제목을 입력하여 주시기 바랍니다.");
		return false;
	} else if(content == "") {
		alert("내용을 입력하여 주시기 바랍니다.");
		return false;
	}
	form.submit();
}

function checkValidationProduct()
{
	var form = document.personal;
	
	var regExpPrice = /^[0-9]*$/;
	
	var type = form.type.value;
	var image1 = form.image1.value;
	var image5 = form.image5.value;
	var name = form.name.value;
	var price = form.price.value;
	var detail = form.detail.value;

	if(type == "-1")
	{
		alert("상품 종류를 선택하여 주시기 바랍니다.");
		return false;
	} else if(!image1) {
		alert("대표이미지가 없습니다.");
		return false;
	} else if(!image5) {
		alert("상세이미지가 없습니다.");
		return false;
	} else if(name == "") {
		alert("제품명을 입력하여 주시기 바랍니다.");
		form.name.focus();
		return false;
	} else if(price == "") {
		alert("가격을 입력하여 주시기 바랍니다.");
		form.price.focus();
		return false;
	} else if(!regExpPrice.test(price)) {
		alert("가격은 숫자만 입력해 주시기 바랍니다.");
		form.price.focus();
		return false;
	} else if(detail == "") {
		alert("제품 설명을 입력하여 주시기 바랍니다.");
		form.detail.focus();
		return false;
	}
	
	form.submit();
}

function checkValidationProductUpdate()
{
	var form = document.personal;
	
	var regExpPrice = /^[0-9]*$/;
	
	var type = form.type.value;
	var image1 = form.image1.value;
	var image5 = form.image5.value;
	var name = form.name.value;
	var price = form.price.value;
	var detail = form.detail.value;
	
	var imageType = form.imageType.value;

	if(type == "-1")
	{
		alert("상품 종류를 선택하여 주시기 바랍니다.");
		return false;
	} else if(name == "") {
		alert("제품명을 입력하여 주시기 바랍니다.");
		form.name.focus();
		return false;
	} else if(price == "") {
		alert("가격을 입력하여 주시기 바랍니다.");
		form.price.focus();
		return false;
	} else if(!regExpPrice.test(price)) {
		alert("가격은 숫자만 입력해 주시기 바랍니다.");
		form.price.focus();
		return false;
	} else if(detail == "") {
		alert("제품 설명을 입력하여 주시기 바랍니다.");
		form.detail.focus();
		return false;
	}
	
	if(!image1) {
		form.imageType.value = 1;
	}
	if(!image5) {
		form.imageType.value = 2;
	}
	if(!(image1 || image5))
	{
		form.imageType.value = 3;
	}
	form.submit();
}

function stockPlus()
{
	var form = document.productFrm;
	var priceStr = form.price.value;
	var price = replaceComma(priceStr);
	
	form.stock.value++;
	var stock = form.stock.value;
	
	var totalpriceStr = stock*price;
	var totalprice = AddComma(totalpriceStr);
	
	document.getElementById("p_price_basic_0").innerHTML = totalprice;
	document.getElementById("p_total").innerHTML = totalprice;
	
}

function stockMinus()
{
	var form = document.productFrm;
	var priceStr = form.price.value;
	var price = replaceComma(priceStr);
	
	form.stock.value--;
	var stock = form.stock.value;
	
	var totalpriceStr = stock*price;
	var totalprice = AddComma(totalpriceStr);
	
	document.getElementById("p_price_basic_0").innerHTML = totalprice;
	document.getElementById("p_total").innerHTML = totalprice;
}

function directOrder()
{
	var form = document.productFrm;
	var no = form.no.value;
	var stock = form.stock.value;
	
	location.href="directOrderAction.jsp?no=" + no + "&stock=" + stock;
}

function AddComma(num)
{
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}

function replaceComma(pStr)
{
	var strCheck = /\,/g;
	pStr = pStr.replace(strCheck, '');
	return pStr;
}