<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>20172178</title>
</head>
<body>
<%
	try {
	Class.forName("com.mysql.jdbc.Driver");
	
	//데이터베이스 연결
	Connection conn = null;
	Statement stmt = null;
	String sql = null;
	
	String dburl = "jdbc:mysql://localhost:3306/lilyDB?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
	String dbid= "root";
	String dbpwd = "multi2020";
	
	conn = DriverManager.getConnection(dburl, dbid, dbpwd);
	
	stmt = conn.createStatement(); //Statement 객체 생성
	
	sql = "create table member(id varchar(20) not null, pwd varchar(20) not null, name varchar(8) not null, birthYear varchar(4) not null, birthMonth varchar(2) not null, birthDay varchar(2) not null, email varchar(30) not null, postcode varchar(10) not null, address varchar(50) not null, detailAddress varchar(50) not null, extraAddress varchar(50), phone1 varchar(4) not null, phone2 varchar(4) not null, phone3 varchar(4) not null, reserves int default 0, primary key(id))";
	stmt.executeUpdate(sql);
	

	conn.close();
	stmt.close();
	
	} catch(SQLException e) {
		System.out.println("SQL Error : " + e.getMessage());
	}

	
	out.println("테이블 생성 완료");
%>
</body>
</html>