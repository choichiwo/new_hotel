<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<link rel="stylesheet" href="resources/home/css/Home.css">
<body>
<div class="home">
<h1 class="head">
	Hotel Manager Home 
</h1>
<div class="body">
<form method="POST" action="/app/check_user" id="frmLogin">
	ID : <input class="do" type=text name=userid><br><br>
	PW : <input type=password name=passcode><br>
	<input class="btn" type=submit value="로그인">	
	<button type="button" class="btn" onclick="location.href='newbie'">회원가입</button>
</form>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on("submit","#frmLogin",function(){
	let userid=$.trim($('input[name=userid]').val());
	if(userid === '' ) {
        alert("아이디를 입력해주세요.");
        return false;
	} 
	let a; // "undefined"
	userpw=$.trim($('input[name=passcode]').val());
	if(userpw === '' || userpw === undefined || userpw === ' ' || userpw === null) {
        alert("비밀번호 입력해주세요.");
        return false;
	}
})	
.ready(function(){
	alert('로그인에 실패하였습니다.')
})
</script>
</html>