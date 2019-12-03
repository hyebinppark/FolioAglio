<%@page import="java.util.Calendar"%>
<%@page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="file.DBUtil"%>
<%
	String strY = request.getParameter("year");
		String strM = request.getParameter("month");
		Calendar Tday = Calendar.getInstance();
		Calendar getFday = Calendar.getInstance();
		Calendar getLday = Calendar.getInstance();
		Calendar getLastM = Calendar.getInstance();
		int y = Tday.get(Calendar.YEAR);
		int m = Tday.get(Calendar.MONTH);
		int d = Tday.get(Calendar.DATE);
		int today = Tday.get(Calendar.DAY_OF_WEEK);
		if (strY != null) {
		  y = Integer.parseInt(strY);
		  m = Integer.parseInt(strM);
		} else {}
		Tday.set(y, m, d);
		getFday.set(y, m, 1);
		getLastM.set(y, m%12-1, 1);
		int ThisFday = getFday.get(Calendar.DAY_OF_WEEK);
		int ThisLdate = Tday.getActualMaximum(Calendar.DATE);
		getLday.set(y, m, ThisLdate);
		int ThisLday = getLday.get(Calendar.DAY_OF_WEEK);
		int LastLdate = getLastM.getActualMaximum(Calendar.DATE);
		int realMonth = m+1;
		
		int dbi = 0;
		String[][] db = new String[100][3];
		String[] line = new String[3];
		String[][] event = new String[10][2];
		String[] cEvent = new String[5];
		String date;
		int i, j, k;
		
		Connection conn = DBUtil.getConn();
		PreparedStatement ps = conn.prepareStatement("select sch_name, sch_date, sch_num from scheduler where year(sch_date) = '" + y + "' and month(sch_date) = '" + realMonth + "' order by sch_date, sch_time;");
		ResultSet rs = ps.executeQuery();
	
		while(rs.next()){
			line[0] = rs.getString("sch_name");
			line[1] = rs.getString("sch_date").split("-")[2];
			line[2] = rs.getString("sch_num");
			
			db[dbi][0] = line[0];
			db[dbi][1] = line[1];
			db[dbi++][2] = line[2];
		}
		ps.close();
		rs.close();
		conn.close();
%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="calendar.css">
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<script type="text/javascript">
    
		var option = "width=500, height=350, resizable=no, scrollbars=no";
        function openAdd() {
            // window.open(path, 자식창 이름, 옵션);
            window.open("main/scheduler.jsp", "add", option);    
        }
        function openShow(sch_num) {
			window.open("schedulerForm.jsp?sch_num="+sch_num, "show", option);
        }
	</script>
<title>Calendar</title>
</head>
<body>
	<div class="top">
	<a href = "Calendar.jsp?year=<%=y-1%>&amp;month=<%=m%>" class="triangle-left"></a>
	<div class="year"><%=y%>년</div>
    <a href = "Calendar.jsp?year=<%=y+1%>&amp;month=<%=m%>" class="triangle-right"></a>
    <div class="months">
    <%
    	for (i = 1; i <= 12; i++) {
    		if (i == realMonth) {%>
    			<span class="month-color"><%=i%>월</span>
    		<%} else {%>
    			<a href = "Calendar.jsp?year=<%=y%>&amp;month=<%=i-1%>"><span><%=i%>월</span></a>
    		<%}
    	}%>
    </div><!-- months -->
	</div><!-- top -->

	<div class="container">
	
 	<div class="calendar-base">
 	<div class="calendar-right">
    
    <div class="days">일 월 화 수 목 금 토</div>
    
    <div class="num-dates">
		<div class="week">
			<% for (i = ThisFday-1; i > 0; i--) {%>
				<div class="num-date">
				<span class="otherMonth"><%=LastLdate-i%></span>
				</div>
			<%} for (i = 0; i < ThisLdate; i++) {
					j = 0; k = 0;
					while(db[j][1] != null) {
						if (Integer.parseInt(db[j][1]) == i+1) {
							event[k][0] = db[j][0];
							event[k++][1] = db[j][2];
						} j++;
					}
					if (i+1 < 10) {
						String str = String.valueOf(i+1); 
						str = '0' + str;%>
						<div class="num-date">
						<span class="thisMonth"><%=str%></span>
						<% k=0; while (event[k][0] != null){%>
						<a onclick="openShow(<%=event[k][1]%>)"><input type="text" value="<%=event[k++][0]%>" class="event-name" readonly/></a>
						<%}%></div>
					<%} else {%>
						<div class="num-date">
						<span class="thisMonth"><%=i+1%></span>
						<% k=0; while (event[k][0] != null){%>
						<a onclick="openShow(<%=event[k][1]%>)"><input type="text" value="<%=event[k++][0]%>" class="event-name" readonly/></a>
						<%}%></div>
					<%}
					if ((i+ThisFday)%7==0) {%>
						</div><div class="week">
					<%}
					event = new String[10][2];
			} for (i = 1; i+ThisLday <= 7; i++) {%>
				<div class="num-date">
				<span class="otherMonth"><%=i%></span>
				</div>
			<%}%>
		</div>
    </div> <!-- num-dates -->
    
    </div> <!-- calendar-right -->
    </div> <!-- calendar-base -->
	
	<div class="calendar-left">
	
	<div class="returnTday"><a href = "Calendar.jsp">오늘은</a></div>
    <div class="today"><%=d%></div>
    <div class="day">
    	<%if (today == 1) {%>일요일 <%}
    	  else if (today == 2) {%>월요일<%}
    	  else if (today == 3) {%>화요일<%}
    	  else if (today == 4) {%>수요일<%}
    	  else if (today == 5) {%>목요일<%}
    	  else if (today == 6) {%>금요일<%}
    	  else if (today == 7) {%>토요일<%}%>
    </div> <!--day -->
    
    <div class="current-events">다가오는 일정
      <br/>
      <ul>
      <% i = 0; j = 0;
      	while(db[i][1] != null) {
			if(Integer.parseInt(db[i][1]) >= d){
				cEvent[j++] = db[i][0];
			}
			if(j == 5) break;
			i++;
      	}
      	for(i = 0; i < j; i++) {
      %>
        <li><%=cEvent[i]%></li>
      <%} 
      	for(i=0;i<5;i++) cEvent[i] = "";%>
      </ul>
    </div> <!-- current-events -->
    
    <div class="add-event">일정 추가<a onclick="openAdd()"><img src="image/iconmonstr-plus-circle-thin-240.png"></a></div>

	</div> <!-- calendar-left -->
	
	</div> <!-- container -->
</body>
</html>