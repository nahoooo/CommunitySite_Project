<%@page import="com.company.board.vo.RestaurantVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.board.vo.BoardVO"%>
<%@page import="com.company.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String sessionID = (String) session.getAttribute("sessionID");
String nickname = (String) session.getAttribute("nickname");
UserVO user = (UserVO) request.getAttribute("user");
ArrayList<BoardVO> boardList = (ArrayList<BoardVO>) request.getAttribute("boardList");
ArrayList<RestaurantVO> RestaurantList = (ArrayList<RestaurantVO>) request.getAttribute("RestaurantList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">

		<div id="profileNav" align="center" style="margin-left: -32px">
			<h1 align="center">내정보</h1>
			<a onclick="profile();" style="cursor: pointer;">프로필 수정</a>
			<a onclick="activity();" style="cursor: pointer;">내 활동</a>
		</div>
		<br>
		<br>
		<!--프로필 사진, 정보 변경 div  -->
		<div id="userProfileUpdate">
			<div id="userProfilePhto" class="d-flex justify-content-center">
				<form action="UserProfilePhto" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<img id="img__wrap" src="${sessionScope.userProfile }" width="280px" height="280" style="border-radius: 140px" />
					</div>
					<div class="form-group bg-light">
						<input type="file" name="userProfile" id="img__preview" />
					</div>
					<div class="form-group">
						<button class="btn btn-success w-100">프로필사진 변경</button>
					</div>
					<input type="hidden" name="nickname" value="${sessionScope.nickname }" />
				</form>
			</div>
			<br>
			<hr>
			<br>
			<div id="userInfo" align="center">
				<form action="UpdateUserProfile" method="post">
					NICKNAME : <input type="text" name="nickname" value="<%=user.getNickname()%>"> <br> EMAIL : <input type="text" name="email" value="<%=user.getEmail()%>">
					<div class="form-group">
						<button class="btn btn-success" style="width: 300px">정보 변경</button>
					</div>
				</form>
			</div>
		</div>
		<!-- 유저 활동 div  -->
		<div id="useractivity" style="display: none;">
			<div align="center">
				<div id="board">
					<h3>일반게시판 활동</h3>
					<table class="table">
						<thead>
							<tr>
								<th scope="col">제목</th>
								<th scope="col">게시판</th>
								<th scope="col">조회수</th>
								<th scope="col">댓글수</th>
								<th scope="col">작성일</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
					<%
					for (int i = 0; i < boardList.size(); i++) {
						BoardVO board = boardList.get(i);
					%>
							<tr>
								<th scope="row"><a href="GetBoardPro?seq=<%=board.getSeq()%>&boardtype=<%=board.getBoardtype()%>"><%=board.getTitle()%></a> </th>
								<td><%=board.getBoardtype() %></td>
								<td><%=board.getCnt() %></td>
								<td><%=board.getComment_cnt() %></td>
								<td><%=board.getRegdate() %></td>
								<td><button onclick="deleteBoard(<%=board.getSeq()%>,'<%=board.getBoardtype()%>')">삭제</button></td>
							</tr>																
					<%}%>
						</tbody>
					</table>	
				</div>
				<div id="restaurant">
					<h3>내 맛집 추천</h3>
					<table class="table">
						<thead>
							<tr>
								<th scope="col">제목</th>																
								<th scope="col">한줄평</th>																
								<th scope="col">조회수</th>
								<th scope="col">댓글수</th>
								<th scope="col">작성일</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
					<%
					for (int i = 0; i < RestaurantList.size(); i++) {
						RestaurantVO r = RestaurantList.get(i);
					%>
							<tr>
								<th scope="row"><a href="GetRestaurantPro?seq=<%=r.getSeq()%>"><%=r.getTitle()%></a></th>
								<td><%=r.getOnelinereview()%></td>
								<td><%=r.getCnt() %></td>
								<td><%=r.getComment_cnt() %></td>
								<td><%=r.getRegdate() %></td>
								<td><button onclick="deleteRestaurnat(<%=r.getSeq()%>);">삭제</button></td>
							</tr>																
					<%}%>
						</tbody>
					</table>	
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//프로필 정보변경, 내 활동 display속성 변경.
		function activity() {
			$("#useractivity").css('display', '');
			$("#userProfileUpdate").css('display', 'none');
		}

		function profile() {
			$("#userProfileUpdate").css('display', '');
			$("#useractivity").css('display', 'none');
		}

		//프로필 사진 이미지 미리보기
		$("#img__preview").on("change", function(e) {
			var f = e.target.files[0];

			if (!f.type.match("image*")) {
				alert("이미지만 첨부할 수 있습니다..");
				$("#img__preview").val('');
				return;
			}

			// f.size = 1024*1024*2

			if (f.size > 1024 * 1024 * 2) {
				alert("2mb까지의 사진만 업데이트 할 수 있습니다.");
				$("#img__preview").val('');
				return;
			}

			var reader = new FileReader();

			reader.onload = function(e) {
				$("#img__wrap").attr("src", e.target.result);
			}
			reader.readAsDataURL(f); //비동기적 진행(파일 읽기)

		});
		
		
		//게시글 삭제
		function deleteBoard(seq, boardtype) {
			console.log(seq)
			console.log(boardtype)
			if (confirm("게시글을 삭제하시겠습니까?")) {
				$.ajax({
					type : "post", //통신타입 설정. get,post등의 방식 사용.
					url : "DeleteBoardPro", //요청 url 자원의 고유 위치
					data : {seq : seq,boardtype : boardtype},							
					//서버에 요청할때 보낼 매개변수 설정. 보낼변수 이름 : 변수 값				
					async : true, //기본값은 false. 비동기 전송 여부
					success : function(result) { //요청한 페이지에서 보내온 값을 data란 변수로 받아온다.
						if(result==1){			
							location.reload();
						}else{
							alert('게시글 삭제 실패');
						}						
					}, //요청응답에 성공했을 때 처리 할 구문.
					error : function() {
						alert('전송 실패')
					}//요청 실패시 나오는 구문.
				});				
			} else {
				return false;
			}
		}
		//맛집추천 삭제
		function deleteRestaurnat(seq) {
			if (confirm("게시글을 삭제하시겠습니까?")) {
				$.ajax({
					type : "post", //통신타입 설정. get,post등의 방식 사용.
					url : "DeleteRestaurantPro", //요청 url 자원의 고유 위치
					data : {seq : seq},							
					//서버에 요청할때 보낼 매개변수 설정. 보낼변수 이름 : 변수 값				
					async : true, //기본값은 false. 비동기 전송 여부
					success : function(result) { //요청한 페이지에서 보내온 값을 data란 변수로 받아온다.
						if(result==1){								
							location.reload();
						}else{
							alert('게시글 삭제 실패');
						}						
					}, //요청응답에 성공했을 때 처리 할 구문.
					error : function() {
						alert('전송 실패')
					}//요청 실패시 나오는 구문.
				});				
			} else {
				return false;
			}
		}
		
	</script>
</body>
</html>