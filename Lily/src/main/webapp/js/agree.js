/*************************  member/agree.jsp *************************/
$(document).ready(function(){
    $("#every_agree").change(function(){
        if($("#every_agree").is(":checked")){
            $("#ck1").prop("checked", true);
            /*$("#ck1txt").css("color", "black");*/
            $("#ck2").prop("checked", true);
            /*$("#ck2txt").css("color", "black");*/
            $("#ck3").prop("checked", true);
            /*$("#ck3txt").css("color", "black");*/
        }else{
            $("#ck1").prop("checked", false);
            $("#ck2").prop("checked", false);
            $("#ck3").prop("checked", false);
        }
    });
    /*$("#c1").change(function(){
        if($("#c1").is(":checked")){
            $("#c1txt").css("color", "black");
        }
    });
    $("#c2").change(function(){
        if($("#c2").is(":checked")){
            $("#c2txt").css("color", "black");
        }
    });*/
    $("#ad_every_agree").change(function(){
        if($("#ad_every_agree").is(":checked")){
            $("#ad_ck1").prop("checked", true);
            /*$("#ck1txt").css("color", "black");*/
            $("#ad_ck2").prop("checked", true);
            /*$("#ck2txt").css("color", "black");*/
            $("#ad_ck3").prop("checked", true);
            /*$("#ck3txt").css("color", "black");*/
        }else{
            $("#ad_ck1").prop("checked", false);
            $("#ad_ck2").prop("checked", false);
            $("#ad_ck3").prop("checked", false);
        }
    });
});
function agree_check(form) {	
	if(!$("#ck1").is(":checked")) {
		alert('릴리 이용약관 동의를 하지 않으셨습니다.'); 
		$("#ck1txt").css("color", "#FF665A"); /* red */
		$("#ck2txt").css("color", "#646464"); /* 원래색 */
		return false;
	} else if(!$("#ck2").is(":checked")) {
		alert('개인정보 수집 및 이용에 대한 안내를 선택하지 않으았습니다.');
		$("#c1txt").css("color", "#646464");
		$("#c2txt").css("color", "#FF665A");
		return false;
	}
	form.submit();
}
function agree1_popup() {
    //window.open("팝업될 문서 경로", "팝업될 문서 이름", "옵션")
    window.open("./agree.jsp", "약관동의 내용보기", "width = 770, height = 700, left = 200, top = 100")
}

function agree_popup() {
    //window.open("팝업될 문서 경로", "팝업될 문서 이름", "옵션")
    window.open("./agree_pay.jsp", "청약철회방침 내용보기", "width = 770, height = 600, left = 200, top = 100")
}

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}