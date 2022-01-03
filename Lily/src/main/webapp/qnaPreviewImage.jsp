<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("utf-8"); %>
<%@ page import="board.QnaManager" %>
<%
	QnaManager QnaMgr = new QnaManager();
	QnaMgr.deletePreviewImg(request);
	String imageName = QnaMgr.insertPreviewImg(request);
	out.println(imageName);
%>