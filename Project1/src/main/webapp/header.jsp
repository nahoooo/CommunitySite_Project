<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String filePath = request.getParameter("filePath");
String Currentlocation = null;
if (filePath == null) {
	Currentlocation = "home";
} else if (filePath.contains("board") || filePath.contains("Board")) {
	Currentlocation = "COMMUNITY";
}else if (filePath.contains("goodRestaurant")){
	Currentlocation="나만의 맛집";
}

String nickname = (String) session.getAttribute("nickname");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Agency - Start Bootstrap Theme</title>
        <!-- Favicon-->
        <link rel="icon" type="resource/image/x-icon" href="resource/assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="./resource/css/styles.css" rel="stylesheet" />
    </head>
    <body >
           
        <!-- Masthead-->          
          <nav class="navbar navbar-expand-lg navbar-dark" id="mainNav" style="background : rgba(0, 0, 0, 0.8)";>

            <div class="container">
                <a class="navbar-brand" href="index.jsp"><img src="resource/assets/img/navbar-logo.svg" alt="..." /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">    
                    	  <li class="nav-item"><a class="nav-link" href="TasteMap">맛지도</a></li>                                
                        <li class="nav-item"><a class="nav-link" href="GetRestaurantListPro">나만의 맛집</a></li>                       
                        <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">COMMUNITY</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=notice">공지사항</a></li>
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=review">맛집방문기</a></li>
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=recipe">나만의레시피</a></li>
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=free">자유게시판</a></li>
								<li><a class="dropdown-item" href="GetBoardListPro?boardtype=questions">문의사항</a></li>
							</ul></li>
						    <%
						if (nickname == null) {
						%>
						<li class="nav-item"><a class="nav-link" href="index.jsp?filePath=login">Login</a></li>
						<%
						} else if (nickname != null) {
						%>					
						<li class="nav-item"><a class="nav-link" href="#"><%=nickname%>님</a></li>
						<li class="nav-item"><a class="nav-link" href="Logout">LOGOUT</a></li>
						<%
						}
						%> 	
                    </ul>
                </div>
            </div>
        </nav>
        <%if(filePath.equals("home")){ %>
       <header class="masthead">
            <div class="container">
                <div class="masthead-subheading">오늘 뭐먹지?</div>
                <div class="masthead-heading text-uppercase">여러분의 맛집을 공유해주세요!</div>
                <a class="btn btn-primary btn-xl text-uppercase" href="GetRestaurantListPro">맛집공유하기</a>
                <a class="btn btn-outline-warning" href="GetRestaurantListPro">맛집공유하기</a>
            </div>
        </header>
        <%}else{ %>
          <header class="masthead">
            <div class="container">            
            </div>
        </header>
        <%} %>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->   
      <!--   <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->
    </body>
</html>
