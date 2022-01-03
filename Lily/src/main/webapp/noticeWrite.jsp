<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	if(u_id==null || !u_id.equals("admin"))
	{
%>
		<script>
			alert("접근 권한이 없습니다!");
			history.back();
		</script>
<%
	} else {
%>
		<%@include file = "header_admin.jsp" %>	
<%
	}
%>
	<div id="wrap">
		<div id="contentWrapper">
			<div id="C_Wrap" style="margin-top: 120px;">
				<div class="p-update">
					<div class="tit-page-2">
						<h2>공지사항</h2>
						<p class="dsc"></p>
					</div>
					
					<div class="page-body">
						<!-- 문의 입력 폼 -->
						<form name="personal" id="personal_form" enctype="multipart/form-data" method="post" action="noticeWriteAction.jsp">
							<fieldset>
								<legend>공지사항</legend>
								<div class="table-d2-view">
									<table summary="">
										<caption>공지사항</caption>
										<input type="hidden" name="writer" value="admin"/>
										<colgroup>
											<col width="155">
											<col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><div class="tb-left">제목</div></th>
												<td><div class="tb-right"><input type="text" name="subject" class="input_txt txt-input23" id="" autocomplete="off" required/></div></td>
											</tr>
											<tr>
												<th scope="row" rowspan="2"><div class="tb-left">내용</div></th>
												<td><div class="tb-right"><textarea name="content" rows="15" cols="57" class="input_textarea txt-area1" id="content" autocomplete="off" required></textarea></div></td>
											</tr>
											<tr>
												<td><div class="tb-right"><img name="preview" src=""></div></td>
											</tr>
											<tr>
												<th scope="row"><div class="tb-left">파일첨부</div></th>
												<td><div class="tb-right"><input type="file" name="image" class="input_file" onchange="noticeFilePreview()"> </div></td>
											</tr>
										</tbody>
									</table>
								</div>
								
								<div class="foot_BTN-set">
									<div class="btn-foot01">
										<button type="button" class="btn-foot011" onclick = "location.href='notice.jsp'">목록</button>
									</div>
									<div class="btn-foot02">
										<button type="button" class="btn-foot021" onclick="checkValidationBoard()">등록</button>
										<button type="reset" class="btn-foot022" onclick="resetInsertData()">다시작성</button>
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