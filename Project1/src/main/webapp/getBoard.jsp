<%@page import="com.company.board.vo.ReplyBoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.board.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String nickname =(String)session.getAttribute("nickname");
String boardno =(String)session.getAttribute("boardno");

//1.Servlet이 전달한 데이터를 받는다.
BoardVO board = (BoardVO) request.getAttribute("board");
String boardNn = board.getNickname();

ArrayList<ReplyBoardVO> replylist =(ArrayList<ReplyBoardVO>) request.getAttribute("replylist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 읽기</title>
</head>
<body>
	<div class="container" style="margin: auto auto">
		<table class=".table-borderless" style="width: 780px; margin: auto auto">
			<tbody>
				<tr>
					<td>
						<div>
							<div class="d-flex justify-content-between">
								<div><%=board.getNickname()%></div>
								<div><%=board.getRegdate()%></div>
								<div>
									<span><%=board.getComment_cnt()%></span> <span><%=board.getCnt()%></span> <span><%=board.getLike_cnt()%></span>
								</div>
							</div>
						</div>
						<div>
							<h2><%=board.getTitle()%></h2>
						</div>
						<div><%=board.getContent()%></div>
						<div style="text-align: center;">
						<button type="button" class="btn btn-success">목록</button>
						<%if(nickname.equals(boardNn)){ %>
						<button type="button" class="btn btn-success">수정</button>
						<button type="button" class="btn btn-success">삭제</button>
						<%} %>
						</div>
					</td>
				</tr>				
			</tbody>
		</table>
		<%if(replylist.size()==0){//답글이 없는 경우. null이 아니라 size로 해줘야 함. %>
		
		<p>댓글 없습니다.<p>
		
		<%}else{
			
			for(int i =0;i<replylist.size();i++){
			ReplyBoardVO vo = replylist.get(i);	
			
		%>
		<table style="width:800px;line-height:2;">
		<tr>
		<td colspan="2"><b style="color:blue;"><%=vo.getNickname() %></b> <br> <span style="font-size:16px;"> <%=vo.getReply()%> </span> - &nbsp;&nbsp;<span style="color:gray;font-size:12px;"> <%=vo.getRegdate()%> </span></td>
		</tr>
		</table>
		<br>		
		<%} }%>
		<br><br> 
	 <jsp:include page="comments.jsp">
	 <jsp:param value="<%=nickname%>" name="nickname"/>
	 <jsp:param value="<%=board.getSeq()%>" name="seq"/>
	 <jsp:param value="<%=boardno%>" name="seq"/>
	 </jsp:include>  
	</div>
</body>
</html>
