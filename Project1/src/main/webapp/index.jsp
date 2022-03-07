<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String filePath = request.getParameter("filePath");
if (filePath == null) {
	filePath = "home";
}
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="resource/css/index.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<body>	
	<jsp:include page="header.jsp">
	<jsp:param value="<%=filePath%>" name="filePath"/>
	</jsp:include>
	<jsp:include page='<%=filePath + ".jsp"%>'/>
	<jsp:include page="footer.jsp"></jsp:include>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</html>