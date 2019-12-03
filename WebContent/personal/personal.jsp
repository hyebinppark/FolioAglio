<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
 <style>
   @import url(http://fonts.googleapis.com/earlyaccess/hanna.css);
   @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
   
   body {
      font-family: Nanum Gothic;
   }
   a { text-decoration:none}
   .navbar {
      background-color : #B2CCFF;
      padding : 0.375rem 1rem;
      position : relative;
      align-items : center;
      font-family : Hanna;
   }
   .navbar ul li {
      float : left;
      margin-left : 15px;
      list-style : none ;
   }
   .navbar_item{
      align-items : center;
      margin-right : 16px;
      padding : 15px;
      display : flex!important;
   }
   .logout{
        display: block;
        margin: 20px auto;
        padding : 10px 10px;
        background : none;
        border : 0px;
        border-radius : 5px;
        font-family : Hanna;
        font-size : 15px;
        color : white;
   }
   .logout:hover{
        background : #636363;
        border : 0px;
   }
   .menuLink{
      text-decoration : none;
      display : block;
      color : white;
   }
   .menuLink:hover {
      color : #636363;
      font-wieght : bold;
   }
   .container {
      display : flex;
   }
   .header_name {
      font-family : Malgun Gothic;
      font-size : 20px;
      font-weight : bold;
      color : white;
   }
   .bodystyle{
	padding : 10px;
   }
   .idpic{
   	width :105px; 
   	height : 135px; 
   	border : 1px solid;
   	margin-right : 10px; 
   }
   .field{
   	border : 1px solid;
   	margin-top : 10px;
   }
   .field legend{
   	font-family : Hanna;
   	font-size : 26px;
   }
   </style>
<meta charset="EUC-KR">
<title>personal</title>
<script>
	function popup_personal_information(){
		var url = "Personal_information.jsp";
		var name = "Personal Information";
		var option = "width = 500, height = 500, top = 100, left = 200, location = no";
		window.open(url, name, option);
	}
</script>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("../logout.jsp");
    }
%>
</head>
<body>

	<header>
		<div class="navbar container">
   			<a class="header_name" role="button" href="../main/main.jsp" style="text-decoration:none;">Folio Aglio</a>
   			<div class="navbar_item">
      		<ul>
	      		<li><a class="menuLink" href="../personal/personal.jsp">인적</a></li>
         		<li><a class="menuLink" href="../education/education.jsp">학력</a></li>
         		<li><a class="menuLink" href="../career/career.jsp">경력</a></li>
         		<li><a class="menuLink" href="../abroad/abroad.jsp">해외경험</a></li>
         		<li><a class="menuLink" href="../external_activity/external_activity.jsp">대외활동</a></li>
         		<li><a class="menuLink" href="../award/awards.jsp">수상경력</a></li>
         		<li><a class="menuLink" href="../certification/certification.jsp">자격증</a></li>
         		</ul>
   			</div>
 
   			<div class="navbar_item">
	   			<a href="../logout.jsp"><button class="logout">로그아웃</button></a>
	   		</div>
		</div>
	</header>
	
	<%
	String id_pic="";
	String name = "";
	String birth = "";
	String call_num = "";
	String email = "";
	Object session_object=session.getAttribute("signedUser");
	String session_name=(String)session_object;

	try {
		Connection conn = DBUtil.getConn();
		
		String sql = "select id_image, name, birth, call_num, email from personal_information where id=?;";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1,session_name);
	    ResultSet rs = pstmt.executeQuery();

		
		while(rs.next()) {
			id_pic = rs.getString("id_image");
			name = rs.getString("name");
			birth = rs.getString("birth");
			call_num = rs.getString("call_num");
			email = rs.getString("email");
		}
	
	%>
	<fieldset class="field">
		<legend>인적사항</legend>
		<table class="bodystyle">
	<%
		if("".equals(id_pic)){
	%>
			<tr>
				<td rowspan="5" colspan="2" align="center">
				<button type="file" class="idpic" style="background: none;";>No Image</button></td>
			</tr>
	<%
		} else {
	%>
			<tr>
				<td rowspan="5" colspan="2" align="center"><img class="idpic" src="<%=id_pic%>"></td>
				<%=id_pic%>
			</tr>
	<%
		}
	%>

			<tr>
				<td>이름</td>
				<td> : </td>
				<td><%=name %></td>
				<td><button onClick="popup_personal_information()">수정</button></td>
			</tr>
			<tr>
				<td>생년월일 </td>
				<td> : </td>
				<td><%=birth %></td>
			</tr>
			<tr>
				<td>전화번호 </td>
				<td> : </td>
				<td><%=call_num %></td>
			</tr>
			<tr>
				<td>이메일 </td>
				<td> : </td>
				<td><%=email %></td>
			</tr>
			<form method="post" enctype="multipart/form-data" action="upload.jsp">

<input type="file" name="filename">

<input type="submit" value="업로드">

</form>
		</table>
	</fieldset>
	<%
	rs.close();
	conn.close();
	pstmt.close();
	}catch(SQLException e) {
		// e.printStackTrace();
		out.println(e.toString());
	}
	%>
</body>
</html>