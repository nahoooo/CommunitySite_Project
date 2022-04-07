<%@page import="com.company.board.vo.RestaurantVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String nickname = (String) session.getAttribute("nickname");

int pg = 0; // page변수로 현재 페이지 값을 받아서 페이징 처리에 이용..
int totalCount = 0;

// 현재 페이지 변수 받음.
if (request.getParameter("page") == null) {
	pg = 1;
} else {
	pg = Integer.parseInt(request.getParameter("page"));
}

//전체 레코드의 수 구하기  차후 구하기...일단 기본 값으로 1로 해놓겠다.
if (request.getAttribute("totalRows") == null) {
	totalCount = 1;
} else {
	totalCount = (Integer) request.getAttribute("totalRows");
}

String searchKeyword = request.getParameter("searchKeyword");
String searchCondition = request.getParameter("searchCondition");

//2.request에 사용할 데이터가 들어가 있다.

ArrayList<RestaurantVO> RestaurantList = (ArrayList<RestaurantVO>) request.getAttribute("RestaurantList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="col align-self-center" style="width: 920px; text-align: center; margin-top: 50px">
		<h3>나만의 맛집 리스트</h3>
		<br> <br> <br>	
		<div class="album py-5">
			<div class="container">
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
				<%
					for (int i = 0; i < RestaurantList.size(); i++) {
						RestaurantVO r = RestaurantList.get(i);
					%>
				
					<div class="col" style="width: 280px; height: 402px; ">
						<div class="card shadow-sm">							
							<div class="card-body" style="padding: 0px; ">
							<%if(r.getThumbnail()!=null){%> 
					 <img class="card-img-top"  src="<%=r.getThumbnail()%>" width="280px" height="224px">					
						<%}else{ %>
						<div><img alt="" src="./resource/images/no_image.png" width="280px" height="224px" style = "object-fit: fill">						
						</div> 
						<%} %>
								<a class="boardtitle" href="GetRestaurantPro?seq=<%=r.getSeq()%>"><%=r.getTitle()%></a>
								<p class="card-text"><%=r.getRestaurantname() %><br><%=r.getNickname() %><br><%=r.getOnelinereview() %></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										
										<p> <img src="./resource/images/eye.svg">  <%=r.getCnt() %></p>&nbsp;&nbsp;
										<p> <img src="./resource/images/chat-dots.svg">  <%=r.getComment_cnt() %></p>
										
									</div>
									<small class="text-muted"><%=r.getRegdate()%></small>
								</div>
							</div>
						</div>
					</div>
			

				<%} %>
				</div>
		</div>

	</div>
	<!-- 페이지 리스트 삽입 시작 부분-->
	<%
	int countList = 9; // 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
	int countPage = 9; // 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)

	int totalPage = totalCount / countList; // totalPage는 전체 페이지 수 (전체 게시물 / 한 페이지에 출력될 게시물 수)

	if (totalCount % countList > 0) {
		// totalCount를 countList로 나눈 나머지 값이 존재한다는 것은 한 페이지가 더 있다는 의미이다.
		totalPage++;
	}

	if (totalPage < pg) {// 현재 페이지가 전체 페이지보다 크다면 이는 출력될 페이지 범위를 벗어난 현제 페이지를 의미
		// 따라서 현재페이지를 가장 끝 페이지인 totalPage로 이동시킨다.
		pg = totalPage;
	}

	int startPage = ((pg - 1) / 9) * 9 + 1;
	// 현재 페이지를 기준으로 한 화면에서 시작 페이지 값을 보여준다.

	int endPage = startPage + countPage - 1;
	// 현재 페이지를 기준으로 한 화면에서 끝 페이지 값을 보여준다.

	// 전체 게시물이 255개 기준으로 할 경우 전체 페이지는 26개가 나온다. 내가 보려고 하는 현재
	// 페이지가 22페이지라고 했을 때 21에서 30까지 나오면 전체 페이지는 26까지 있기 때문에 실제
	// 리스트를 가지고 있지 않은 페이지가 발생한다. (27,28,29,30 페이지 해당)
	if (endPage > totalPage) {
		endPage = totalPage;
	}

	if (searchKeyword == null) {
		if (startPage > 1) {
	%>
	<a href="GetRestaurantListPro?page=1">처음</a>
	<%
	}

	if (pg > 1) {
	%>
	<a href="GetRestaurantListPro?page=<%=pg - 1%>">이전</a>
	<%
	}

	for (int iCount = startPage; iCount <= endPage; iCount++) {
	if (iCount == pg) {
	%>

	<b><%=iCount%></b>&nbsp;

	<%
	} else {
	%>

	&nbsp;
	<a href="GetRestaurantListPro?page=<%=iCount%>"><%=iCount%></a>
	&nbsp;

	<%
	}
	}

	if (pg < totalPage) {
	%>
	<a href="GetRestaurantListPro?page=<%=pg + 1%>">다음</a>
	<%
	}

	if (endPage < totalPage) {
	%>
	<a href="GetRestaurantListPro?page=<%=totalPage%>">끝</a>
	<%
	}
	} else if (searchKeyword != null) {
	if (startPage > 1) {
	%>
	<a href="SearchPro?page=1&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>">처음</a>
	<%
	}

	if (pg > 1) {
	%>
	<a href="SearchPro?page=<%=pg - 1%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>">이전</a>
	<%
	}

	for (int iCount = startPage; iCount <= endPage; iCount++) {
	if (iCount == pg) {
	%>

	<b><%=iCount%></b>&nbsp;

	<%
	} else {
	%>

	&nbsp;
	<a href="SearchPro?page=<%=iCount%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>"><%=iCount%></a>
	&nbsp;

	<%
	}
	}

	if (pg < totalPage) {
	%>
	<a href="SearchPro?page=<%=pg + 1%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>">다음</a>
	<%
	}

	if (endPage < totalPage) {
	%>
	<a href="SearchPro?page=<%=totalPage%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>">끝</a>
	<%
	}
	}
	%>


	<%
	if (nickname != null) {
	%>
	<a href="index.jsp?filePath=addRestaurant">글쓰기</a>
	&nbsp;&nbsp;
	<%
	}
	%>
	<a href="GetRestaurantListPro">글 목록</a>
	<div class="container">
		<!-- 검색 시작 -->
		<form method="get" action="SearchPro">
			<select name="searchCondition">
				<option value="title">제목
				<option value="content">내용
				<option value="nickname">작성자
			</select>
			<input type="text" name="searchKeyword" /> <input type="submit" value="검색" />
		</form>
		<!-- 검색 종료 -->
	</div>
	</div>
</body>
</html>