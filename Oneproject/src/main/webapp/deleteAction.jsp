<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="bbs.BbsDAO" %>
<%@page import="bbs.Bbs" %>
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
		script.println("alert('로그인을 하셔야 게시글을 삭제하실 수 있습니다')");
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
	
	Bbs bbs1 = new BbsDAO().getBbs(bbsID);
	if(!userID.equals(bbs1.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}else{
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.delete(bbsID);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제하기에 실패하셨습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제하기에 성공하셨습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
	}
%>
</body>
</html>