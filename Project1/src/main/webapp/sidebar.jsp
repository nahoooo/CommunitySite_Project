<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nickname = (String) session.getAttribute("nickname");
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 240px;">
	<a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
		<svg class="bi me-2" width="40" height="32">
			<use xlink:href="#bootstrap"></use></svg>
		<span class="fs-4">오늘뭐먹지</span>
	</a>
	<div class="dropdown">
		<%
		if (nickname == null) {
		%>
		<p>로그인으로 더 재미있게!</p>
		<button>로그인</button>
		<%
		} else {
		%>
		<a href="#" class="d-flex align-items-center link-dark text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false">
			<img src="https://github.com/mdo.png" alt="" width="32" height="32" class="rounded-circle me-2"> <strong><%=nickname%></strong>
		</a>
		<ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2">
			<li><a class="dropdown-item" href="#">쪽지</a></li>
			<li><a class="dropdown-item" href="#">내정보</a></li>
			<li><hr class="dropdown-divider"></li>
			<li><a class="dropdown-item" href="Logout">로그아웃</a></li>
		</ul>
		<%
		}
		%>
	</div>
	<hr>
	<ul class="nav nav-pills flex-column mb-auto">
		<li class="nav-item"><a href="#" class="nav-link" aria-current="page"> Home </a></li>
		<li><a href="#" class="nav-link link-dark"> 나만의맛집 </a></li>		
		<li class="mb-1">
			<button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">커뮤니티</button>
			<div class="collapse" id="account-collapse">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="#" class="link-dark rounded">공지사함</a></li>
					<li><a href="#" class="link-dark rounded">맛집방문기</a></li>
					<li><a href="#" class="link-dark rounded">나만의레시피</a></li>
					<li><a href="#" class="link-dark rounded">자유게시판</a></li>
					<li><a href="#" class="link-dark rounded">문의사항</a></li>
				</ul>
			</div>
		</li>		
	</ul>
	<hr>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
</body>
</html>