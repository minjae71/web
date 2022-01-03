<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("utf-8"); %>
<%@ page import="board.NoticeManager" %>
<%
	NoticeManager NoticeMgr = new NoticeManager();
	NoticeMgr.deletePreviewImg(request);
	String imageName = NoticeMgr.insertPreviewImg(request);
	out.println(imageName);
%>