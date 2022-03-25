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
<title>Insert title here</title>
</head>
<body>

	<div class="container" style="width: 920px; margin: auto auto">
		<h1>식당 정보</h1>

		<div class="product__details__pic__slider owl-carousel owl-loaded owl-drag">
			<div class="owl-stage-outer">
				<div class="owl-stage" style="transform: translate3d(-525px, 0px, 0px); transition: all 1.2s ease 0s; width: 1050px;">
					
					<%=imageurlArry[i]%>
							<%
							for (int i = 0; i < imageurlArry.length; i++) {
							%>
							<div class="owl-item cloned" style="width: 67.5px; margin-right: 20px;">
							<img data-imgbigurl="img/product/details/product-details-2.jpg" src="img/product/details/thumb-1.jpg" alt="">
							</div>
							
							
							<%
							}
							%>
																			
					<div class="owl-item cloned" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-2.jpg" src="img/product/details/thumb-1.jpg" alt="">
					</div>
					<div class="owl-item cloned" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-3.jpg" src="img/product/details/thumb-2.jpg" alt="">
					</div>
					<div class="owl-item cloned" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-5.jpg" src="img/product/details/thumb-3.jpg" alt="">
					</div>
					<div class="owl-item cloned" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-4.jpg" src="img/product/details/thumb-4.jpg" alt="">
					</div>
					<div class="owl-item" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-2.jpg" src="img/product/details/thumb-1.jpg" alt="">
					</div>
					<div class="owl-item" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-3.jpg" src="img/product/details/thumb-2.jpg" alt="">
					</div>
					<div class="owl-item active" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-5.jpg" src="img/product/details/thumb-3.jpg" alt="">
					</div>
					<div class="owl-item active" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-4.jpg" src="img/product/details/thumb-4.jpg" alt="">
					</div>
					<div class="owl-item cloned active" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-2.jpg" src="img/product/details/thumb-1.jpg" alt="">
					</div>
					<div class="owl-item cloned active" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-3.jpg" src="img/product/details/thumb-2.jpg" alt="">
					</div>
					<div class="owl-item cloned" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-5.jpg" src="img/product/details/thumb-3.jpg" alt="">
					</div>
					<div class="owl-item cloned" style="width: 67.5px; margin-right: 20px;">
						<img data-imgbigurl="img/product/details/product-details-4.jpg" src="img/product/details/thumb-4.jpg" alt="">
					</div>
				</div>
			</div>
			<div class="owl-nav disabled">
				<button type="button" role="presentation" class="owl-prev">
					<span aria-label="Previous">‹</span>
				</button>
				<button type="button" role="presentation" class="owl-next">
					<span aria-label="Next">›</span>
				</button>
			</div>
			<div class="owl-dots disabled">
				<button role="button" class="owl-dot active">
					<span></span>
				</button>
			</div>
		</div>
	</div>
</body>
</html>