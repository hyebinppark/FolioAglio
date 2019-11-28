<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="file.DBUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn = DBUtil.getConn();
	
	String skill_radio = new String(request.getParameter("radio").getBytes("ISO-8859-1"), "UTF-8");
	String language_name = new String(request.getParameter("language_name").getBytes("ISO-8859-1"), "UTF-8");
	String kind = new String(request.getParameter("kind").getBytes("ISO-8859-1"), "UTF-8");
	String application_num = new String(request.getParameter("application_num").getBytes("ISO-8859-1"), "UTF-8");
	String test_date = new String(request.getParameter("test_date").getBytes("ISO-8859-1"), "UTF-8");
	String score = new String(request.getParameter("score").getBytes("ISO-8859-1"), "UTF-8");
	String score_name = new String(request.getParameter("score_name").getBytes("ISO-8859-1"), "UTF-8");
	String classfication_name = new String(request.getParameter("classfication_name").getBytes("ISO-8859-1"), "UTF-8");
	String issue_org = new String(request.getParameter("issue_org").getBytes("ISO-8859-1"), "UTF-8");
	String issue_date = new String(request.getParameter("issue_date").getBytes("ISO-8859-1"), "UTF-8");
	
	String sql = "insert into skill(skill_radio, language_name, kind, application_num, test_date, score, score_name, classfication_name, issue_org, issue_date) values (?,?,?,?,?,?,?,?,?,?);";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, skill_radio);
	pstmt.setString(2, language_name);
	pstmt.setString(3, kind);
	pstmt.setString(4, application_num);
	pstmt.setString(5, test_date);
	pstmt.setString(6, score);
	pstmt.setString(7, score_name);
	pstmt.setString(8, classfication_name);
	pstmt.setString(9, issue_org);
	pstmt.setString(10, issue_date);
	pstmt.executeUpdate();
	
	DBUtil.close(pstmt);
	DBUtil.close(conn);
	%>
	
</body>
</html>