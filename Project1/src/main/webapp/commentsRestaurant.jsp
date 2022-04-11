<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String nickname = request.getParameter("nickname");
String seq = request.getParameter("seq");

String userProfile = (String) session.getAttribute("userProfile");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.star-rating {
  display: flex;
  flex-direction: row-reverse;
  font-size: 1.8rem;
  line-height: 2.0rem;
  justify-content: flex-end;
  padding: 0 0.2em;
  text-align: left;
}
 
.star-rating input {
  display: none;
} 
 
.star-rating label {
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 1.8px;
  -webkit-text-stroke-color: #2b2a29;
  cursor: pointer;
}
 
.star-rating :checked ~ label {
  -webkit-text-fill-color: gold;
}
 
.star-rating label:hover,
.star-rating label:hover ~ label {
  -webkit-text-fill-color: #fff58c;
}

</style>
</head>
<body>
	<div align="center">
		<form id="commentForm" name="commentForm">
			<!--댓글 작성.  -->
			<div style="display: flex; width: 800px;align-items: flex-end;">
			
				 <strong style="font-size: 1.2em">Comments</strong><span id="cCnt"></span>
						
			<div class="star-rating">
				<input type="radio" id="5-stars" name="rating" value="5"/>
				<label for="5-stars" class="star pr-4">★</label>
				<input type="radio" id="4-stars" name="rating" value="4" />
				<label for="4-stars" class="star">★</label>
				<input type="radio" id="3-stars" name="rating" value="3" />
				<label for="3-stars" class="star">★</label>
				<input type="radio" id="2-stars" name="rating" value="2" />
				<label for="2-stars" class="star">★</label>
				<input type="radio" id="1-star" name="rating" value="1" />
				<label for="1-star" class="star">★</label>
			</div>	
			</div>		
			<table class="table" style="width: 800px">
				<tr>
				<td width="73px">
				
					  <img  src="${sessionScope.userProfile}" width="70px" height="70px" style = "object-fit: fill; "> 
						<input type="hidden" value="${sessionScope.userProfile}" id="userProfilephto">
				</td>
					<td>
						<input type="hidden" value="<%=nickname%>" name="nickname" id="nickname"> <input type="hidden" value="<%=seq%>" name="seq" id="seq">
						<input type="hidden" value="${sessionScope.sessionID}" name="id" id="id">						
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
	
		
				
// 		var c = document.commentForm.comment;
									
	function reply() {		
		var comment = $("#comment").val(); 		 
		var ratingVar = $('input[name=rating]:checked').val();
		var userProfilephto = $("#userProfilephto").val();	
		var id = $("#id").val();		
		console.log(userProfilephto)
		
 		if (comment == 0 || comment == null || comment == "") {			
 			alert("댓글을 입력하세요");
 		} else {
 			$.ajax({
 				type : "post", //통신타입 설정. get,post등의 방식 사용.
 				url : "R_ReplyAjaxPro", //요청 url 자원의 고유 위치
 				data : {nickname : nickname,seq : seq,comment : comment,starrating : ratingVar,userProfilephto : userProfilephto,id : id},							
 				//서버에 요청할때 보낼 매개변수 설정. 보낼변수 이름 : 변수 값				
 				async : true, //기본값은 false. 비동기 전송 여부
 				success : function(result) { //요청한 페이지에서 보내온 값을 data란 변수로 받아온다.
 					if(result==1){								
 						location.reload();
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
</script>
</html>