<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String boardtype = request.getParameter("boardtype");
String nickname =(String)session.getAttribute("nickname");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<title>게시글 작성</title>
</head>
<body>
	<div class="container" style="text-align: center; height: 1200px ">
		<h1>글 작성</h1>
		<form action="AddBoardPro" method="post" name="boardAddForm"
			id="boardAddForm">
			<table class="table" style="width: 100%; margin: auto auto">
				<tr>
				<td><input type="hidden" name="nickname" value="<%=nickname%>"></td>
				<td><input type="hidden" name="boardtype" value="<%=boardtype%>"></td>				
				</tr>
				<tr>
					<td>제목</td>
					<td align="left"><input type="text" name="title"
						class="form-control" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td align="left"><textarea class="form-control" row="20"
							style="width: 100%;" name="content" id="content"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="button" class="btn btn-success" id="savebutton">새 글 등록</button>
						<a class="btn btn-success" href="javascript:history.back();">이전 페이지로 이동</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script type="text/javascript">
	var oEditors = [];
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
	
	$("#savebutton").click(function(){ 
		//if(confirm("저장하시겠습니까?")) { 
			// id가 smarteditor인 textarea에 에디터에서 대입 
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); 			
		// 이부분에 에디터 validation 검증 
		if(validation()) { 
			
			$("#boardAddForm").submit(); 
		} 				
		//} 		
	}); 	
		
		
		function validation(){ 
			var contents = $.trim(oEditors[0].getContents()); 
			if(contents === '<p>&bnsp;</p>' || contents === ''){ 
				// 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음. 
				alert("내용을 입력하세요."); 
				oEditors.getById['content'].exec('FOCUS'); 
				return false; } 
			return true; }

	

</script>
</html>

