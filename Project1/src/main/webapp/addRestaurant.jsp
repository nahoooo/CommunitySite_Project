<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nickname =(String)session.getAttribute("nickname");

if (nickname == null) {
	response.sendRedirect("index.jsp?filePath=login");
	return;
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../smarteditor2/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<title>게시글 작성</title>
</head>
<body>
	<div class="container" style="text-align: center;">
		<h1>맛집을 추천해 주세요!</h1>
		<form action="AddRestaurantPro" method="post" name="AddRestaurantForm"
			id="AddRestaurantForm">
			<table class="table" style="width: 900px; margin: auto auto">
				<tr>
				<td><input type="hidden" name="nickname" value="<%=nickname%>"></td>						
				</tr>
				<tr>
					<th>제목</th>
					<td align="left" colspan="3"><input type="text" name="title"
						class="form-control" /></td>
				</tr>
				<tr>
					<th>상호명</th>
					<td align="left" colspan="3" ><input type="text" name="restaurantname" class="form-control"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td align="left" colspan="3"><input type="text" name="restaurantaddr" placeholder="지도검색으로 정확히 입력해주세요~!" class="form-control"></td>
				</tr>
				<tr>
					<th>한줄평</th>
					<td align="left" colspan="3"><input type="text" name="onelinereview" class="form-control"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="tel" class="form-control"></td>
					<th>영업시간</th>
					<td><input type="text" name="openinghours" class="form-control"></td>
				</tr>
				<tr>
					<th>주차가능여부</th>
					<td><input type="text" name="parking" class="form-control"></td>
					<th>휴무</th>
					<td><input type="text" name="closed" class="form-control"></td>
				</tr>
				<tr>
					<th colspan="1" style="vertical-align: middle;">지도<br>
					<span>*식당 마커클릭!</span>
					</th>
					<td colspan="4">
						<jsp:include page="kakaomap.jsp"></jsp:include>												
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<!--식당 위치 위도 경도 추츨값 저장.  -->
						<input type="hidden" id="placeLa" name="placeLa" value="">
						<input type="hidden" id="placeLo" name="placeLo" value="">
						<!--지도에서 선택한 식당의 이름과 위도경도 확인 출력  -->	
						<p id="result" ></p>
					</td>
				</tr>
				<tr>
					<th colspan="4">내용</th>					
				</tr>
				<tr>
					<td colspan="4">
						<div style="text-align: right">
							<textarea style="width: 100%" class="form-control" row="20" name="content" id="content"></textarea>							
						</div>
					</td>
				</tr>				
				<tr>
					<td colspan="4" align="center" >
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
			sSkinURI : "../smarteditor2/SmartEditor2Skin.html",
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
		if(validation()) { $("#AddRestaurantForm").submit(); 
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