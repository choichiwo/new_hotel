<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<style>
body {
	background-image: url(../img/background.jpg);
}
</style>
<body>
<div class="home">
<h1 class="head">
	Hotel Manager Home 
</h1>
<div class="body" style="text-align: center">
<form method="POST" action="/app/check_user" id="frmLogin">
	ID : <input type=text name=userid required><br>
	PW : <input type=pessword name=passcode required><br><br>
	<input type=submit value="로그인">	
</form></div>
<h3 class="btn" style="text-align: center"><a href="newbie">회원가입</a></h3>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on("submit","#frmLogin",function(){
	let userid=$.trim($('input[name=userid]').val());
	if(userid=='') {
        alert("아이디를 확인해주세요.");
        return false;
	}
	userpw=$.trim($('input[name=passcode]').val());
	if(userpw=='') {
        alert("비밀번호가 맞지 않습니다.");
        return false;
	}
})	
</script>
</html>