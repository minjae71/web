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
	
	String dburl = "jdbc:mysql://localhost:3306/lilyDB?characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
	String dbid= "root";
	String dbpwd = "multi2020";
	
	conn = DriverManager.getConnection(dburl, dbid, dbpwd);
	
	stmt = conn.createStatement(); //Statement 객체 생성
	
	sql = "create table qna(no int not null, writer varchar(20) not null, subject varchar(50) not null, writedate datetime, readcount int, content varchar(2048) not null, image varchar(100), writeType int not null, ref int not null, re_step int not null, re_level int not null, primary key(no))";
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