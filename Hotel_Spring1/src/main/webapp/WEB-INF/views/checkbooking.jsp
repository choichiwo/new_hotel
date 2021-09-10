<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.ready(function() {
	$.post("http://localhost:8080/app/checkbooking",{},function(result){ 
		//$.post("http://localhost:8081/app/getgetBooking",{},function(result){
				$.each(result,function(ndx,value){
					str='<option value="'+value['bookcode']+' '+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+value['typename']+','+value['person']+','+value['howmany']+','+value['summuch']+','
					+value['checkin']+','+value['checkout']+','+value['name']+','+value['mobile']+'</option>';
					$("#impossible_list").append(str);
				});
		},"json");	
})
</script>
</html>