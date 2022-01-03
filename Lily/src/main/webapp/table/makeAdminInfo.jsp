<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="member.MemberManager" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>20172178</title>
</head>
<body>
<%

	MemberManager memberMgr = new MemberManager(); //인스턴스생성
	
	String id = "admin";
	String pwd = "admin2021";
	String name = "관리자";
	String birthYear = "1998";
	String birthMonth = "07";
	String birthDay = "01";
	String email1 = "admin";
	String email2 = "lily.com";
	String postcode = "18331";
	String address = "경기 화성시 봉담읍 삼천병마로 1182";
	String detailAddress = "정보통신관";
	String extraAddress = "";
	String phone1 = "010";
	String phone2 = "7722";
	String phone3 = "0666";
	
	String email = email1 + "@" + email2;
	
				
	int result = memberMgr.join(id, pwd, name, birthYear, birthMonth, birthDay, email, postcode, address, detailAddress, extraAddress, phone1, phone2, phone3);

	
	out.println(result + "관리자 아이디 생성 완료");
%>
</body>
</html>