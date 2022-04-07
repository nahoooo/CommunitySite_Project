<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinForm</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
<body>
	<div class="container" style="height: 580px; margin-top: 100px" align="center">
		<h1>회원가입</h1>
		<hr>
		<form action="JoinPro" method="post" name="joinForm">
			<table class="table" style="width: 500px">
				<tr>
					<td>아이디</td>
					<td>
						<input class="form-control" type="text" name="id" id="id"> <font id="checkId"></font> <input type="checkbox" name="idchk" value="unchk" disabled="disabled" id="idchk">
					</td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td>
						<input class="form-control" type="text" name="nickname" id="nickname"> <font id="checknickname"></font>
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<input class="form-control" type="email" name="email" id="email"> <font id="checkemail"></font>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input class="form-control" type="password" name="password" id="password"> <font id="checkpw"></font>
					</td>
				</tr>

				<tr>
					<td>비밀번호 확인</td>
					<td>
						<input class="form-control" type="password" name="passwordchk" id="passwordchk"> <font id="checkpw2"></font>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="hidden" name="userprofile_default" value="/resource/images/default_profile.jpg">
						<button class="w-100 btn btn-lg btn-success" type="button" onclick="checkJoin();">회원가입</button>
					</td>
				</tr>
			</table>
		</form>				
	</div>
	<script type="text/javascript" src="resource/javascript/join.js"></script> 
</body>
</html>