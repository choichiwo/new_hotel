<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>        
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실관리</title>
    
</head>
<!-- 예약관리 Reservation CSS 임포트 -->
<link rel="stylesheet" href="resources/home/css/Reservation.css">
<body>
    <div id="container">
    <header>
        <div id="gnav">
            <ul class="menu">
                <li><a href="room">객실관리</a></li>
                <li><a href="booking">예약관리</a></li>
                <li><a href="logout">로그아웃</a></li>
            </ul>
         </div><!--gnav-->
    </header>

    <main>
        <div class="nav">
            <h2>객실목록</h2>
                <select id="roomlist" size="10" style="width:250px;">
                    <%-- <c:forEach items="${list}" var="room">
                    	<option value="${room.roomcode}">${room.roomname},${room.typename},${room.howmany},${room.howmuch}</option>
                    </c:forEach> --%>
                </select>
    </div><!-- nav -->
        <div class="choicesystem">
            <div class="room_choice">
                <table class="choices">
                    <tr>
                        <th>객실이름</th>
                        <td><input type="text" id="roomname" name="room_name" size="20"><input type="hidden" id="roomcode"></td>
                    </tr>
                    <tr>
                        <th class="bunlyu">객실분류</th>
                        <td>
                        	<select id="roomtype" size="10" style="width:250px;">
                             <c:forEach items="${roomType}" var="room">
                             	<option value="${room.typecode}">${room.name}</option>
                             </c:forEach>
                             </select>
                        </td>
                    </tr>
                    <tr>
                        <th>숙박가능인원</th>
                        <td><input type="text" id="howmany" name="a1" size="20">명</td>
                    </tr>
                    <tr>
                        <th>1박요금</th>
                        <td><input type="text" id="howmuch" name="a1" size="20">원</td>
                    </tr>
                </table>
            </div><!-- loom_choice -->
            <div class="btns">
                <input type="button" value="등록" id="btnAdd" class="btn btn-check">
                <input type="button" value="삭제" id="btnDelete" class="btn btn-delete">
                <input type="button" value="초기화" id="btnEmpty" class="btn btn-clear">
            </div><!-- btns -->
        </div><!-- choicesystem -->
    </main>
    </div><!--container -->
 
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.ready(function() {
	$.post("http://localhost:8080/app/getRoomList",{},function(result){
	//$.post("http://localhost:8081/app/getRoomList",{},function(result){
			console.log(result);
			$.each(result,function(ndx,value){
				str='<option value="'+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
				$("#roomlist").append(str);
				/* str='<option value="${value['roomcode']}">${value['roomname']},
				${value['typename']}${value['howmany']}${value['howmuch']}</option>';
				<option value="2">백두산,Suite Room,8,500000</option>*/
			});
	},"json");
})
.on("click","#roomlist", function(){
	var roomlist = $("#roomlist option:selected").text(); //option값 가져오기
	var roomlist1 = $("#roomlist").val(); //value에서 typecode 가져오기
	var pk = String(roomlist1).split(" "); //typecode를 가져오기 위해 split
	var typecode = parseInt(pk[1]); //int로 타입변환
	var list = String(roomlist).split(","); //option에서 가져온 값들 배열로 슬라이싱
	var roomcode = parseInt(pk[0]);
	$("#roomcode").val(roomcode);
	
	var roomname = list[0];
	var roomtype = list[1];
	var howmany = list[2];
	var howmuch = list[3];
	
	$("#roomname").val(roomname);
	$("#howmany").val(howmany);
	$("#howmuch").val(howmuch);
	
	if(typecode==1){ //선택시 같은 type코드가 선택될수 있게 해줌. true가 선택됬다표시
		$("#roomtype").val(1).prop("selected", true);
	} else if(typecode==2){
		$("#roomtype").val(2).prop("selected", true);
	} else if(typecode==3){
		$("#roomtype").val(3).prop("selected", true);
	} else if(typecode==4){
		$("#roomtype").val(4).prop("selected", true);
	}
	return false;
})
.on("click","#btnEmpty", function(){
	$("#roomname,#howmany,#howmuch,#roomtype,#roomcode").val("");
	return false;
})
.on("click","#btnDelete", function(){
	$.post("http://localhost:8080/app/deleteRoom",{roomcode:$('#roomcode').val()},
	//$.post("http://localhost:8081/app/deleteRoom",{roomcode:$('#roomcode').val()},		
			function(result){
		console.log(result);
		if(result=="ok"){
			$('#btnEmpty').trigger('click'); //입력란 비우기
			$('#roomlist option:selected').remove(); //room리스트에서 제거
		}
	},'text');
	return false;
})
.on('click','#btnAdd',function(){
	let roomname=String($('#roomname').val());
	let roomtype=String($('#roomtype').val());
	let howmany=String($('#howmany').val());
	let howmuch=String($('#howmuch').val());
	// validation (유효성검사)
	if(roomname=='' || roomtype=='' || howmany=='' || howmuch==''){
		alert('누락된 값이 있습니다.');
		return false;
	}
	let roomcode=String($('#roomcode').val());
	if(roomcode==''){ //insert
		$.post("http://localhost:8080/app/addRoom",
		//$.post("http://localhost:8081/app/addRoom",		
				{roomname:roomname,roomtype:roomtype,howmany:howmany,howmuch:howmuch},
				function(result){
			console.log(result);
			if(result=="ok"){
				location.reload();
			}
		},'text');
	} else { // update
		$.post("http://localhost:8080/app/updateRoom",
		//$.post("http://localhost:8081/app/updateRoom",		
				{roomcode:roomcode,roomname:roomname,roomtype:roomtype,howmany:howmany,howmuch:howmuch},
				function(result){
			console.log(result);
			if(result=="ok"){
				location.reload();
			}
		},'text');
	}
	
	return false;
})
</script>
</html>