<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String filePath = request.getParameter("filePath");
String Currentlocation = null;
if (filePath == null) {
	Currentlocation = "home";
} else if (filePath.contains("board") || filePath.contains("Board")) {
	Currentlocation = "COMMUNITY";
}else if (filePath.contains("goodRestaurant")){
	Currentlocation="나만의 맛집";
}

String nickname = (String) session.getAttribute("nickname");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
</head>
<body>
	<header id="header">
		<nav class="navbar navbar-expand-lg navbar-light bg-wight ">
			<div class="container">
				<div>
					<form class="d-flex">
						<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
						<button type="button" class="btn btn-success">search</button>
					</form>
				</div>
				<div style="text-align: center;">
					<a class="navbar-brand" href="index.jsp" style="font-size: xx-large;">
						<img src="./resource/images/restaurant.png" alt="" width="50" height="50" class="d-inline-block align-text-top"> <span style="padding-top: 20px">NaHo</span>
					</a>
				</div>	
				<div>
					<ul class="nav justify-content-end">
						<%
						if (nickname == null) {
						%>
						<li class="nav-item"><a class="nav-link" href="index.jsp?filePath=login">Login</a></li>
						<%
						} else if (nickname != null) {
						%>
						<li class="nav-item"><a class="nav-link" href="#">쪽지</a></li>
						<li class="nav-item"><a class="nav-link" href="#"><%=nickname%>님</a></li>
						<li class="nav-item"><a class="nav-link" href="Logout">LOGOUT</a></li>
						<%
						}
						%>
					</ul>
				</div>				
			</div>
		</nav>
	</header>

	<div id="headerbar" class="text-center">
		<div class="container">
			<div class="row">
				<div class="col-sm-4">
					<h3 id="CL" style="margin-bottom: 0px; text-align: left;"><%=Currentlocation%></h3>
				</div>
				<div class="col-sm-8">
					<ul class="nav justify-content-end">
						<li class="nav-item"><a class="nav-link" href="">맛집지도</a></li>
						<li class="nav-item"><a class="nav-link" href="">지역맛집</a></li>
						<li class="nav-item"><a class="nav-link" href="index.jsp?filePath=addRestaurant">나만의 맛집</a></li>
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">COMMUNITY</a>
							<ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDropdownMenuLink">
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=notice">공지사항</a></li>
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=review">맛집방문기</a></li>
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=recipe">나만의레시피</a></li>
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=free">자유게시판</a></li>
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=questions">문의사항</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>