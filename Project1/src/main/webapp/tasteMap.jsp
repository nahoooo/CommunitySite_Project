<%@page import="com.company.board.vo.RestaurantVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
ArrayList<RestaurantVO> restaurantList = (ArrayList<RestaurantVO>) request.getAttribute("restaurantList");
%>
<!DOCTYPE html>
<html>
<head>
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
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
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

.desc .jibun {
	font-size: 11px;
	color: #888;
	margin-top: -2px;
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
		<div style="width: 300px;">식당정보</div>
	</div>
	<script>
/////////////////지도의 중심을 현재 위치로 변경///////////////////////
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
			
	<%for (int i = 0; i < restaurantList.size(); i++) {
	RestaurantVO r = restaurantList.get(i);%>						
			positions.push(
				{
					content : '<div class="wrap">' + 
		            '    <div class="info">' + 
		            '        <div class="title">' + 
		            '            <%=r.getRestaurantname()%>' + 
		            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
		            '        </div>' + 
		            '        <div class="body">' + 
		            '            <div class="img">' +		         
		            '           </div>' + 
		            '            <div class="desc">' + 
		            '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' + 
		            '                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' + 
		            '                <div><a href="https://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' + 
		            '            </div>' + 
		            '        </div>' + 
		            '    </div>' +    
		            '</div>',
					latlng : new kakao.maps.LatLng(<%=r.getPlaceLO()%>, <%=r.getPlaceLa()%>),
					seq : <%=r.getSeq()%>
				}, 						
			); 			
			console.log("등록");
	<%}%>
	console.log(positions[0].seq)
	console.log(positions[1].seq)
	console.log(positions[2].seq)
	
 
	
	for (var i = 0; i < positions.length; i++) {
		// 마커를 생성합니다
			var	marker  = new kakao.maps.Marker({
			map : map, // 마커를 표시할 지도	
			position : positions[i].latlng// 마커의 위치					
			});		
			//마커 위에 커스텀오버레이를 표시합니다
			//마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
			var overlay= new kakao.maps.CustomOverlay({
			content: positions[i].content,
			map: map,
			position: positions[i].latlng       
			});
		
		};
		
	


//마커를 클릭했을 때 커스텀 오버레이를 표시합니다
kakao.maps.event.addListener(marker, 'click', function() {
overlay.setMap(map);
});

//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
overlay.setMap(null);     
}	

		 
				
	

	
	

		
	</script>
</body>
</html>