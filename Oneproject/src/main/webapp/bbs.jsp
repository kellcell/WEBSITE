<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "java.io.PrintWriter" %>
    <%@page import = "bbs.BbsDAO" %>
    <%@page import = "bbs.Bbs" %>
    <%@page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

    <title>Title</title>
  </head>
  <body>
  <%
  	String userID = null;
  	if(session.getAttribute("userID") != null){
	  userID = (String)session.getAttribute("userID");
  	}
  	
  	int pageNumber = 1; //페이지 기본값(1)
  	
  	if(request.getParameter("pageNumber") != null){
  		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
  	}
  %>
     <nav class="navbar navbar-expand-md navbar-dark bg-dark mb-4">
  <a class="navbar-brand" href="index.jsp">JSP게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <%
    	if(userID == null){
    %>
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="index.jsp">홈으로 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="bbs.jsp">게시판</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="login.jsp">로그인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="join.jsp">회원가입</a>
      </li>
    </ul>
    <%
    	}else{
    %>
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="index.jsp">홈으로 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="bbs.jsp">게시판</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="logoutAction.jsp">로그아웃</a>
      </li>
    </ul>
    <%
    	}
    %>
    
  </div>
</nav>

<div class="container">
<table class="table table-striped">
<thead>
    <tr>
      <th scope="col">번호</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">작성일자</th>
    </tr>
  </thead>
  <tbody>
  	<%
  		BbsDAO bbsDAO = new BbsDAO();
  		ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
  		for(int i= 0; i < list.size(); i++){
  	%>
    <tr>
      <th scope="row"><%=list.get(i).getBbsID() %></th>
      <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>">
      <%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;")
				.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
      <td><%=list.get(i).getUserID() %></td>
      <td><%=list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + ":" + list.get(i).getBbsDate().substring(14,16)%></td>
    </tr>
    <%
  		}
    %>
    </tbody>
    </table>
    
    <!-- 페이지영역 -->
    <% 
    	if(pageNumber != 1){
    %>
    	<a href="bbs.jsp?pageNumber=<%=pageNumber - 1  %>" class="btn btn-success btn-arraw-left">이전</a>
    <%
    	}if(bbsDAO.nextPage(pageNumber + 1)){
    %>
        	<a href="bbs.jsp?pageNumber=<%=pageNumber + 1  %>" class="btn btn-success btn-arraw-left">다음</a>
    <%
    	}
    %>
    
	<button type="button" class="btn btn-primary" style="float:right;"onclick="location.href='write.jsp'">글쓰기</button>
	</div>
	
    <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

    <!-- Option 2: jQuery, Popper.js, and Bootstrap JS
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    -->
  </body>
</html>