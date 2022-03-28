<%@page import="com.company.board.vo.RestaurantVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
//사용자의 닉네임이 세션으로 저장되어있음.
String nickname = (String) session.getAttribute("nickname");

//1.Servlet이 전달한 데이터를 받는다.

RestaurantVO restaurant = (RestaurantVO) request.getAttribute("restaurant");

//게시글 작성자의 닉네임.
String WriterNn = restaurant.getNickname();

String imageurl = restaurant.getImageurl();
String[] imageurlArry = imageurl.split(",");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>



<title>맛집 상세보기</title>
</head>
<body >
	<div class="container" style="margin: auto auto; width: 100%">

		<div id="carouselExampleSlidesOnly" style="width: 500px; height: 300px" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
				<%
				for (int i = 0; i < imageurlArry.length; i++) {
					if (i > 0) {
				%>
				<div class="carousel-item">
					<img src="<%=imageurlArry[i]%>"  height="300" width="500" class="d-block w-100" style="object-fit:contain">
				</div>
				<%
				} else {
				%>
				<div class="carousel-item active">
					<img src="<%=imageurlArry[i]%>" height="300" width="500" class="d-block w-100" style="object-fit:contain">
				</div>
				<%
				}
				}
				%>
			</div>
		</div>
		
	</div>


</body>
</html>