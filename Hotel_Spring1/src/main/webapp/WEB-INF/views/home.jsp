<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1 style="text-align: center">
	Hotel Manager Home 
</h1><hr>
<div style="text-align: center">
<form method="POST" action="/app/check_user">
	ID : <input type=text name=userid required><br>
	PW : <input type=text name=userpw required><br>
	<input type=submit value="로그인">	
</form></div>
<h3 style="text-align: center"><a href="newbie">회원가입</a></h3>
</body>
</html>