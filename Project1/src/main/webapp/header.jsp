<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String filePath = request.getParameter("filePath");
if (filePath == null) {
	filePath = "home";
}
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
				<a class="navbar-brand" href="index.jsp" style="font-size: xx-large;">
					<img src="./resource/images/logo.png" alt="" width="60" height="100" class="d-inline-block align-text-top"> 
					<span style="padding-top: 20px">NaHo</span>	
				</a>							
			</div>				
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<ul class="nav justify-content-center">
					<li class="nav-item"><a class="nav-link">공지사항</a></li>
					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">COMMUNITY</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
							<li><a class="dropdown-item">영화</a></li>
							<li><a class="dropdown-item">게임</a></li>
							<li><a class="dropdown-item">음악</a></li>
							<li><a class="dropdown-item">쇼핑</a></li>
							<li><a class="dropdown-item">음식</a></li>
							<li><a class="dropdown-item">자유게시판</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link">TIMELINE?채팅?</a></li>
					<li class="nav-item"><a class="nav-link" href="index.jsp?filePath=login">LOGIN</a></li>
				</ul>
			</div>
		</nav>
	</header>

	<div id="headerbar" class="text-center">
		<div class="container">
			<div class="row">
				<div class="col-sm-4">
					<h1><%=filePath%></h1>
				</div>
				<div class="col-sm-8">
					<ul class="nav justify-content-end">
						<li class="nav-item"><a class="nav-link" href="#">로그인시 쪽지</a></li>
						<li class="nav-item"><a class="nav-link" href="#">로그인정보(프로필사진드롭박스)</a></li>
						<li>
							<form class="d-flex">
								<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
								<button type="button" class="btn btn-success">search</button>
							</form>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>