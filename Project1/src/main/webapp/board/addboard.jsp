<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String boardno = request.getParameter("boardno");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/resource/se2/js/HuskyEZCreator.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<title>게시글 작성</title>
</head>
<body>
	<div class="container" style="text-align: center;">
		<h1><%=boardno%></h1>
		<form action="AddBoardPro" method="post" name="boardAddForm" id="boardAddForm">
			<table class="table" style="width: 780px; margin: auto auto">
				<tr>
					<td>제목</td>
					<td align="left">
						<input type="text" name="title" class="form-control" />
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td align="left">
						<textarea class="form-control" row="20" style="width: 100%;" name="content" id="content"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="button" class="btn btn-success" onclick="submitContents()">새 글 등록</button>
					</td>
				</tr>

			</table>
		</form>
	</div>

	<script type="text/javascript">
			var oEditors = [];
			nhn.husky.EZCreator.createInIFrame({
			    oAppRef: oEditors,
			    elPlaceHolder: "content",  //textarea ID 입력
			    sSkinURI: "../resource/se2/SmartEditor2Skin.html",  //smartEditor2Skin.html 경로 입력
			    fCreator: "createSEditor2",
			    htParams : { 
			    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
			        bUseToolbar : true, 
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseVerticalResizer : true, 
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseModeChanger : false 
			    }
			});

		
	</script>



</body>
</html>