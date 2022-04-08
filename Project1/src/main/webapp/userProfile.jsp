<%@page import="com.company.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String nickname = (String) session.getAttribute("nickname");
UserVO user = (UserVO) request.getAttribute("user");
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
			<a onclick="profile();" style="cursor:pointer;">프로필 수정</a>
			<a onclick="activity();" style="cursor:pointer;">내 활동</a>
		</div><br><br>
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
			<h3>나오나요~</h3>
			</div>
		</div>

	</div>

	<script type="text/javascript">
	//프로필 정보변경, 내 활동 display속성 변경.
	function activity() {
		$("#useractivity").css('display','');
		$("#userProfileUpdate").css('display','none');
	}
	
	function profile() {
		$("#userProfileUpdate").css('display','');
		$("#useractivity").css('display','none');		
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
		
		
		
		
	</script>
</body>
</html>