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
  	if(userID == null){
  		PrintWriter script = response.getWriter();
  		script.println("<script>");
  		script.println("alert('로그인 하세요')");
  		script.println("location.href='login.jsp'");
  		script.println("</script>");
  	}
  	int bbsID = 0;
  	if(request.getParameter("bbsID") != null){
  		bbsID = Integer.parseInt(request.getParameter("bbsID"));
  	}
  	if(bbsID == 0){
  		PrintWriter script = response.getWriter();
  		script.println("<script>");
  		script.println("alert('유효하지 않은 글입니다')");
  		script.println("location.href='bbs.jsp'");
  		script.println("</script>");
  	}
  	
  	//작성자 본인 확인절차
  	Bbs bbs = new BbsDAO().getBbs(bbsID);
  	if(!userID.equals(bbs.getUserID())){
  		PrintWriter script = response.getWriter();
  		script.println("<script>");
  		script.println("alert('권한이 없습니다')");
  		script.println("location.href='bbs.jsp'");
  		script.println("</script>");
  	}
  %>
     <nav class="navbar navbar-expand-md navbar-dark bg-dark mb-4">
  <a class="navbar-brand" href="index.jsp">JSP게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    
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
    
  </div>
</nav>

<div class="container">
	<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>">
		<table class="table table-striped" style="border:1px solid #ddd;">
			<thead>
				<tr>
					<th colspan="2" style="text-align:center;">게시글수정하기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				
					<td><input type="text" class="form-control" placeholder="제목을 입력하세요" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle() %>"></td>
				</tr>
				<tr>
					<td style="text-algin:left;"><textarea class="form-control" placeholder="내용을 입력하세요" name="bbsContent" maxlength="2048" 
					style="height:300px; ">
					<%=bbs.getBbsContent() %>
					</textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" class="btn btn-primary pull" style="float:right;" value="수정하기">
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