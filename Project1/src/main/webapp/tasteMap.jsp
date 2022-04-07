<%@page import="com.company.board.vo.RestaurantVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");
ArrayList<RestaurantVO> restaurantList = (ArrayList<RestaurantVO>) request.getAttribute("restaurantList");
%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<meta charset="UTF-8">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08b402e028254d6d57047b09a9521f83"></script>
<title></title>
<style>
.wrap {
	position: absolute;
	left: 0;
	bottom: 40px;
	width: 288px;
	height: 132px;
	margin-left: -144px;
	text-align: left;
	overflow: hidden;
	font-size: 12px;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	line-height: 1.5;
}

.wrap * {
	padding: 0;
	margin: 0;
}

.wrap .info {
	width: 286px;
	height: 120px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.wrap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	padding: 5px 0 0 10px;
	height: 30px;
	font-size: 20px;
	font-weight: bold;
}

.info .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
	cursor: pointer;
}

.info .body {
	position: relative;
	overflow: hidden;
}

.info .desc {
	position: relative;
	margin: 13px 0 0 90px;
	height: 75px;
}

.desc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.desc .starrating {
	font-size: 2em;
	color: #888;
	margin-top: -15PX;
}

.info .img {
	position: absolute;
	top: 6px;
	left: 5px;
	width: 73px;
	height: 71px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}

.info:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: 0;
	width: 22px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.info .link {
	color: #5085BB;
}
</style>
</head>
<body>
	<div class="d-flex">

		<div id="map" style="width: 800px; height: 600px;"></div>
		<div style="width: 500px;">			
			<div id="tastemapdetaile">				
				<h1 align="center" id="restaurantname"></h1>
						<div id="carouselExampleSlidesOnly" style="width: 500px; height: 300px" class="carousel slide" data-bs-ride="carousel">				
							<img id="thumbnail" src="./resource/images/default_profile.jpg" height="300" width="500" class="d-block w-100" style="object-fit: contain">								
						</div>				
			<table>				
				<tr>
					<th>주소</th>
					<td id="addr"></td>
				</tr>
				
				<tr>
					<th ><span id="nickname"></span>님의 한줄평</th>					
					<td id="review" colspan="2"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td id="tel"></td>										
				</tr>	
				<tr>
					<th>주차가능여부</th>
					<td id="parking"></td>
				</tr>		
			</table>
			</div>
		</div>
	</div>
	<script>
/////////////////지도의 중심을 사용자 위치로 변경///////////////////////

function detail(seq) {	
		$.ajax({
			type : "post", //통신타입 설정. get,post등의 방식 사용.
			url : "TasteMapDetail", //요청 url 자원의 고유 위치			
			data : {//서버에 요청할때 보낼 매개변수 설정. 보낼변수 이름 : 변수 값		
				seq : seq
			},
			dataType : "json",
			async: true,						
			success : function(data) { //요청한 페이지에서 보내온 값을 data란 변수로 받아온다.
 				$('#restaurantname').text(data.restaurantname);
 				$('#nickname').text(data.nickname);
 				$('#review').text(data.onelinereview);
 				$('#addr').text(data.restaurantaddr);
 				$('#parking').text(${data.parking});
 				$('#tel').text(${data.tel}); 				
 				$('#thumbnail').attr("src",data.thumbnail);				 												
			}, //요청응답에 성공했을 때 처리 할 구문.
			error : function() {
				alert('전송 실패')
			}//요청 실패시 나오는 구문.
		});
	};


	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨 
	    }; 
	 
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	 
	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon) // geolocation으로 얻어온 좌표
	        presentPosition=locPosition;
	 
	        map.setCenter(locPosition);   
	            
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 
	    
	    var locPosition = new kakao.maps.LatLng(37.566826, 126.9786567)
	    alert('현재 위치를 찾을 수 없습니다!');
	}
	
	// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열
	var positions = [];
	var imageurlreal =[];
	
	<%for (int i = 0; i < restaurantList.size(); i++) {
	RestaurantVO r = restaurantList.get(i);%>			
			positions.push(
				{					
					seq : <%=r.getSeq()%>,
					latlng : new kakao.maps.LatLng(<%=r.getPlaceLO()%>, <%=r.getPlaceLa()%>),
					restaurantname : '<%=r.getRestaurantname()%>', 
					nickname : '<%=r.getNickname()%>',					
					onelinereview : "<%=r.getOnelinereview()%>",
					starrating : <%=r.getStarrating()%>,
					<%if (r.getThumbnail() != null) {%>
					image : '<%=r.getThumbnail().trim()%>'
					<%} else {%>
					image :  './resource/images/no_image.png'
					<%}%>
				}, 						
			); 							
	<%}%>			
	
	for(let i=0; i < positions.length; i++){
	    var data = positions[i];
	   
	    displayMarker(data);

	 	
	// 지도에 마커를 표시하는 함수입니다    
	function displayMarker(data) { 
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position : data.latlng
	    });
	    var overlay = new kakao.maps.CustomOverlay({
	        yAnchor: 3,
	        position: data.latlng  
	    });
	    ////////////////커스텀오버레이 작성코드//////////////////////////////
	    				var Customcontent = document.createElement('div');
						Customcontent.className = "wrap";

						var info = document.createElement('div');
						info.className = "info"			
						Customcontent.appendChild(info);

						//커스텀오버레이 식당이름
						var contentTitle = document.createElement("div");
						contentTitle.className = "title"
						contentTitle.appendChild(document.createTextNode(data.restaurantname));
						info.appendChild(contentTitle);
						
						//커스텀오버레이 닫기 버튼
						var closeBtn = document.createElement("div");
						closeBtn.className = "close";
						closeBtn.setAttribute("title","닫기");
						closeBtn.onclick = function() { overlay.setMap(null); };
						contentTitle.appendChild(closeBtn);

					 	var bodyContent = document.createElement("div");
						bodyContent.className = "body";
						info.appendChild(bodyContent);

 						 var imgDiv = document.createElement("div");
						imgDiv.className = "img";
						bodyContent.appendChild(imgDiv);
						
						//커스텀오버레이 이미지
						var imgContent = document.createElement("img");
						imgContent.setAttribute("src",data.image);
						imgContent.setAttribute("width", "73");
						imgContent.setAttribute("heigth", "70");
						imgDiv.appendChild(imgContent); 

				 		var descContent = document.createElement("div");
						descContent.className = "desc"
						bodyContent.appendChild(descContent);  

						//커스텀오버레이 별점	
						var starratingContent = document.createElement("div");
						starratingContent.className = "starrating";
						starratingContent.appendChild(document.createTextNode("☆"+data.starrating));
						descContent.appendChild(starratingContent);

				 		 //커스텀오버레이 한줄평
						var onelinereviewContent = document.createElement("div");
						onelinereviewContent.className = "onelinereview";
						onelinereviewContent.appendChild(document.createTextNode(data.onelinereview));
						descContent.appendChild(onelinereviewContent);

						var LinkDiv = document.createElement("div");
						descContent.appendChild(LinkDiv); 

						//커스텀오버레이 상세보기
					 	var LinkContent = document.createElement("a");						
  						LinkContent.setAttribute("onclick",'detail('+data.seq+');');
 				    	//LinkContent.setAttribute("target", "_blank");						
						LinkContent.className = "link";
						LinkContent.appendChild(document.createTextNode("상세보기"));
						LinkDiv.appendChild(LinkContent);   
						
						//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 끝

						overlay.setContent(Customcontent);
						
						kakao.maps.event.addListener(marker, 'click', function() {
					        overlay.setMap(map);
					    });

	};	
};	





		
	</script>
</body>
</html>