function idCheck() {
	var memberID = $('#memberID').val();
	var regExpId = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,10}$/;

	if (memberID == "") {
		$('#memberID').css('background-color', '#FFCECE');
		$('#idMessage').css('color', 'red');
		$('#idMessage').html('���̵� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.');
	} else if (!regExpId.test(memberID)) {
		$('#memberID').css('background-color', '#FFCECE');
		$('#idMessage').css('color', 'red');
		$('#idMessage').html('6~10���� ����, ���ڷθ� �Է����ּ���.');
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
					$("#idMessage").text('���� ���̵�׿�!');
					$('#idcheck').val('1');
				} else {
					$('#memberID').css('background-color', '#FFCECE');
					$('#idMessage').css('color', 'red');
					$("#idMessage").text("�̹� ������� ���̵��Դϴ�.");
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
		$('#pwdCheckMessage').html('��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.');
	}

	if (pwd1 == "") {
		$('#pwd1').css('background-color', '#FFCECE');
		$('#pwdMessage').css('color', 'red');
		$('#pwdMessage').html('��й�ȣ�� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.');
	}
	else if (!regExpPwd.test(pwd1)) {
		$('#pwd1').css('background-color', '#FFCECE');
		$('#pwdMessage').css('color', 'red');
		$('#pwdMessage').html('6~10���� ����, ����, Ư�����ڸ� ��� ������ �ֽñ� �ٶ��ϴ�.');
	} else {
		$('#pwd1').css('background-color', '#B0F6AC');
		$('#pwdMessage').css('color', 'green');
		$('#pwdMessage').html('��� ������ ��й�ȣ�Դϴ�.');
	}
}

function checkPwd() {
	var regExpPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,10}$/;
	var pwd1 = $('#pwd1').val();
	var pwd2 = $('#pwd2').val();

	if (pwd1 != pwd2) {
		$('#pwd2').css('background-color', '#FFCECE');
		$('#pwdCheckMessage').css('color', 'red');
		$('#pwdCheckMessage').html('��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.');
	} else if (!regExpPwd.test(pwd2)) {
		$('#pwd2').css('background-color', '#FFCECE');
		$('#pwdCheckMessage').css('color', 'red');
		$('#pwdCheckMessage').html('��й�ȣ ������ �ùٸ��� �ʽ��ϴ�.');
	} else {
		$('#pwd2').css('background-color', '#B0F6AC');
		$('#pwdCheckMessage').css('color', 'green');
		$('#pwdCheckMessage').html('');
	}
}
