<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nickname =(String)session.getAttribute("nickname");    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
<div class="container" style="width: 920px; height:800px; text-align: center" >
<h1>영화게시판</h1>
<table class="table table-hover">
  <thead style="text-align: center">
    <tr>
      <th scope="col"width="50">글번호</th>
      <th scope="col" width="250">제목</th>
      <th scope="col" width="100">작성자</th>
      <th scope="col"width="120">작성일</th>
      <th scope="col" width="50">조회</th>
      <th scope="col" width="70">좋아요</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      
    </tr>   
  </tbody>
</table>
<%if(nickname!=null){ %>
<a>글쓰기</a>
<%} %>

<div class="container">
		<!-- 검색 시작 -->
		<form method="get" action="SearchPro">												
					<select name="searchCondition">
					<option value="title">제목
					<option value="content">내용
					<option value="nickname">작성자
					</select>
					<input type="text" name="searchKeyword"/>
					<input type="submit" value="검색"/>					
		</form>
		<!-- 검색 종료 -->
</div>		
</div>
</body>
</html>