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
<link rel="stylesheet" href="resources/home/css/Checkbooking.css">
<body>
   <div id="container">
        <header>
            <div id="gnav">
                <ul class="menu">
                    <li><a href="room">객실관리</a></li>
                	<li><a href="booking">예약관리</a></li>
                	<li><a href="checkbooking">예약된 객실</a></li>
                	<li><a href="logout">${loginid}회원 로그아웃</a></li>
                </ul>
             </div><!--gnav-->
        </header>
    
        <main>
            <div class="space">
                <table class="space_table">
                   <th>예약기간&nbsp;</th>
                   <td><input id="checkin" name="checkin" type="date" required="required"> ~ <input id="checkout" name="checkout" type="date" required="required">&nbsp;&nbsp;&nbsp;</td>
                <th>객실종류&nbsp;&nbsp;</th>
                <td>
                <select size=1  id="select_roomtype">
		           <option value=1>Suite Room</option>
		           <option value=2>Family Room</option>
		           <option value=3>Double Room</option>
		           <option value=4>Single Room</option>
		      	 </select>
		      	 <input type="button" value="조회" id="btnFind">
		      	 </td>
                </table>
                
                <div class="impossible_list">
                <h1>예약된 객실</h1>
                <select name="impossible_list" size=12 id="impossible_list" multiple>
                </select>
                </div>
            </div><!-- space -->

        </main>

        </div><!--container -->
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.ready(function() {
	$.post("http://localhost:8080/app/checkBooking",{},function(result){ 
		//$.post("http://localhost:8081/app/getgetBooking",{},function(result){
				$.each(result,function(ndx,value){
					str='<option value="'+value['bookcode']+' '+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+value['typename']+','+value['person']+','+value['howmany']+','+value['summuch']+','
					+value['checkin']+','+value['checkout']+','+value['name']+','+value['mobile']+'</option>';
					$("#impossible_list").append(str);
				});
		},"json");	
})
.on("click","#btnFind", function(){
	var typecode = String($('#select_roomtype').val());
	
	$('#impossible_list').children('option').remove();	
	$.post("http://localhost:8080/app/getbooking",{checkin:$('#checkin').val(),checkout:$('#checkout').val(),typecode:typecode},function(result){
		//$.post("http://localhost:8081/app/getgetBooking",{},function(result){
				$.each(result,function(ndx,value){
					str='<option value="'+value['bookcode']+' '+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+value['typename']+','+value['person']+','+value['howmany']+','+value['summuch']+','
					+value['checkin']+','+value['checkout']+','+value['name']+','+value['mobile']+'</option>';
					$("#impossible_list").append(str);
				});
		},"json");	
	
	return false;
}) 
</script>
</html>