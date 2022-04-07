<%@page import="com.company.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	String nickname =(String)session.getAttribute("nickname");
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
<h1 align="center">내정보</h1>
	<div id="userProfilePhto" class = "d-flex justify-content-center">	
	<form action="UserProfilePhto" method="post" enctype="multipart/form-data">
		<div id="profileNav" align="center">
			<a>프로필 수정</a> <a>게시글</a>
		</div>
		<div class="form-group" >
			<img id="img__wrap"  src="${sessionScope.userProfile }" width="300px" height="300px" style="border-radius: 150px" />
		</div>
		<div class="form-group bg-light">
			<input type="file" name="userProfile" id="img__preview"/> <!-- 변수명은 보통 __로 구분 -->
		</div>
		<div class="form-group">
			<button class="btn btn-success w-100">프로필사진 변경</button>
		</div>
		<input type="hidden" name="nickname" value="${sessionScope.nickname }"/>
	</form>
	</div><br><hr><br>
	<div id="userInfo" align="center">
	<form action="UpdateUserProfile" method="post">		
	 NICKNAME : <input type="text" name="nickname" value="<%=user.getNickname() %>"> <br>
		EMAIL : <input type="text" name="email" value="<%=user.getEmail() %>"> 	
		<div class="form-group">
			<button class="btn btn-success" style="width: 300px">정보 변경</button>
		</div>	
	</form>
	</div>
	
	
	
</div>








<script type="text/javascript">
$("#img__preview").on("change", function(e){
	var f=e.target.files[0];

	if(!f.type.match("image*")){
		alert("이미지만 첨부할 수 있습니다..");
		$("#img__preview").val('');
		return;
	}

	// f.size = 1024*1024*2

	if(f.size>1024*1024*2){
		alert("2mb까지의 사진만 업데이트 할 수 있습니다.");
		$("#img__preview").val('');
		return;
	}

	var reader=new FileReader();



	reader.onload=function(e){
		$("#img__wrap").attr("src",e.target.result);
	}
	reader.readAsDataURL(f); //비동기적 진행(파일 읽기)



});
</script>
</body>
</html>