<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.QnaBean" %>
<%@ page import="board.QnaManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/qna&notice.css"> 
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	
	<title>Lily</title>
</head>
<body>
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id!=null)
	{
		if(u_id.equals("admin"))
		{
%>
			<%@include file = "header_admin.jsp" %>
<%
		} else {
%>
			<%@include file = "header_login.jsp" %>
<%
		}
	} else {
%>
		<%@include file = "header_noLogin.jsp" %>
<%
	}
	int pageSize = 10;
	
	String pageNum = request.getParameter("page");
	
	//페이지 넘버값이 있을 때
	if(pageNum == null)
	{
		pageNum = "1";
	}
	int count = 0;
	
	int currentPage = Integer.parseInt(pageNum);
	
	QnaManager QnaMgr = new QnaManager();
	
	count = QnaMgr.countQna();
	
	int startRow = (currentPage - 1) * pageSize;
	
	ArrayList<QnaBean> list = QnaMgr.getList(startRow, pageSize);
%>
	<div id="wrap">
		<div id="contentWrapper">
			<section class="content_section">
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>질의응답</h2>
					</div>
					<div class="write_box"><a href="qnaWrite.jsp">WRITE</a></div>
				</div>
				<div class="content_row_1">
					<table class="board_table">
						<caption>질의응답 게시판</caption>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>글쓴이</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
<%
							if(list.size()!=0)
							{
								for(int i=0;i<list.size();i++)
								{
%>
									<tr>
										<td><%=list.get(i).getNum()%></td>
										<td>
<%
											if(list.get(i).getRe_step()>1)
											{
												for(int j=0;j<list.get(i).getRe_step();j++) {
%>
													&nbsp;
<%
												}
												if(u_id!=null)
												{
													if(list.get(i).getWriteType() == 2 && !(list.get(i).getWriter().equals(u_id) || u_id.equals("admin")))
													{
														%><span style="color:#adadad">└[RE]</span><%
													} else {
	%>

														└[RE] 
	<%
													}
												} else {
													if(list.get(i).getWriteType() == 2)
													{
														%><span style="color:#adadad">└[RE]</span><%
													} else {
	%>

														└[RE] 
	<%
													}
												}
												
											}
											if(u_id!=null)
											{
												if(list.get(i).getWriteType() == 2 && !(list.get(i).getWriter().equals(u_id) || u_id.equals("admin")))
												{
%>
													<span style="color:#adadad">비밀글 입니다.</span>
<%
												} else {
%>
													<a href="qnaView.jsp?no=<%=list.get(i).getNum()%>"><%=list.get(i).getSubject().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a>
<%
												}
											} else {
												if(list.get(i).getWriteType() == 2)
												{
%>
													<span style="color:#adadad">비밀글 입니다.</span>
<%
												} else {
%>
													<a href="qnaView.jsp?no=<%=list.get(i).getNum()%>"><%=list.get(i).getSubject().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a>
<%
												}
											}
%>										
										</td>
										<td><%=list.get(i).getWriter() %></td>
										<td><%=NumberFormat.getInstance().format(list.get(i).getReadcount())%></td>
									</tr>
<%
								}
							} else {
%>
								<tr>
									<td colspan="4">게시판이 비어 있습니다!</td>
								</tr>
<%
							}
%>
						</tbody>
					</table>
				</div>
				<div class="content_row_3">
<%
					if (count > 0) {
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); //카운터링 숫자를 얼마까지 보여줄건지 결정
						
						//시작 페이지 숫자를 설정
						int startPage = 1;
						
						if (currentPage % 10 != 0) {
							startPage = (int) (currentPage / 10) * 10 + 1;
						} else {
							startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
						}
						int pageBlock = 10; //카운터링 처리 숫자
						int endPage = startPage + pageBlock - 1; //화면에 보여질 페이지의 마지막 숫자
						if (endPage > pageCount)
						endPage = pageCount;
						//이전이라는 링크를 만들건지 파악
						if (startPage > 10) {
%>
							<span class="FFist_prev_btn"><a href="qna.jsp?page=<%=startPage - 10%>">이전 버튼</a></span>
<%
						}
						if(startPage>1)
						{
%>
							<span class="FFist_prev_btn"><a href="qna.jsp?page=<%=startPage - 1%>">이전 버튼</a></span>
<%
						}
						//페이징 처리
						for (int i = startPage; i <= endPage; i++) {
%>
							<a href="qna.jsp?page=<%=i%>"><%=i%></a>
<%
						}
						if(currentPage<pageCount)
						{
%>
							<span class="FFist_prev_btn"><a href="qna.jsp?page=<%=startPage - 1%>">이전 버튼</a></span>
<%
						}
						//다음이라는 링크를 만들건지 파악
						if (endPage < pageCount) {
%>
							<span class="Llist_next_btn"><a href="qna.jsp?page=<%=startPage + 10%>">다음 버튼</a></span>
<%
						}
					}
%>
				</div> <!-- listBX1 -->
			</section>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>