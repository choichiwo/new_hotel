<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약된 객실</title>
</head>
<!-- 객실관리 Guest_room CSS 임포트 -->
<link rel="stylesheet" href="resources/home/css/Guest_room.css">
<body>
   <div id="container">
        <header>
            <div id="gnav">
                <ul class="menu">
                    <li><a href="room">객실관리</a></li>
                	<li><a href="booking">예약관리</a></li>
                	<li><a href="checkbooking">예약된 객실</a></li>
                	<li><a href="logout">로그아웃</a></li>
                </ul>
             </div><!--gnav-->
        </header>
    
        <main>
            <div class="space">
                <table class="space_table">
                    <tr>
                        <th class="bunlyu">객실종류</th>
                        <td>
                            <select name="impossible_list" id="impossible_list" size="1" style="width:200px;">
                          
                            </select>
                        </td>
                    </tr>
                </table>
            </div><!-- space -->

        </main>

        </div><!--container -->
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.ready(function() {
	$.post("http://localhost:8080/app/checkbooking",{},function(result){ 
		//$.post("http://localhost:8081/app/getgetBooking",{},function(result){
				$.each(result,function(ndx,value){
					str='<option value="'+value['bookcode']+' '+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+value['typename']+','+value['person']+','+value['howmany']+','+value['summuch']+','
					+value['checkin']+','+value['checkout']+','+value['name']+','+value['mobile']+'</option>';
					$("#impossible_list").append(str);
				});
		},"json");	
})
</script>
</html>