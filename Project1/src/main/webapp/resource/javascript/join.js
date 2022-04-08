//유효성 검사를 통과할때마다 각 항목 값이 true로 변경.
//마지막 회원가입 버튼 클릭시 한번에 검사하기 위함.
let passid = null;
let passnickname = null;
let passemail = null;
let passpw = null;
let passpwch = null;



//ajax 로 아이디 중복 검색.			
$('#id').blur(function() {
	let userId = $('#id').val();
	var idreg = /^[a-z0-9]{4,12}$/;
//먼저 아이디 정규식 유효성 검사. 통과하면 중복검사.
	if (!idreg.test(userId)) {
		$("#checkId").html('영,숫자를 포함한 4~12자리로 입력해주세요');
		$("#checkId").attr('color', 'red');
		$("#id").focus();
	} else {
		$.ajax({
			url: "Idchk",
			type: "post",
			data: {
				userId: userId
			},
			dataType: 'json', //text,html,xml,json
			success: function(result) {
				if (result == 0) {
					$("#checkId").html('이미 사용중인 아이디 입니다.');
					$("#checkId").attr('color', 'red');
					$("#id").focus();					

				} else {
					$("#checkId").html('사용할 수 있는 아이디입니다.');
					$("#checkId").attr('color', '#198754');					
					passid = true;
				}
			},
			error: function() {
				alert("서버요청실패");
			}
		})
	}
})




//나머지 항목 정규식 유효성검사(제이쿼리로 작성.)
//1.닉네임
$("#nickname").blur(function() {
	let nicknamereg = /^[가-힣a-zA-Z]+$/;
	let nickname = $('#nickname').val();
	console.log(nickname);
	if (nickname == "") {
		$('#checknickname').text('닉네임을 입력해주세요');
		$('#checknickname').css('color', 'red');	
	} else {
		if (!nicknamereg.test(nickname)) {
			$('#checknickname').text('한글,영문으로만 입력해주세요');
			$('#checknickname').css('color', 'red');
			$("#nickname").focus();
		} else {
			$.ajax({
				url: "NicknameChk",
				type: "post",
				data: {
					userNickname: nickname
				},
				dataType: 'json', //text,html,xml,json
				success: function(result) {
					if (result == 0) {
						$("#checknickname").html('이미 사용중인 닉네임 입니다.');
						$("#checknickname").attr('color', 'red');
						$("#nickname").focus();
						
					} else {
						$("#checknickname").html('사용할 수 있는 닉네임입니다.');
						$("#checknickname").attr('color', '#198754');
						passnickname = true;
					}
				},
				error: function() {
					alert("서버요청실패");
				}
			})
		}
	}
});

//2.이메일
$("#email").blur(function() {
	let emailreg = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	let email = $('#email').val();
	console.log(email);
	if (email == "") {
		$('#checkemail').text('이메일을 입력해주세요');
		$('#checkemail').css('color', 'red');
		$("#email").focus();
	} else {
		if (!emailreg.test(email)) {
			$("#checkemail").text('이메일형식을 맞춰주세요');
			$('#checkemail').css('color', 'red');
			$("#email").focus();
		} else {
			console.log(nickname);
			$("#checkemail").text('');
			passemail = true;
		}

	}
});
//3.비밀번호
$("#password").blur(function() {
	let pwreg = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,16}$/;
	let password = $('#password').val();
	console.log(password);
	if (!pwreg.test(password)) {
		$('#checkpw').text('숫자,특수문자를 포함, 8~16글자로 입력해주세요');
		$('#checkpw').css('color', 'red');
	} else {
		console.log(password);
		$("#checkpw").text('');
		passpw = true;
	}
});
//4.비밀번호 체크
$("#passwordchk").blur(function() {
	let password = $('#password').val();
	let passwordchk = $('#passwordchk').val();
	console.log(passwordchk);
	if (password != passwordchk) {
		$('#checkpw2').text('같은 비밀번호를 입력해주세요');
		$('#checkpw2').css('color', 'red');
	} else {
		$("#checkpw2").text('');
		passpwck = true;
	}
});

function checkJoin() {
	if (passid) {
		if (passnickname) {
			if (passemail) {
				if (passpw) {
					if (passpwck) {
						document.joinForm.submit();		
					}
				}
			}
		}
	}

}

