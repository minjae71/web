<%@ page language="java" contentType="text/plain; charset=utf-8"%>
<%@ page import="member.MemberManager" %>
<%@ page import="java.util.*" %>
<%
	MemberManager memberMgr = new MemberManager(); //인스턴스생성

	String memberID = request.getParameter("id");

	boolean result = memberMgr.checkId(memberID);
	
	if(result) {
		out.print("1");
	} else {
		out.print("0");
	}
%>