function idCheck() {
	var memberID = $('#memberID').val();
	var regExpId = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,10}$/;

	if (memberID == "") {
		$('#memberID').css('background-color', '#FFCECE');
		$('#idMessage').css('color', 'red');
		$('#idMessage').html('아이디를 입력하여 주시기 바랍니다.');
	} else if (!regExpId.test(memberID)) {
		$('#memberID').css('background-color', '#FFCECE');
		$('#idMessage').css('color', 'red');
		$('#idMessage').html('6~10자의 영문, 숫자로만 입력해주세요.');
	} else {
		$.ajax({
			type: "get",
			url: "checkId.jsp?id=" + memberID,
			dataType: "text",
			data: { id: memberID },
			success: function (data, textStatus) {
				if (data == 0) {
					$('#memberID').css('background-color', '#B0F6AC');
					$('#idMessage').css('color', 'green');
					$("#idMessage").text('멋진 아이디네요!');
					$('#idcheck').val('1');
				} else {
					$('#memberID').css('background-color', '#FFCECE');
					$('#idMessage').css('color', 'red');
					$("#idMessage").text("이미 사용중인 아이디입니다.");
					$('#idcheck').val('0');
				}
			},
			error: function (data, textStatus) {
				console.log('error');
			}
		})
	}
}

function valPwd() {
	var pwd1 = $('#pwd1').val();
	var pwd2 = $('#pwd2').val();
	var regExpPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,10}$/;

	if (pwd2 != "") {
		$('#pwd2').css('background-color', '#FFCECE');
		$('#pwdCheckMessage').css('color', 'red');
		$('#pwdCheckMessage').html('비밀번호 확인이 일치하지 않습니다.');
	}

	if (pwd1 == "") {
		$('#pwd1').css('background-color', '#FFCECE');
		$('#pwdMessage').css('color', 'red');
		$('#pwdMessage').html('비밀번호를 입력하여 주시기 바랍니다.');
	}
	else if (!regExpPwd.test(pwd1)) {
		$('#pwd1').css('background-color', '#FFCECE');
		$('#pwdMessage').css('color', 'red');
		$('#pwdMessage').html('6~10자의 영문, 숫자, 특수문자를 모두 포함해 주시기 바랍니다.');
	} else {
		$('#pwd1').css('background-color', '#B0F6AC');
		$('#pwdMessage').css('color', 'green');
		$('#pwdMessage').html('사용 가능한 비밀번호입니다.');
	}
}

function checkPwd() {
	var regExpPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,10}$/;
	var pwd1 = $('#pwd1').val();
	var pwd2 = $('#pwd2').val();

	if (pwd1 != pwd2) {
		$('#pwd2').css('background-color', '#FFCECE');
		$('#pwdCheckMessage').css('color', 'red');
		$('#pwdCheckMessage').html('비밀번호 확인이 일치하지 않습니다.');
	} else if (!regExpPwd.test(pwd2)) {
		$('#pwd2').css('background-color', '#FFCECE');
		$('#pwdCheckMessage').css('color', 'red');
		$('#pwdCheckMessage').html('비밀번호 형식이 올바르지 않습니다.');
	} else {
		$('#pwd2').css('background-color', '#B0F6AC');
		$('#pwdCheckMessage').css('color', 'green');
		$('#pwdCheckMessage').html('');
	}
}
