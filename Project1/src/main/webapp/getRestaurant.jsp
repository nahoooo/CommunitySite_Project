<%@page import="com.company.board.vo.ReplyBoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.board.vo.RestaurantVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
//사용자의 닉네임이 세션으로 저장되어있음.
String nickname = (String) session.getAttribute("nickname");

//1.Servlet이 전달한 데이터를 받는다.

RestaurantVO r = (RestaurantVO) request.getAttribute("restaurant");
ArrayList<ReplyBoardVO> replylist = (ArrayList<ReplyBoardVO>) request.getAttribute("replylist");

//게시글 작성자의 닉네임.
String WriterNn = r.getNickname();

String imageurl = r.getImageurl();
String[] imageurlArry = null;
if (imageurl != null) {
	imageurlArry = imageurl.split("\n");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<title>맛집 상세보기</title>
<style type="text/css">
ul {
	list-style: none;
}

.content img {
	width: 800px;
	height: 600px;
	object-fit: contain;
}



.starrating{
  -webkit-text-fill-color: gold;
}
</style>
</head>
<body>
	<div class="container" style="margin: auto auto; width: 980px">

		<!--제목 닉네임  -->
		<div align="center" style="width: 700px">
			<div>
				<h1><%=r.getTitle()%></h1>
			</div>
			<section>
				<ul>
					<li><span><%=r.getNickname()%></span> <span><%=r.getRegdate()%></span></li>
				</ul>
			</section>
		</div>
		<!--이미지,식당정보  -->
		<div class="d-flex">
			<div id="carouselExampleSlidesOnly" style="width: 500px; height: 300px" class="carousel slide" data-bs-ride="carousel">
				<div class="carousel-inner">
					<%
					if (imageurl != null) {
						for (int i = 0; i < imageurlArry.length; i++) {
							if (i > 0) {
					%>
					<div class="carousel-item">
						<img src="<%=imageurlArry[i]%>" height="300" width="500" class="d-block w-100" style="object-fit: contain">
					</div>
					<%
					} else {
					%>
					<div class="carousel-item active">
						<img src="<%=imageurlArry[i]%>" height="300" width="500" class="d-block w-100" style="object-fit: contain">
					</div>
					<%
					}
					}
					} else {
					%>
					<div class="carousel-item active">
						<img src="./resource/images/no_image.png" height="300" width="500" class="d-block w-100" style="object-fit: contain">
					</div>
					<%
					}
					%>
				</div>
			</div>
			<table>
				<tr>
					<th>식당명</th>
					<td><%=r.getRestaurantname()%></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><%=r.getRestaurantaddr()%></td>
				</tr>
				<tr>
					<th>한줄평</th>
					<td><%=r.getOnelinereview()%></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${restaurant.tel }</td>
					<th>영업시간</th>
					<td>${restaurant.openinghours }</td>
				</tr>
				<tr>
					<th>주차가능여부</th>
					<td>${restaurant.parking }</td>
					<th>휴무</th>
					<td>${restaurant.closed }</td>
				</tr>
			</table>
		</div>
		<hr>
		<div>
			<div class="content">
				<%=r.getContent()%>
			</div>
			<div align="center">
				<jsp:include page="kakaomap_marker.jsp">
					<jsp:param value="<%=r.getPlaceLO()%>" name="PlaceLO" />
					<jsp:param value="<%=r.getPlaceLa()%>" name="PlaceLa" />
					<jsp:param value="<%=r.getRestaurantname()%>" name="Restaurantname" />
				</jsp:include>
			</div>
		</div>
		<div style="text-align: center;">
			<button type="button" class="btn btn-success" onclick="">목록</button>
			<%
			if (nickname.equals(WriterNn)) {
			%>
			<button type="button" class="btn btn-success" onclick="">수정</button>
			<button type="button" class="btn btn-success" onclick="deleteRestaurnat()">삭제</button>
			<%
			}
			%>
		</div>
				<!--댓글 리스트-->
		<div id="replyList" style="width: 820px; margin: auto auto">

			<ul style="list-style: none;">
				<%
				if (replylist.size() == 0) {//답글이 없는 경우. null이 아니라 size로 해줘야 함.
				%>

				<li>댓글이 없습니다. 댓글을 작성해주세요!</li>

				<%
				} else {
				for (int i = 0; i < replylist.size(); i++) {
					ReplyBoardVO vo = replylist.get(i);
				%>
				<li style="margin-bottom: 15px">
					<div class="container">
					
						<img alt="" src="./resource/images/default_profile.jpg" width="72px" height="76px" style = "object-fit: fill"> 
						
						<span><b><%=vo.getNickname()%></b></span>
					<span><span class="starrating">★</span><%=vo.getStarrating()%>/5</span> 
						<span style="color: gray; font-size: 12px;">(<%=vo.getRegdate()%>)</span>

						<!--세션 닉네임과 댓글 닉네임이 같을 경우 수정/삭제 가능  -->
						<%
						if (nickname.equals(vo.getNickname())) {
						%>
						<form action="" name="replymodi<%=vo.getSeq()%>" style="display: inline;">
							<span style="margin-left: 300px">
								<button type="button" id="modifyR_Btn" class="btn btn-success btn-sm modify">수정</button>
								<button type="button" style="display: none;" id="modifyRS_Btn"  class="btn btn-success btn-sm modify"onclick="replymodi(boardseq_r,seq_r,replaytext);">전송</button>
								<button type="button" style="display: none;" id="modifyRC_Btn" class="btn btn-success btn-sm modify">취소</button>
								<button type="button" id="modifyRD_Btn" class="btn btn-success btn-sm modify" onclick="delectR_Btn(boardseq_r,seq_r); return false;">삭제</button>
							</span>
							<%
							}
							%>
				
							<input id="boardseq_r" type="hidden" value="<%=vo.getBoardseq()%>"> <input id="seq_r" type="hidden" value="<%=vo.getSeq()%>">
							<textarea id="replaytext" class="form-control replyarea" rows="2" style="border: 0 solid black; background-color: white; resize: none; outline: none" cols="90" readonly="readonly" ><%=vo.getReply()%></textarea>
					</form>
						<hr>
					</div>
				</li>

				<%
				}
				}
				%>
			</ul>
		</div>
		<br>
		<br>
		<div>
			<jsp:include page="commentsRestaurant.jsp">
				<jsp:param value="<%=nickname%>" name="nickname" />
				<jsp:param value="<%=r.getSeq()%>" name="seq" />
			</jsp:include>
		</div>
	</div>
</body>
</html>