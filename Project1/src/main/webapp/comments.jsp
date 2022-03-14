<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String nickname = request.getParameter("nickname");
String seq = request.getParameter("seq");
String boardno = request.getParameter("boardno");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<form id="commentForm" name="commentForm">
			<!--댓글 작성.  -->
			<div align="left" style="width: 800px">
				<span><strong>Comments</strong></span><span id="cCnt"></span>
			</div>
			<table class="table" style="width: 800px">
				<tr>
					<td>
						<input type="hidden" value="<%=nickname%>" name="nickname" id="nickname"> <input type="hidden" value="<%=seq%>" name="seq" id="seq">
						<input type="hidden" value="<%=boardno%>" name="boardno" id="boardno">
						<textarea class="form-control" rows="3" cols="30" id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
						<br>
						<div align="right">
							<button id=cmt_btn class="btn btn-success" onclick="reply(); return false;">댓글달기</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
	//ajax방식
		var nickname = $("#nickname").val();
	
		var seq = $("#seq").val();
		
		var boardno = $("#boardno").val();
		
		
		
// 		var c = document.commentForm.comment;
	
	
						
	function reply() {		
		 var comment = $("#comment").val(); 
		if (comment == 0 || comment == null || comment == "") {
			console.log(nickname+"댓글내용");
			console.log(seq+"댓글내용");
			console.log(boardno+"댓글내용");
			console.log(comment+"댓글내용");
			alert("댓글을 입력하세요");
		} else {
			$.ajax({
				type : "post", //통신타입 설정. get,post등의 방식 사용.
				url : "http://localhost:8081/Project1/ReplyAjaxPro", //요청 url 자원의 고유 위치
				data : {nickname : nickname,seq : seq,boardno : boardno,comment : c},							
				//서버에 요청할때 보낼 매개변수 설정. 보낼변수 이름 : 변수 값				
				async : true, //기본값은 false. 비동기 전송 여부
				success : function(data) { //요청한 페이지에서 보내온 값을 data란 변수로 받아온다.
					if(result==1){
						alert('댓글 입력 완료');
					}else{
						alert('댓글 입력 실패');
					}

				}, //요청응답에 성공했을 때 처리 할 구문.
				error : function() {
					alert('전송 실패')
				}//요청 실패시 나오는 구문.
			});
		}
	}
	
	 /*  function getComment(seq) {
	        $.ajax({
	            url:"http://localhost:8081/Board/ReplyAjaxGetPro",
	            data:{
	            	seq:seq,	               
	            },
	        	dataType:'json',
				async : true, //기본값은 false. 비동기 전송 여부
	            success:function(data) {
	                console.log("comment를 정상적으로 조회하였습니다.");	            	                                    
	            },
	            error : function() {
					alert('전송 실패')
				}//요청 실패시 나오는 구문.
	        });
	    } */
	
</script>

</html>