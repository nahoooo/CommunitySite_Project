<%@page import="com.company.board.vo.ReplyBoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.board.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
//사용자의 닉네임이 세션으로 저장되어있음.
String nickname = (String) session.getAttribute("nickname");


//1.Servlet이 전달한 데이터를 받는다.
String boardtype = request.getParameter("boardtype");
BoardVO board = (BoardVO) request.getAttribute("board");

//게시글 작성자의 닉네임.
String WriterNn = board.getNickname();

ArrayList<ReplyBoardVO> replylist = (ArrayList<ReplyBoardVO>) request.getAttribute("replylist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 읽기</title>
</head>
<body>
	<div class="container" style="margin: auto auto">
		<table class=".table-borderless" style="width: 820px; margin: auto auto">
			<tbody>
				<tr>
					<td>
						<div>
							<div class="d-flex justify-content-between">
								<div><%=board.getNickname()%></div>
								<div><%=board.getRegdate()%></div>
								<div>
									<span>댓글수 <%=board.getComment_cnt()%></span> <span>조회수<%=board.getCnt()%></span> <span>좋아요<%=board.getLike_cnt()%></span>
								</div>
							</div>
						</div>
						<div>
							<h2><%=board.getTitle()%></h2>
						</div>
						<div><%=board.getContent()%></div>
						<div style="text-align: center;">
							<button type="button" class="btn btn-success" onclick="location='GetBoardListPro?boardtype=<%=boardtype%>'">목록</button>
							<%
							if (nickname.equals(WriterNn)) {
							%>
							<button type="button" class="btn btn-success" onclick="location='UpdateBoard?boardtype=<%=boardtype%>&seq=<%=board.getSeq()%>'">수정</button>
							<button type="button" class="btn btn-success" onclick="deleteBoard();">삭제</button>
							<%
							}
							%>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<br>
		<br>
		<br>

		<!--댓글 리스트-->
		<div id="replyList" style="width: 820px; margin: auto auto">

			<ul style="list-style: none;">
				<%
				if (replylist.size() == 0) {//답글이 없는 경우. null이 아니라 size로 해줘야 함.
				%>

				<li>댓글이 없습니다. 댓글을 작성해주세요!</li>

				<%
				} else {
				for (int i = 0; i < replylist.size(); i++) {
					ReplyBoardVO vo = replylist.get(i);
				%>
				<li style="margin-bottom: 15px">
					<div class="container">

						<img alt="" src="./resource/images/default_profile.jpg" width="72px" height="76px" style = "object-fit: fill"> 
						<span><b><%=vo.getNickname()%></b></span><span style="color: gray; font-size: 12px;">(<%=vo.getRegdate()%>)
						</span>


						<!--세션 닉네임과 댓글 닉네임이 같을 경우 수정/삭제 가능  -->
						<%
						if (nickname.equals(vo.getNickname())) {
						%>
						<form action="" name="replymodi<%=vo.getSeq()%>" style="display: inline;">
							<span style="margin-left: 300px">
								<button type="button" id="modifyR_Btn" class="btn btn-success btn-sm">수정</button>
								<button type="button" style="display: none;" id="modifyRS_Btn" class="btn btn-success btn-sm" onclick="replymodi(boardtype_r,boardseq_r,seq_r,replaytext);">전송</button>
								<button type="button" style="display: none;" id="modifyRC_Btn" class="btn btn-success btn-sm">취소</button>
								<button type="button" id="modifyRD_Btn" class="btn btn-success btn-sm" onclick="delectR_Btn(boardtype_r,boardseq_r,seq_r); return false;">삭제</button>
							</span>
							<%
							}
							%>

							<input id="boardtype_r" type="hidden" value="<%=vo.getBoardtype()%>"> <input id="boardseq_r" type="hidden" value="<%=vo.getBoardseq()%>"> <input id="seq_r" type="hidden" value="<%=vo.getSeq()%>">
							<textarea id="replaytext" class="form-control replyarea" rows="2" style="border: 0 solid black; background-color: white; resize: none; outline: none" cols="90" readonly="readonly" ><%=vo.getReply()%></textarea>
						</form>
						<hr>
					</div>
				</li>

				<%
				}
				}
				%>
			</ul>
		</div>
		<br>
		<br>
		<!--댓글 작성은 include로 연결  -->
		<jsp:include page="comments.jsp">
			<jsp:param value="<%=nickname%>" name="nickname" />
			<jsp:param value="<%=board.getSeq()%>" name="seq" />
			<jsp:param value="<%=boardtype%>" name="seq" />
		</jsp:include>
	</div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script type="text/javascript">
		//게시글 삭제
		function deleteBoard() {
			if (confirm("게시글을 삭제하시겠습니까?")) {
				location.href = "DeleteBoardPro?boardtype=" +
	<%=boardtype%>
		+ "&seq=" +
	<%=board.getSeq()%>
		;
			} else {
				return false;
			}
		}

		//댓글 수정 버튼 이벤트
		const modifyR_Btn = document.querySelectorAll('#modifyR_Btn');

		modifyR_Btn.forEach(function(item) {
			item.addEventListener('click', function() { // 클릭 이벤트 발생시,
				$(this).css("display",'none')
				$(this).nextAll("textarea").attr("readonly", false).focus(); // 클릭 이벤트가 발생한 버튼에 제일 가까운 textarea 찾고, 

				$(this).nextAll("#modifyRS_Btn").css("display", '');
				$(this).nextAll("#modifyRC_Btn").css("display", '');
				$(this).nextAll("#modifyRD_Btn").css("display", 'none');
			});
		});

		//수정된 댓글 전송		
		function replymodi(boardtype_r,boardseq_r,seq_r,replaytext) {
			
			//값 확인
			console.log(boardtype_r.value);
			console.log(boardseq_r.value);
			console.log(seq_r.value);
			console.log(replaytext.value);

			$.ajax({
				type : "post", //통신타입 설정. get,post등의 방식 사용.
				url : "ReplyUpdateAjaxPro", //요청 url 자원의 고유 위치
				data : {
					seq : seq_r.value,
					boardtype : boardtype_r.value,
					boardseq : boardseq_r.value,
					replytext : replaytext.value
				},
				//서버에 요청할때 보낼 매개변수 설정. 보낼변수 이름 : 변수 값				
				async : true, //기본값은 false. 비동기 전송 여부
				success : function(result) { //요청한 페이지에서 보내온 값을 data란 변수로 받아온다.
					if (result == 1) {
						location.reload();
					} else {
						alert('댓글 수정 실패');
					}

				}, //요청응답에 성공했을 때 처리 할 구문.
				error : function() {
					alert('전송 실패')
				}//요청 실패시 나오는 구문.
			});
		}

		//댓글 수정 취소
		const modifyRC_Btn = document.querySelectorAll('#modifyRC_Btn');

		modifyRC_Btn.forEach(function(item) {
			item.addEventListener('click', function() { // 클릭 이벤트 발생시,
				$(this).nextAll("textarea").attr("readonly", true); // 클릭 이벤트가 발생한 버튼에 제일 가까운 textarea 찾고,  				
				$(this).nextAll("#modifyRS_Btn").css("display", '');
				location.reload();
			});
		});

		//댓글 삭제	
		function delectR_Btn(boardtype_r,boardseq_r,seq_r) {
			if(confirm("댓글을 삭제하시겠습니까?")){
				$.ajax({
					type : "post", //통신타입 설정. get,post등의 방식 사용.
					url : "ReplyDeleteAjaxPro", //요청 url 자원의 고유 위치
					data : {
						seq : seq_r.value,
						boardtype : boardtype_r.value,
						boardseq : boardseq_r.value
					},
					//서버에 요청할때 보낼 매개변수 설정. 보낼변수 이름 : 변수 값				
					async : true, //기본값은 false. 비동기 전송 여부
					success : function(result) { //요청한 페이지에서 보내온 값을 data란 변수로 받아온다.
						if (result == 1) {
							location.reload();
						} else {
							alert('댓글 삭제 실패');
						}

					}, //요청응답에 성공했을 때 처리 할 구문.
					error : function() {
						alert('전송 실패')
					}//요청 실패시 나오는 구문.
				});
			}
		}
	</script>
</body>
</html>
