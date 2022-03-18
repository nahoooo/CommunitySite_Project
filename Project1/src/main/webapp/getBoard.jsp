<%@page import="com.company.board.vo.ReplyBoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.board.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String nickname = (String) session.getAttribute("nickname");
/* String boardno = (String) session.getAttribute("boardno"); */

//1.Servlet이 전달한 데이터를 받는다.
int boardno = Integer.parseInt(request.getParameter("boardno"));
BoardVO board = (BoardVO) request.getAttribute("board");

//게시글 작성자의 닉네임.
String boardNn = board.getNickname();

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
							<button type="button" class="btn btn-success">목록</button>
							<%
							if (nickname.equals(boardNn)) {
							%>
							<button type="button" class="btn btn-success" onclick="location='UpdateBoard?boardno=<%=boardno%>&seq=<%=board.getSeq()%>'">수정</button>
							<button type="button" class="btn btn-success" onclick="deleteBoard();">삭제</button>
							<%
							}
							%>
						</div>
					</td>
				</tr>
			</tbody>
		</table><br><br><br>

		<!--댓글 리스트  -->
		<table  style="width: 820px; margin: auto auto">
		<%
		if (replylist.size() == 0) {//답글이 없는 경우. null이 아니라 size로 해줘야 함.
		%>
		<tr>
			<td>댓글이 없습니다. 댓글을 작성해주세요!</td>
		</tr>
		<%
		} else {

		for (int i = 0; i < replylist.size(); i++) {
			ReplyBoardVO vo = replylist.get(i);
		%>
		<tr>
			<td colspan="2">
				<b style="color: blue;"><%=vo.getNickname()%></b> <br> <span style="font-size: 16px;"> <%=vo.getReply()%>
				</span> - &nbsp;&nbsp;<span style="color: gray; font-size: 12px;"> <%=vo.getRegdate()%>
				</span>
			</td>
		</tr>
		<%
		}
		}
		%>
		</table>
		<br><br>
		<jsp:include page="comments.jsp">
			<jsp:param value="<%=nickname%>" name="nickname" />
			<jsp:param value="<%=board.getSeq()%>" name="seq" />
			<jsp:param value="<%=boardno%>" name="seq" />
		</jsp:include>
	</div>
	
	<script type="text/javascript">
	
	function deleteBoard() {
		if(confirm("게시글을 삭제하시겠습니까?")){
			location.href="DeleteBoardPro?boardno="+<%=boardno%>+"&seq="+<%=board.getSeq()%>;
		}else{
			return false;
		}
	}
	
	</script>
</body>
</html>
