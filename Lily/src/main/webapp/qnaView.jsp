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
	<link rel="stylesheet" type="text/css" href="css/View.css"> 
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<script>
		function deleteBoard(no) {
			if(confirm("정말로 삭제하시겠습니까?")) {
				location.href="qnaDelete.jsp?no=" + no;
			} else {
				alert("삭제가 취소되었습니다.");
			return false;
			}
		}
	</script>
	
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
			location.href="qna.jsp";
		</script>
<%
	} else {
		//유효한 글이라면 구체적인 정보를 'qnaboard'라는 인스턴스에 담는다.
		QnaManager QnaMgr = new QnaManager();
		QnaBean qna = QnaMgr.getQna(no);
		int view = 0;
		//삭제된 게시글 링크를 통해 접근 불가
		//비밀글 링크를 통해 접근 차단
		if(u_id==null || !u_id.equals(qna.getWriter()))
		{
			view = 1;
			int result = QnaMgr.viewUpdate(no);
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
								<h2>질의응답</h2>
							</div>
							<div class="bbs-table-view">
								<table summary="게시글 보기" class="board_table other2">
									<caption>게시글 보기</caption>
									<thead>
										<tr>
											<th><div class="tb-top"><%=qna.getSubject() %></div></th>
										</tr>
									</thead>
									<tbody>
										<tr style="border-bottom: 0px;">
											<td class="umm">
												<div class="cont-sub-des">
													<div>
														<span><em>Date :</em><%=qna.getWritedate().substring(0, 11) + qna.getWritedate().substring(11, 16)%></span>
														<span><em>Name :</em><%=qna.getWriter()%></span>
														<span><em>Hits :</em><%=NumberFormat.getInstance().format(qna.getReadcount()+view)%></span>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="data-bd-cont">
													<div class="attach">
<%
														if(qna.getImage()!=null)
														{
%>
															<div class="qna-img"><img src="img/qna/<%=qna.getImage()%>" alt=""></div>
<%
														}
%>
														<div class="notice-text"><%=qna.getContent() %></div>
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
										<dt>
										</dt>
										<dd>
<%
											if(u_id!=null && u_id.equals(qna.getWriter()))
											{
%>
												<a href="qnaUpdate.jsp?no=<%=no%>" class="View_btn01">EDIT</a>
<%
											}
											if(u_id!=null && (u_id.equals("admin") || u_id.equals(qna.getWriter())))
											{
%>
												<a href="#" onclick="deleteBoard(<%=no%>)" class="View_btn01">DELETE</a>
<%
											}
%>  
											<a href="qnaReWrite.jsp?no=<%=no%>&ref=<%=qna.getRef()%>&re_step=<%=qna.getRe_step()%>&re_level=<%=qna.getRe_level()%>" class="View_btn01">REPLY</a>
											<a href="qna.jsp" class="View_btn01">LIST</a>
											<a href="qnaWrite.jsp" class="View_btn02">WRITE</a>
										</dd>
									</dl>
								</div>
								<!-- //하단 버튼 -->
								<%
								boolean isReply = QnaMgr.existReply(qna.getRef());
								
								if(isReply)
								{
									ArrayList<QnaBean> list = QnaMgr.getReply(qna.getRef());
									if(list.size()>1) {
%>
										<!-- 답변 목록 -->
										<div class="content_row_1" style="margin-bottom:50px";>
											<table class="board_table other1 tableset">
												<caption>답변 목록</caption>
												<thead>
													<tr>
														<th scope="col"><div class="tb-top">목록</div></th>
														<th scope="col"><div class="tb-top">답변 내용</div></th>
														<th scope="col"><div class="tb-top">글쓴이</div></th>
														<th scope="col"><div class="tb-top">작성날짜</div></th>
														<th scope="col"><div class="tb-top">조회수</div></th>
													</tr>
												</thead>
												<tbody>
												<%
												for(int i=0;i<list.size();i++)
												{
													if(list.get(i).getNum() != qna.getNum())
													{
%>
													<tr>
<%
													if(list.get(i).getRe_step()==1)
													{
%>
														<td><div class="tb-center">원글</div></td>
<%
													} else {
%>
														<td><div class="tb-center"><%=list.get(i).getNum() %></div></td>
<%
													}
%>
														<td>
															<div class="tb-left">
																<a href="qnaView.jsp?no=<%=list.get(i).getNum()%>"><%=list.get(i).getSubject() %></a>
															</div>
														</td>
														<td><div class="tb-center"><%=list.get(i).getWriter()%></div></td>
														<td><div class="tb-center"><%=list.get(i).getWritedate().substring(0, 16) %></div></td>
														<td><div class="tb-center"><%=list.get(i).getReadcount() %></div></td>
													</tr>
<%
												}
											}
										}
										%>
										</tbody>
									</table>
								</div>
								<%
								}
								%>
																
								<!-- 이전글 다음글 -->
<%
								int next = QnaMgr.existQna(qna.getRef()+1);
								int prev = QnaMgr.existQna(qna.getRef()-1);
								if(next>0 || prev>0)
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
												if(next>0)
												{
													QnaBean qnaNext = QnaMgr.getQna(next);
%>
													<tr>
														<td><div class="tb-center">다음글</div></td>
														<td>
															<div class="tb-left">
																<a href="qnaView.jsp?no=<%=next%>"><%=qnaNext.getSubject() %></a>
															</div>
														</td>
														<td><div class="tb-center"><%=qnaNext.getWriter() %></div></td>
														<td><div class="tb-center"><%=qnaNext.getWritedate().substring(0, 11) + qnaNext.getWritedate().substring(11, 16)%></div></td>
														<td><div class="tb-center"><%=qnaNext.getReadcount() %></div></td>
													</tr>
<%
												}
												if(prev>0)
												{
													QnaBean qnaPrev = QnaMgr.getQna(prev);
%>
													
													<tr>
														<td><div class="tb-center">이전글</div></td>
														<td>
															<div class="tb-left">
																<a href="qnaView.jsp?no=<%=prev%>"><%=qnaPrev.getSubject() %></a>
															</div>
														</td>
														<td><div class="tb-center"><%=qnaPrev.getWriter() %></div></td>
														<td><div class="tb-center"><%=qnaPrev.getWritedate().substring(0, 11) + qnaPrev.getWritedate().substring(11, 16)%></div></td>
														<td><div class="tb-center"><%=qnaPrev.getReadcount() %></div></td>
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