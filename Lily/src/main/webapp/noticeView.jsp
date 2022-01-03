<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.NoticeBean" %>
<%@ page import="board.NoticeManager" %>
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
	<link rel="stylesheet" type="text/css" href="css/View.css"> 
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
	
	// num를 초기화 시키고 'no'라는 데이터가 넘어온 것이 존재한다면 캐스팅하여 변수에 담음
	int no = 0;
	if(request.getParameter("no") != null) {
		no = Integer.parseInt(request.getParameter("no"));
	}
	
	if(no == 0) {
%>
		<script>
			alert("유효하지 않은 글입니다.");
			location.href="list.jsp";
		</script>
<%
	} else {
		//유효한 글이라면 구체적인 정보를 'qnaboard'라는 인스턴스에 담는다.
		NoticeManager NoticeMgr = new NoticeManager();
		NoticeBean notice = NoticeMgr.getNotice(no);
		int view = 0;
		//삭제된 게시글 링크를 통해 접근 불가
		//비밀글 링크를 통해 접근 차단
		if(u_id == null || !u_id.equals("admin"))
		{
			view = 1;
			int result = NoticeMgr.viewUpdate(no);
			if(result==-1)
			{
%>
					<script>
						alert("오류가 발생하였습니다");
						history.back();
					</script>
<%
			}
		}
%>
	
	<div id="wrap">
		<div id="contentWrapper">
			<div id="content">
				<div id="bbsData">
					<div class="page-body">
						<div class="bbs-tit">
							<h2>공지사항</h2>
						</div>
						<div class="bbs-table-view">
							<table summary="게시글 보기" class="board_table other2">
								<caption>게시글 보기</caption>
								<thead>
									<tr>
										<th><div class="tb-top"><%=notice.getSubject() %></div></th>
									</tr>
								</thead>
								<tbody>
									<tr style="border-bottom: 0px;">
										<td class="umm">
											<div class="cont-sub-des">
												<div>
													<span><em>Date :</em><%=notice.getWritedate().substring(0, 11) + notice.getWritedate().substring(11, 16)%></span>
													<span><em>Name :</em><%=notice.getWriter()%></span>
													<span><em>Hits :</em><%=NumberFormat.getInstance().format(notice.getReadcount()+view)%></span>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<div class="data-bd-cont">
												<div class="attach">
<%
													if(notice.getImage()!=null)
													{
%>
														<div class="notice-img"><img src="img/notice/<%=notice.getImage()%>" alt=""></div>
<%
													}
%>
													<div class="notice-text"><%=notice.getContent() %></div>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						
							<hr size="1" color="#E5E5E5">
							<!-- 하단 버튼 -->
							<div class="view-link">
								<dl class="bbs-link con-link">
									<dt></dt>
									<dd>
<%
										if(u_id!=null && u_id.equals("admin"))
										{
%>
											<a href="noticeUpdate.jsp?no=<%=no%>" class="View_btn01">EDIT</a>
											<a href="noticeDelete.jsp?no=<%=no%>" class="View_btn01">DELETE</a>
<%
										}
%>
										<a href="notice.jsp" class="View_btn01">LIST</a>
<%
										if(u_id!=null && u_id.equals("admin"))
										{
%>
											<a href="noticeWrite.jsp" class="View_btn02">WRITE</a>
<%
										}
%>
									</dd>
								</dl>
							</div>
							<!-- //하단 버튼 -->
							
<%
							boolean isNext = NoticeMgr.existNotice(no+1);
							boolean isPrev = NoticeMgr.existNotice(no-1);
							if(isNext || isPrev)
							{
%>
								<div class="content_row_1">
									<table class="board_table tableset">
										<caption>게시글 목록</caption>
										<thead>
											<tr>
												<th scope="col"><div class="tb-top">목록</div></th>
												<th scope="col"><div class="tb-top">제목</div></th>
												<th scope="col"><div class="tb-top">글쓴이</div></th>
												<th scope="col"><div class="tb-top">작성날짜</div></th>
												<th scope="col"><div class="tb-top">조회수</div></th>
											</tr>
										</thead>
										<tbody>
<%
											if(isNext)
											{
												NoticeBean noticeNext = NoticeMgr.getNotice(no+1);
%>
												<tr>
													<td><div class="tb-center"><%=no+1%></div></td>
													<td>
														<div class="tb-left">
															<a href="noticeView.jsp?no=<%=no+1%>"><%=noticeNext.getSubject() %></a>
														</div>
													</td>
													<td><div class="tb-center"><%=noticeNext.getWriter() %></div></td>
													<td><div class="tb-center"><%=noticeNext.getWritedate().substring(0, 11) + noticeNext.getWritedate().substring(11, 16)%></div></td>
													<td><div class="tb-center"><%=noticeNext.getReadcount() %></div></td>
												</tr>
<%
											}
											if(isPrev)
											{
												NoticeBean noticePrev = NoticeMgr.getNotice(no-1);
%>	
												<tr>
													<td><div class="tb-center"><%=no-1%></div></td>
													<td>
														<div class="tb-left">
															<a href="noticeView.jsp?no=<%=no-1%>"><%=noticePrev.getSubject() %></a>
														</div>
													</td>
													<td><div class="tb-center"><%=noticePrev.getWriter() %></div></td>
													<td><div class="tb-center"><%=noticePrev.getWritedate().substring(0, 11) + noticePrev.getWritedate().substring(11, 16)%></div></td>
													<td><div class="tb-center"><%=noticePrev.getReadcount() %></div></td>
												</tr>
<%
											}
%>
										</tbody>
									</table>
								</div>
								<%
								}
								%>
						</div>
					</div><!-- .page-body -->
				</div><!-- #bbsData -->
			</div>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
<%
	}
%>
</body>
</html>