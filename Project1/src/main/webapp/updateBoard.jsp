<%@page import="com.company.board.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String boardtype = (String)request.getAttribute("boardtype");
int seq =(int) request.getAttribute("seq");

String nickname =(String)session.getAttribute("nickname");

BoardVO board = (BoardVO) request.getAttribute("board");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<title>게시글 수정</title>
</head>
<body>
	<div class="container" style="text-align: center;">	
		<h1>게시글 수정</h1>
		<form action="UpdateBoardPro" method="post" name="boardUpdateForm"
			id="boardUpdateForm">
			<table class="table" style="width: 820px; margin: auto auto">
				<tr>
				<td><input type="hidden"  name="nickname" value="<%=nickname%>"></td>
				<td><input type="hidden"  id="boardtype" name="boardtype" value="<%=boardtype%>"></td>				
				<td><input  type="hidden" name="seq" value="<%=seq%>"></td>				
				</tr>
				<tr>
					<td>제목</td>
					<td align="left"><input type="text" id="title" name="title" class="form-control" value="<%=board.getTitle() %>"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td align="left"><textarea class="form-control" row="20"
							style="width: 100%;" name="content" id="content"><%=board.getContent() %></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="button" class="btn btn-success" id="updatebutton">수정하기</button>
					</td>
				</tr>

			</table>
		</form>
	</div>
</body>
<script type="text/javascript">
	var oEditors = [];
	var title = $("#title").val();
	var content = $("#content").val();
	var boardtype = $("#boardtype").val();
	$(function() {
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "content",
			//SmartEditor2Skin.html 파일이 존재하는 경로
			sSkinURI : "./smarteditor2/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,
				fOnBeforeUnload : function() {
				}
			},
			fCreator : "createSEditor2"
		});
		
	})
	
	$("#updatebutton").click(function(){ 
		
		console.log(title);
		console.log(content);
		console.log(boardtype);
		
			// id가 smarteditor인 textarea에 에디터에서 대입 
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); 		
		 	$("#boardUpdateForm").submit(); 		 
	}); 
	

	

</script>
</html>

