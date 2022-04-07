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
		<span class="fs-4">오늘뭐먹지?</span>
	</a>
	<br>
	<div class="dropdown">
		<%
		if (nickname == null) {
		%>
		<div align="center">
		<p>로그인으로 더 맛있게!</p>
		<br>
		<button class="btn btn-success">로그인</button>
		</div>
		<br>
		<%
		} else {
		%>
			<div align="center">
			<img src=".${sessionScope.userProfile }" alt="" width="120" height="120" class="rounded-circle me-2">
			<p><strong><%=nickname %> 님</strong></p>
			<table>
			<tr>
			<td><a class="dropdown-item" href="">쪽지</a></td>
			<td><a class="dropdown-item" href="UserProfile">내정보</a></td>
			</tr>
			<tr>			
			<td colspan="1"><a class="dropdown-item" href="Logout">로그아웃</a></td>
			</tr>
			</table>
			</div>
		<%
		}
		%>
	</div>
	<hr>
	<ul class="nav nav-pills flex-column mb-auto">
		<li class="nav-item"><a href="index.jsp" class="nav-link link-dark"> Home </a></li>
		<li><a href="TasteMap" class="nav-link link-dark"> 맛지도 </a></li>		
		<li><a href="GetRestaurantListPro" class="nav-link link-dark"> 나만의맛집 </a></li>	
		<li><hr></li>	
		<li>Community</li>					
				
					<li><a href="GetBoardListPro?boardtype=notice" class="nav-link link-dark">공지사함</a></li>
					<li><a href="GetBoardListPro?boardtype=review" class="nav-link link-dark">맛집방문기</a></li>
					<li><a href="GetBoardListPro?boardtype=recipe" class="nav-link link-dark">나만의레시피</a></li>
					<li><a href="GetBoardListPro?boardtype=free" class="nav-link link-dark">자유게시판</a></li>
					<li><a href="GetBoardListPro?boardtype=questions" class="nav-link link-dark">문의사항</a></li>
										
	</ul>
	<hr>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
</body>
</html>