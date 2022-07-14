<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    <%@ page import = "bbs.Bbs" %>
    <%@ page import = "bbs.BbsDAO" %>
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
  	//bbsID 초기화
  	int bbsID = 0;
  	if(request.getParameter("bbsID") != null){
  		bbsID = Integer.parseInt(request.getParameter("bbsID"));
  	}
  	// 데이터 없음
  	if(bbsID == 0){
  		PrintWriter script = response.getWriter();
  		script.println("<script>");
  		script.println("alert('유효하지 않은 글입니다')");
  		script.println("location.href='bbs.jsp'");
  		script.println("</script>");
  	}
  	// 데이터 저장
  	Bbs bbs = new BbsDAO().getBbs(bbsID);
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
	<form method="post" action="writeAction.jsp">
		<table class="table table-striped" style="border:1px solid #ddd;">
			<thead>
				<tr>
					<th colspan="2" style="text-align:center;">게시글보기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width:20%;">글 제목</td>
					<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
				</tr>
				<tr>
					<td style="width:20%;">작성자</td>
					<td colspan="2"><%=bbs.getUserID() %></td>
				</tr>
				<tr>
					<td style="width:20%;">작성일자</td>
					<td colspan="2"><%=bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + ":" + bbs.getBbsDate().substring(14,16)%></td>
				</tr>
				<tr>
					<td style="width:20%;">내용</td>
					<td colspan="2" style="height:250px;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
				</tr>
			</tbody>
		</table>
		<a href="bbs.jsp" class="btn btn-primary">목록</a>
		
		<%
			if(userID != null && userID.equals(bbs.getUserID())){
		%>
			<a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
			<a href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary" onclick="return confirm('해당 게시글을 삭제하시겠습니까?')">삭제</a>
		<%
			}
		%>
	</form>
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