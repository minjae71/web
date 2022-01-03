<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.QnaBean" %>
<%@ page import="board.QnaManager" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1,user-scalable=no">
	
	<link rel="shortcut icon" href="img/lily_icon.png">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/Write.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<script src="js/script.js"></script>
	
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
		<script>
			alert("로그인 후 이용 가능합니다.");
			history.back();
		</script>
<%
	}
	
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
	}
	
	int ref = Integer.parseInt(request.getParameter("ref"));
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	//유효한 글이라면 구체적인 정보를 'qnaboard'라는 인스턴스에 담는다.
	QnaBean qna = new QnaManager().getQna(no);
	
	int writeType = qna.getWriteType();
%>
	<div id="wrap">
		<div id="contentWrapper">
			<div id="C_Wrap" style="margin-top: 120px;">
				<div class="p-update">
					<div class="tit-page-2">
						<h2>질의응답</h2>
						<p class="dsc"></p>
					</div>
					<div class="page-body">
						<!-- 문의 입력 폼 -->
						<form name="personal" id="personal_form" enctype="multipart/form-data" method="post" action="qnaReWriteAction.jsp?no=<%=no%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>">
							<fieldset>
								<legend>QnA 폼</legend>
								<div class="table-d2-view">
									<table summary="">
										<caption>QnA</caption>
										<colgroup>
											<col width="155">
											<col width="*">
										</colgroup>
										<input type="hidden" name="writer" value="<%=u_id %>">
										<input type="hidden" name="no" value="<%=no %>">
										<input type="hidden" name="ref" value="<%=ref %>">
										<input type="hidden" name="re_step" value="<%=re_step%>">
										<input type="hidden" name="re_level" value="<%=re_level%>">
										<%
											if(qna.getWriteType()==2)
											{
												%>
												<input type="hidden" name="writeType" value="<%=writeType %>">
												<%
											}
										%>
										<tbody>
											<tr>
												<th scope="row"><div class="tb-left">제목</div></th>
												<td><div class="tb-right"><input type="text" name="subject" class="input_txt txt-input2" id="" autocomplete="off" value="<%=qna.getSubject()%>"></div></td>
												<td><input type = "checkbox" name = "writeType">비밀글</td>
											</tr>
											<tr>
												<th scope="row" rowspan="2"><div class="tb-left">내용</div></th>
												<td colspan="2"><div class="tb-right"><textarea name="content" rows="15" cols="57" class="input_textarea txt-area1" id="content" autocomplete="off"></textarea></div></td>
											</tr>
											<tr>
												<td colspan="2"><div class="tb-right pre-img"><img name="preview" src="" style="max-width: 50%;"></div>
											</tr>
											<tr>
												<th scope="row"><div class="tb-left">파일첨부</div></th>
												<td colspan="2"><div class="tb-right"><input type="file" name="image" class="input_file" onchange="qnaFilePreview()"> </div></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="foot_BTN-set">
									<div class="btn-foot01">
										<button type="button" class="btn-foot011" onclick = "location.href='qna.jsp'">목록</button>
									</div>
									<div class="btn-foot02">
										<button type="button" class="btn-foot021" onclick="checkValidationBoard()">등록</button>
										<button type="reset" class="btn-foot022">다시작성</button>
									</div>
								</div>
							</fieldset>
						</form>
					</div><!-- .page-body -->
				</div><!-- .p-update -->
			</div>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>