<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="file.DBUtil" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="../maincss.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale ="1">
<title>일정 추가</title>
<script>
   window.addEventListener('load', function() {
      var confirm = document.querySelector('#confirm');
      
      confirm.addEventListener('click', function() {

         var name = document.querySelector('#name');
         var date = document.querySelector('#date');
         var time = document.querySelector('#time');
         var memo = document.querySelector("#memo");
      
         // 전체 검사
         // 체류국가가 입력되지 않았을시
         if (name.value == '') {
            alert('일정명을 입력하세요.');
            name.focus();
            // 체류형태가 입력되지 않았을시
         } else if (date.value == '') {
            alert('날짜를 입력하세요.');
            date.focus();
            // 구사언어가 입력되지 않았을시
         }else {
        	 var formData = $("#form1").serialize();
        	 $.ajax({
                 cache : false,
                 url : "schedulerAction.jsp", // 요기에
                 type : 'POST', 
                 data : formData,
                 async: false,
                 success : function(data) {
					
                 }
             });
        	 self.close();
        	 opener.location.reload();
         }

      });
   });
   
   function inputTimeColon(time) {

        // 먼저 기존에 들어가 있을 수 있는 콜론(:)기호를 제거한다.
        var replaceTime = time.value.replace(/\:/g, "");

        // 글자수가 4 ~ 5개 사이일때만 동작하게 고정한다.
        if(replaceTime.length >= 4 && replaceTime.length < 5) {

            // 시간을 추출
            var hours = replaceTime.substring(0, 2);

            // 분을 추출
            var minute = replaceTime.substring(2, 4);

            // 시간은 24:00를 넘길 수 없게 세팅
            if(hours + minute > 2400) {
                alert("시간은 24시를 넘길 수 없습니다.");
                time.value = "24:00";
                return false;
            }

            // 분은 60분을 넘길 수 없게 세팅
            if(minute > 60) {
                alert("분은 60분을 넘길 수 없습니다.");
                time.value = hours + ":00";
                return false;
            }

            // 콜론을 넣어 시간을 완성하고 반환한다.
            time.value = hours + ":" + minute;
        }
   }

</script>

</head>
<body>
   <form action="schedulerAction.jsp" method="post" id = "form1">
		<fieldset class="field_info">
         <legend>일정 추가</legend>
         <table>
            <tr>
               <td>일정명</td>
               <td><input type="text" id="name" name="name"></td>
            </tr>
            <tr>
               <td>날짜</td>
               <td><input type="text" id="date" name="date" placeholder="0000-00-00">
               <script>
                  $(function(){
                     $("#date").datepicker({ dateFormat:'yy-mm-dd'});
                  });
               </script></td>
            </tr>
            <tr>
               <td>시간</td>
               <td><input type="text" id="time" name="time" value="00:00" onKeyup="inputTimeColon(this);"></td>
            </tr>
            <tr>
               <td>내용</td>
               <td><textarea name="memo" rows="10" cols="50"></textarea></td>
            </tr>
            <tr align="right">
               <td colspan="2"><input type="button" id="confirm" class = "button_css"
                  value="확인">
               </td>
            </tr>
         </table>
      </fieldset>
   </form>
   
</body>
</html>