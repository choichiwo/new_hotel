<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<link rel="stylesheet" href="resources/home/css/Home.css">
<body>
<div class="home">
<h1 class="head">회원가입</h1>
<div class="body">
<form method="POST" action="app/join" id="log">
	이름  :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input class="box" type=text name=username required><br>
	아이디 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <input class="box" type=text name=userid required><br>
	비밀번호 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input class="box" type=password name=passcode1 required><br>
	비밀번호 확인 : <input class="box" type=password name=passcode2 required><br>
	핸드폰 번호 :&nbsp;&nbsp;&nbsp;  <input class="box" type=text name=mobile required><br>
	<input class="btn" type="submit" id="btnInput" value="등록">
	<button class="btn" value="취소" onclick="location.href='home'">취소</button>
</form>
</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on("click","#btnInput",function(){
	if($('input[name=passcode1]').val()!=$('input[name=passcode2]').val()) {
        alert("비밀번호가 맞지 않습니다.");
        return false;
	}
})	
</script>        
</html>