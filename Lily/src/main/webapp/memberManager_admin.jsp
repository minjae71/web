<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberBean" %>
<%@ page import="member.MemberManager" %>
<%@ page import="java.util.ArrayList" %>
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
	<link rel="stylesheet" type="text/css" href="css/member.css">  
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" integrity="sha384-tKLJeE1ALTUwtXlaGjJYM3sejfssWdAaWR2s97axw4xkiAdMzQjtOjgcyw0Y50KU" crossorigin="anonymous">
	<link rel="stylesheet" href="css/swiper-bundle.min.css"/>
	
	<script src="js/main_slider.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<script>
		function deleteMember(memberId) {
			var member = memberId;
			if(confirm("정말로 삭제하시겠습니까?")) {
				location.href="memberDeleteAction_admin.jsp?id=" + member;
			} else {
				alert("삭제가 취소되었습니다.");
			return false;
			}
		}
	</script>
	
	<title>회원관리</title>
</head>
<body>
	<div id="wrap">
<%
	String u_id=(String)session.getAttribute("ID");
	if(u_id==null || !u_id.equals("admin"))
	{
%>
		<script>
			alert("접근 권한이 없습니다.");
			history.back();
		</script>
<%
	} else {
%>
		<%@include file = "header_admin.jsp" %>	
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
		int number = 0;
		int currentPage = Integer.parseInt(pageNum);
		
		MemberManager memberMgr = new MemberManager();
		count = memberMgr.countMember();
		
		int startRow = (currentPage - 1) * pageSize;
		ArrayList<MemberBean> list = memberMgr.getList(startRow, pageSize);
		number = count - (currentPage - 1) * pageSize;
%>
		<div id="contentWrapper">
			<section class="content_section">
				<div class="content_row_2">
					<div class="sub_header_section">
						<h2>회원관리</h2>
					</div>
				</div>
				
				<div class="content_row_1">
					<table class="member_table">
						<caption>회원관리</caption>
						<thead>
							<tr>
								<th>이름</th>
								<th>아이디</th>
								<th>비밀번호</th>
								<th>이메일</th>
								<th>주소</th>
								<th>전화번호</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
<%
							if(list.size()!=0)
							{
								for(int i=0;i<list.size();i++)
								{
									String postcode = list.get(i).getPostcode();
									if(postcode==null)
									{
										postcode = "";
									}
									String address = list.get(i).getAddress();
									if(address==null)
									{
										address = "";
									}
									String detailAddress = list.get(i).getDetailAddress();
									if(detailAddress==null)
									{
										detailAddress = "";
									}
									String extraAddress = list.get(i).getExtraAddress();
									if(extraAddress==null)
									{
										extraAddress = "";
									}
									String userId = list.get(i).getId();
%>
									<tr>
										<td><%=list.get(i).getName()%></td>
										<td><%=userId %></td>
										<td><%=list.get(i).getPwd() %></td>
										<td><%=list.get(i).getEmail() %></td>
										<td><%=postcode %> <%=address%> <%=detailAddress %> <%=extraAddress%></td>
										<td><%=list.get(i).getPhone1()%>-<%=list.get(i).getPhone2()%>-<%=list.get(i).getPhone3()%></td>
										<td>
											<button type="button" class="update-btn" onclick="location.href='memberUpdate_admin.jsp?id=<%=list.get(i).getId()%>'">수정</button>
											<button type="button" class="delete-btn" onclick="deleteMember('<%=userId%>')">삭제</button>
										</td>
									</tr>
<%
								}
							} else {
%>
								<tr>
									<td colspan="7">가입된 회원이 없습니다!</td>
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
							<span class="FFist_prev_btn"><a href="notice.jsp?page=<%=startPage - 10%>">이전 버튼</a></span>
<%
						}
						if(startPage>1)
						{
%>
							<span class="FFist_prev_btn"><a href="notice.jsp?page=<%=startPage - 1%>">이전 버튼</a></span>
<%
						}
						//페이징 처리
						for (int i = startPage; i <= endPage; i++) {
%>
							<a href="notice.jsp?page=<%=i%>"><%=i%></a>
<%
						}
						if(currentPage<pageCount)
						{
%>
							<span class="FFist_prev_btn"><a href="notice.jsp?page=<%=startPage - 1%>">이전 버튼</a></span>
<%
						}
						//다음이라는 링크를 만들건지 파악
						if (endPage < pageCount) {
%>
							<span class="Llist_next_btn"><a href="notice.jsp?page=<%=startPage + 10%>">다음 버튼</a></span>
<%
						}
					}
%>
				</div>
			</section>
		</div>
		<%@include file="footer.jsp" %>
	</div> <!--전체 페이지-->
</body>
</html>