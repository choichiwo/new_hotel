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
                        <td><input id="checkin" name="checkin" type="date" required="required">~<input id="checkout" name="checkout" type="date" required="required"></td>
                    </tr>
                    <tr>
                        <th class="bunlyu">객실종류</th>
                        <td>
                            <select name="possible_day" id="roomtype" size="1" style="width:200px;">
                            <c:forEach items="${roomType}" var="room">
                             	<option value="${room.typecode}">${room.name}</option>         
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
                            <td>
                            <select name="possible_day" id="roomtype1" size="1">
                            <c:forEach items="${roomType}" var="room">
                             	<option value="${room.typecode}">${room.name}</option>
                             </c:forEach> 
                             </select>
                             </td>
                        </tr>
                        <tr>
                            <th>예약인원</th>
                            <td><input type="text" name="person" id="howman" size="20">명</td>
                        </tr>
                        <tr>
                            <th>최대인원</th>
                            <td><input type="text" name="howmany" id="howmany" size="20">명</td>
                        </tr>
                        <tr>
                            <th class="bunlyu">예약기간</th>
                            <td><input id="checkin1" type="date">~<input id="checkout1" type="date"></td>
                        </tr>
                        <tr>
                            <th>1박금액</th>
                            <td><input type="text" name="howmuch" id="howmuch" size="20">원</td>
                        </tr>
                        <tr>
                            <th>숙박비총액</th>
                            <td><input type="text" name="summuch" id="summuch" size="20">원</td>
                        </tr>
                        <tr>
                            <th>예약자명</th>
                            <td><input type="text" name="name" id="howname" size="20"></td>
                        </tr>
                        <tr>
                            <th>모바일</th>
                            <td><input type="text" name="mobile" id="mobile" size="20"></td>
                        </tr>
                    </table>
                </div><!-- loom_choice -->
                <div class="btns">
                    <input type="button" value="예약완료" id="btnAdd" class="btn btn-check">
                    <input type="button" value="비우기" id="btnEmpty" class="btn btn-delete">
                    <input type="button" value="예약취소" id="btnDelete" class="btn btn-clear">
                </div><!-- btns -->
            </div><!-- choicesystem -->


            <div class="impossible_list">
                <h2>예약된 객실</h2>
                    <select size="20" name="pref" id="impossible_list">
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
	var roomlist = $("#roomlist").text();
	var list = String(roomlist).split(",")
	let typecode=$('#roomtype').val();
	let typecode1=$('#roomlist').val();

	
	$('#roomlist').children('option').remove();
	$.post("http://localhost:8080/app/getRoomList1",{checkin:$('#checkin').val(),checkout:$('#checkout').val()},function(result){
		//$.post("http://localhost:8081/app/getRoomList",{},function(result){
				$.each(result,function(ndx,value){
					str='<option value="'+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+value['typename']+','+value['howmany']+','+value['howmany']+'</option>';
					if($('#roomtype').val()==value['typecode']){
						$("#roomlist").append(str);
					}
				});
		},"json");
		
	$('#impossible_list').children('option').remove();	
	$.post("http://localhost:8080/app/getbooking",{checkin:$('#checkin').val(),checkout:$('#checkout').val(),typecode:$('#roomtype1').val()},function(result){
		//$.post("http://localhost:8081/app/getgetBooking",{},function(result){
				$.each(result,function(ndx,value){
					str='<option value="'+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+value['typename']+','+value['person']+','+value['summuch']+','
					+value['checkin']+','+value['checkout']+','+value['name']+','+value['mobile']+'</option>';
					$("#impossible_list").append(str);
				});
		},"json");	
		
	return false;
}) 
.on("click","#roomlist", function(){
	var roomlist = $("#roomlist option:selected").text(); //option값 가져오기
	var roomlist1 = $("#roomlist").val(); //value에서 typecode 가져오기
	var pk = String(roomlist1).split(" "); //typecode를 가져오기 위해 split
	var typecode = parseInt(pk[1]); //int로 타입변환
	var list = String(roomlist).split(","); //option에서 가져온 값들 배열로 슬라이싱
	/* var checkin = $("#checkin").val();
	var checkout = $("#checkout").val();
	var p = checkin.split('-');
    var p1 = checkout.split('-');
    p=parseInt(p[2]);
    p1=parseInt(p1[2]);
    $('#summuch').val((p1-p)*list[3]); */
	var roomname = list[0];
	var roomtype = list[1];
	var howmany = list[2];
	var howmuch = list[3];
	
	$("#roomname").val(roomname);
	$("#howmany").val(howmany);
	$("#howmuch").val(howmuch);
  
    let checkin = $('#checkin').val();
    let checkout = $('#checkout').val();
    $("#checkin1").val(checkin);
	$("#checkout1").val(checkout);
    console.log('checkin ['+checkin+'] checkout ['+checkout+']');
    //console.log($('#price').val());
    if(checkin == '' || checkout == '') { 
       return false;         
    }
    checkin = new Date(checkin);
    checkout = new Date(checkout);
    
    if(checkin > checkout) {
       alert('체크인 날짜가 체크아웃보다 나중 일 수 없습니다.');
       return false;
    }
    let ms = Math.abs(checkout-checkin);
    let days = Math.ceil(ms/(1000*60*60*24));
    let price = parseInt($('#howmuch').val())
    let total = days*price;

    $('#summuch').val(total);
	
    var roomcode = parseInt(pk[0]);
	$("#roomcode").val(roomcode);
	
	

	
	if(typecode==1){ //선택시 같은 type코드가 선택될수 있게 해줌. true가 선택됬다표시
		$("#roomtype1").val(1).prop("selected", true);
	} else if(typecode==2){
		$("#roomtype1").val(2).prop("selected", true);
	} else if(typecode==3){
		$("#roomtype1").val(3).prop("selected", true);
	} else if(typecode==4){
		$("#roomtype1").val(4).prop("selected", true);
	}
	
	return false;
})
.on('click','#btnAdd',function(){
	let roomcode1 = String($('#roomcode').val());
	let person=String($('#howman').val());
	let checkin=String($('#checkin').val());
	let checkout=String($('#checkout').val());
	let summuch=String($('#summuch').val());
	let name=String($('#howname').val());
	let mobile=String($('#mobile').val());
	// validation (유효성검사)
	if(roomcode1=='' || person=='' || checkin=='' || checkout=='' || summuch=='' || name=='' || mobile==''){
		alert('누락된 값이 있습니다.');
		return false;
	}
	//insert
	$.post("http://localhost:8080/app/addBooking",
	//$.post("http://localhost:8081/app/addBooking",		
			{roomcode1:roomcode1,person:person,checkin:checkin,checkout:checkout,summuch:summuch,name:name,mobile:mobile},
			function(result){
		console.log(result);
		if(result=="ok"){
			/* let str='<option>'+$('#roomname').val()+' '+$('#roomtype').val()+' '+$('#howman').val()+' / '+$('#howmany').val()+
			' '+$('#checkin').val()+' '+$('#checkout').val()+' '+$('#summuch').val()+' '+$('#howname').val()+' '+$('#mobile').val()+'</option>';
			$('#impossible_list').append(str); */
			location.reload();
		}
			
	},'text');
	return false;
})
.on("click","#btnEmpty", function(){
	$("#roomname,#roomtype1,#howman,#howmany,#checkin1,#checkout1,#howmuch,#summuch,#howname,#mobile").val("");
	return false;
})
/*.on("click","#btnDelete", function(){
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
}) */
</script>
</html>