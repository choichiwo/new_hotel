<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<h1>회원가입</h1><hr>
<form method="POST" action="join">
	이름 : <input type=text name=username required><br>
	아이디 : <input type=text name=userid required><br>
	비밀번호 : <input type=password name=passcode1 required><br>
	비밀번호 확인 : <input type=password name=passcode2 required><br>
	핸드폰 번호 : <input type=text name=mobile required><br>
	<input type="submit" id="btnInput" value="등록">
	<button value="취소" onclick="location.href='home'">취소</button>
</form>
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