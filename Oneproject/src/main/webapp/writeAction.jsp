<%@page import="java.io.PrintWriter" %>
<%@page import="bbs.BbsDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("utf-8"); %>
    <jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
    <jsp:setProperty name = "bbs" property="bbsTitle"/>
    <jsp:setProperty name = "bbs" property="bbsContent"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	//로그인 확인
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하셔야 게시글을 작성하실 수 있습니다')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else{
		//미입력부분 확인
		if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			//로그인, 입력부분 확인 후 작성 및 에러
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			//데이터베이스오류
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				//정상작동
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글 작성 성공')");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}
	}
	
	
%>
</body>
</html>