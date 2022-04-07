<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String filePath = request.getParameter("filePath");
if (filePath == null) {
	filePath = "home";
}

String nickname =(String)session.getAttribute("nickname");
String userprofile =(String)session.getAttribute("userprofile");
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="resource/css/index.css" rel="stylesheet" type="text/css">
	
<meta charset="UTF-8">
<title>NaHo</title>
</head>
<body>
	<!--헤더-->
	<jsp:include page="header.jsp">
	<jsp:param value="<%=filePath%>" name="filePath"/>
	</jsp:include>
	
	<!--바디  -->
	<div style="display: flex ;margin: auto auto; width:75%">
		<!-- 사이드 바 -->
		<%if(!filePath.equals("home") && !filePath.equals("login") && !filePath.equals("join")){ %>
		<jsp:include page="sidebar.jsp"></jsp:include>
		<%}%>
		<!--본문 -->
		<jsp:include page='<%=filePath + ".jsp"%>'></jsp:include>
	</div>
	<!--푸터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</html>