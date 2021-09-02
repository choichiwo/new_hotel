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
                        <th>숙박기간</th>
                        <td><input type="date">~<input type="date"></td>
                    </tr>
                    <tr>
                        <th class="bunlyu">객실분류</th>
                        <td>
                            <select name="possible_day" id=""> 
                                <option value="" selected>객실을 선택해 주세요.</option>
                                <option value="Suite Room">Suite Room</option>
                                <option value="Family Room">Family Room</option>
                                <option value="Double Room">Double Room</option>
                                <option value="Single Room">Single Room</option>
                                <option value="Domitory">Domitory</option>
                            </select> <br>
                                <input type="button" value="찾기">
                        </td>
                    </tr>
                </table>
                <div class="possible_list">
                        <h2>예약가능</h2>
                            <select size="7" name="pref" multiple>
                                <option value="" selected>객실을 선택해 주세요.</option>
                                <option value="Suite Room">Suite Room</option>
                                <option value="Family Room">Family Room</option>
                                <option value="Double Room">Double Room</option>
                                <option value="Single Room">Single Room</option>
                                <option value="Domitory">Domitory</option>
                                </select>
                </div><!-- possible_list -->
            </div><!-- space -->


            <div class="choicesystem">
                <div class="room_choice">
                    <table class="choices">
                        <tr>
                            <th>객실이름</th>
                            <td><input type="text" name="roomname" id="roomname" size="20"></td>
                        </tr>
                        <tr>
                            <th class="bunlyu">숙박기간</th>
                            <td><input id="bunlyu" type="date">~<input type="date">(N박)</td>
                        </tr>
                        <tr>
                            <th>숙박가능인원</th>
                            <td><input type="number" name="a1" id="a1" size="20">명</td>
                        </tr>
                        <tr>
                            <th>1박비용</th>
                            <td><input type="text" name="a1" id="a1" size="20">원</td>
                        </tr>
                        <tr>
                            <th>총 숙박비</th>
                            <td><input type="text" name="a1" id="a1" size="20">원</td>
                        </tr>
                        <tr>
                            <th>예약자 모바일</th>
                            <td><input type="text" name="a2" id="a2" size="20"></td>
                        </tr>
                    </table>
                </div><!-- loom_choice -->
                <div class="btns">
                    <input type="reset" value="등록" class="btn btn-check">
                    <input type="submit" value="삭제" class="btn btn-delete">
                    <input type="submit" value="초기화" class="btn btn-clear">
                </div><!-- btns -->
            </div><!-- choicesystem -->


            <div class="impossible_list">
                <h2>예약불가능</h2>
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
</script>
</html>