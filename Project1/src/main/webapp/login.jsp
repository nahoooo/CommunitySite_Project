<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
 <body >
	<div class="container" id="form-signin" style=" margin-top: 120px;  height: 700px" align="center">
		<main class="form-signin">
			<form style="width: 350px;"> 
				<img class="mb-4" src="./resource/images/logo.png" alt="" width="60" height="100">				
				<div class="form-floating" style="margin-bottom: 10px">
					<input type="text" class="form-control" id="floatingInput" placeholder="아이디를 입력해주세요"> <label for="floatingInput">아이디</label>
				</div>			
				<div class="form-floating">
					<input type="password" class="form-control" id="floatingPassword" placeholder="비밀번호를 입력해주세요"> <label for="floatingPassword">비밀번호</label>
				</div>
				<div class="checkbox mb-3" style="margin-top: 10px">
					<label><input type="checkbox" value="remember-me">아이디 저장하기</label>&emsp;
				<span class="pull-right"><a href="">아이디/비밀번호 찾기</a></span>
				</div>
				<button class="w-100 btn btn-lg btn-success" type="button">로그인</button>&emsp;
				<button class="w-100 btn btn-lg btn-success" type="button" onclick="location.href ='index.jsp?filePath=join'">회원가입</button>
				<p class="mt-5 mb-3 text-muted">©  Nahohyeon Company, Inc</p>
			</form>
		</main>
	</div> 	
</body>
</html>