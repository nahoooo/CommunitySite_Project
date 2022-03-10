<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String nickname =(String)session.getAttribute("nickname");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
</head>
<body>
<div class="container">
  <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
    <p class="col-md-4 mb-0 text-muted">© Nahohyeon Company, Inc</p>
  <a href="index.jsp" class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
       <img src="./resource/images/logo.png" alt="" width="70" height="120">
    </a>

    <ul class="nav col-md-4 justify-content-end">
     <li class="nav-item"><a  class="nav-link px-2 text-muted"><%=nickname %></a></li>
      <li class="nav-item"><a href="index.jsp" class="nav-link px-2 text-muted">Home</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Notice</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Section</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Contact</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">About</a></li>
    </ul>
  </footer>
</div>
</body>
</html>