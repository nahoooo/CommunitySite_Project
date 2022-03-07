<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinForm</title>
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
						<input class="form-control" type="text" name="id" id="id"> 
						<font id="checkId"></font>
						<input type="checkbox" name="idchk" value="unchk" disabled="disabled" id="idchk">
					</td>
				</tr>				
				<tr>
					<td>닉네임</td>
					<td>
						<input class="form-control" type="text" name="nickname">
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<input class="form-control" type="email" name="email">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input class="form-control" type="password" name="password" id="password">
					</td>
				</tr>
				<tr>
					<font id="checkpw"></font>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td>
						<input class="form-control" type="password" name="passwordchk">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button class="w-100 btn btn-lg btn-success" type="button" onclick="checkJoin();">회원가입</button>
					</td>
				</tr>
			</table>
		</form>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript">
			function checkJoin() {
				var form = document.joinForm;
				var pwreg = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,16}$/;
				var pw = form.password.value;

				if (form.id.value == "" || form.id.value == null) {
					alert("아이디를 입력해주세요");
					return false;
				}
				if (form.idchk.value == "unchk") {
					alert("아이디 중복을 확인을 해주세요");
					return false;
				}
				if (form.nickname.value == "" || form.nickname.value == null) {
					alert("닉네임을 입력해주세요");
					return false;
				}
				if (form.email.value == "" || form.email.value == null) {
					alert("이메일을 입력해주세요");
					return false;
				}
				if (form.password.value == "" || form.password.value == null) {
					alert("비밀번호를 입력하세요");
					return false;
				}
				if (!pwreg.test(pw)) {
					alert('영문자,숫자,특수문자를 조합한 8~16자리를 입력해주세요');
					return false;
				}
				if (form.password.value != form.passwordchk.value) {
					alert("입력하신 비밀번호와 같은 비밀번호를 입력하세요");
					return false;
				}

				form.submit();
			}

			 	$('#id').blur(function(){
					let userId = $('#id').val();
					
						$.ajax({
							url : "Idchk",
							type : "post",
							data : {userId: userId},
							dataType : 'json',
							success : function(result){
								if(result == 0){
									$("#checkId").html('이미 사용중인 아이디 입니다.');
									$("#checkId").attr('color','red');
									$("#idchk").val('unchk');
								}else{
									$("#checkId").html('사용할 수 있는 아이디입니다.');
									$("#checkId").attr('color','blue');
									$("#idchk").val('chked');
								}
							},
							error : function(){
								alert("서버요청실패");
							}
							
						})
						
				}) 
		</script>
	</div>
</body>
</html>