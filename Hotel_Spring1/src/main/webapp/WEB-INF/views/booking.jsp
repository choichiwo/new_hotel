<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약관리</title>
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
                	<li><a href="logout">로그아웃</a></li>
                </ul>
             </div><!--gnav-->
        </header>
    
        <main>
            <div class="space">
                <table class="space_table">
                    <tr>
                        <th>예약기간</th>
                        <td><input type="text">~<input type="text"></td>
                    </tr>
                    <tr>
                        <th class="bunlyu">객실종류</th>
                        <td>
                            <select name="possible_day" id="roomtype" size="1" style="width:200px;">
                            <c:forEach items="${roomType}" var="room">
                             	<option value="${room.typecode}">${room.name}</option>
                             	console.log(${roomType});
                             </c:forEach> 
                                <!-- <option value="" selected>객실을 선택해 주세요.</option>
                                <option value="Suite Room">Suite Room</option>
                                <option value="Family Room">Family Room</option>
                                <option value="Double Room">Double Room</option>
                                <option value="Single Room">Single Room</option>
                                <option value="Domitory">Domitory</option> -->
                            </select>
                                <input type="button" value="조회" id="btnFind">
                        </td>
                    </tr>
                </table>
                <div class="possible_list">
                        <h2>예약가능객실</h2>
                            <select id="roomlist" size="10" name="pref" >
                                <!-- <option value="" selected>객실을 선택해 주세요.</option>
                                <option value="Suite Room">Suite Room</option>
                                <option value="Family Room">Family Room</option>
                                <option value="Double Room">Double Room</option>
                                <option value="Single Room">Single Room</option>
                                <option value="Domitory">Domitory</option> -->
                                </select>
                </div><!-- possible_list -->
            </div><!-- space -->


            <div class="choicesystem">
                <div class="room_choice">
                    <table class="choices">
                        <tr>
                            <th>객실명</th>
                            <td><input type="text" name="roomname" id="roomname" size="20"><input type="hidden" id="roomcode"></td>
                        </tr>
                        <tr>
                            <th>객실종류</th>
                            <select name="possible_day" id="roomtype" size="1" style="width:200px;">
                            <c:forEach items="${roomType}" var="room">
                             	<option value="${room.typecode}">${room.name}</option>
                             	console.log(${roomType});
                             </c:forEach> 
                             </select>
                            <!-- <td><input type="text" name="a1" id="roomtype" size="20"></td> -->
                        </tr>
                        <tr>
                            <th>예약인원</th>
                            <td><input type="text" name="a1" id="howman" size="20">명</td>
                        </tr>
                        <tr>
                            <th>최대인원</th>
                            <td><input type="text" name="a1" id="howmany" size="20">명</td>
                        </tr>
                        <tr>
                            <th class="bunlyu">예약기간</th>
                            <td><input id="bunlyu" type="text">~<input type="text"></td>
                        </tr>
                        <tr>
                            <th>예약자명</th>
                            <td><input type="text" name="a2" id="howname" size="20"></td>
                        </tr>
                        <tr>
                            <th>모바일</th>
                            <td><input type="text" name="a2" id="mobile" size="20"></td>
                        </tr>
                    </table>
                </div><!-- loom_choice -->
                <div class="btns">
                    <input type="button" value="예약완료" class="btn btn-check">
                    <input type="button" value="비우기" class="btn btn-delete">
                    <input type="button" value="예약취소" class="btn btn-clear">
                </div><!-- btns -->
            </div><!-- choicesystem -->


            <div class="impossible_list">
                <h2>예약된 객실</h2>
                    <select size="7" name="pref" multiple>
                        <option value="" selected>객실을 선택해 주세요.</option>
                        <option value="Suite Room">Suite Room</option>
                        <option value="Family Room">Family Room</option>
                        <option value="Double Room">Double Room</option>
                        <option value="Single Room">Single Room</option>
                        <option value="Domitory">Domitory</option>
                        </select>
            </div><!--  impossible_list -->

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
.on("click","#btnFind", function(){
	let typecode=$('#roomtype').val();
	if(typecode==1){ //선택시 같은 type코드가 선택될수 있게 해줌. true가 선택됬다표시
		$("#roomlist").val();
	} else if(typecode==2){
		$("#roomlist").val();
	} else if(typecode==3){
		$("#roomlist").val();
	} else if(typecode==4){
		$("#roomlist").val();
	}
	return false;
})
.on("click","#roomlist", function(){
	var roomlist = $("#roomlist option:selected").text(); //option값 가져오기
	var roomlist1 = $("#roomlist").val(); //value에서 typecode 가져오기
	var pk = String(roomlist1).split(" "); //typecode를 가져오기 위해 split
	var typecode = parseInt(pk[1]); //int로 타입변환
	var list = String(roomlist).split(","); //option에서 가져온 값들 배열로 슬라이싱

	let code=$("#roomlist option:selected").val();
	$("#roomcode").val(code);
	
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
</script>
</html>