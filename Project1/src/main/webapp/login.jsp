<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<title>loginForm</title>
</head>
<body>
	<div class="container" id="form-signin" style="margin-top: 120px; height: 700px" align="center">
		<main class="form-signin">
			<%String cookie = "";
		Cookie[] cookies = request.getCookies(); //쿠키생성
		if(cookies !=null&& cookies.length > 0)
		for (int i = 0; i < cookies.length; i++){
			if (cookies[i].getName().equals("userId")) { // 내가 원하는 쿠키명 찾아서 값 저장
				cookie = cookies[i].getValue();}}%>
			<form style="width: 350px;" name="loginForm" action="LoginPro">
				<img class="mb-4" src="./resource/images/restaurant.png" alt="" width="50" height="50">
				<div class="form-floating" style="margin-bottom: 10px">
					<input type="text" class="form-control" name="Id" id="floatingInput" placeholder="아이디를 입력해주세요"  value="<%=cookie%>" > <label for="floatingInput">아이디</label>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" id="floatingPassword" placeholder="비밀번호를 입력해주세요" > <label for="floatingPassword">비밀번호</label>
				</div>
				<div class="checkbox mb-3" style="margin-top: 10px">
					<label><input type="checkbox" id="saveid" name="saveid" value="chk">아이디 저장하기</label>&emsp; <span class="pull-right"><a href="">아이디/비밀번호 찾기</a></span>
				</div>
				<font id="checkLogin"></font><br>
				<br>
				<button class="w-100 btn btn-lg btn-success" type="button" onclick="loginchk(); return false;">로그인</button>
				&emsp;
				<button class="w-100 btn btn-lg btn-success" type="button" onclick="location.href ='index.jsp?filePath=join'">회원가입</button>
				<p class="mt-5 mb-3 text-muted">© Nahohyeon Company, Inc</p>
			</form>
		</main>
	</div>
</body>
<script type="text/javascript">

function loginchk(){	
	let Id = $('#floatingInput').val();
	let Password = $('#floatingPassword').val();	

	let saveid = $('input[name="saveid"]').val();
	
	console.log(saveid);
			
	if(Id==""){
		$('#checkLogin').html('아이디를 입력해주세요.');
		$('#checkLogin').attr('color', 'red');
		$('#floatingInput').focus();
		return false;	
	}else if(Password==""){
		$('#checkLogin').html('');
		$('#checkLogin').html('비밀번호를 입력해주세요.');
		$('#checkLogin').attr('color', 'red');
		$('#floatingPassword').focus();
		return false;
	}else{
		 $.ajax({
				url: "LoginChk",
				type: "post",
				data: {
					"Id" : Id,
					"Password" : Password,	
					"saveid" : saveid
				},
				dataType: 'json', //text,html,xml,json
				success: function(result) {
					if (result == 0) {
						$("#checkLogin").html('아이디 또는 비밀번호를 잘못 입력했습니다.입력하신 내용을 다시 확인해주세요.');
						$("#checkLogin").attr('color', 'red');
						$("#floatingPassword").focus();	
						return false;
					} else if(result == 1) {						
						 /* location.href="http://localhost:8081/Project1/LoginPro?Id="+Id+"saveid="+saveid; */	
						document.loginForm.submit();		
					}
				},
				error: function() {
					alert("로그인 실패");
				}
			}) 
	}
	
	
	
}

</script>
</html>