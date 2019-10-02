<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>  
$(function(){                       
	$("#duplicate").on('click', function(){ 
		var userid = $("#userid").val();
		if(userid.length < 3 || userid.length > 7) {
			alert("아이디는 3 ~ 7자 사이로");
			return;
		}
		if(userid.charAt(0) >= 0 && userid.charAt(0) <= 9) {
			alert("아이디는 영문자로 시작하세요");
			return;
		}
		$("#form").submit();
	});


	$("#used").on('click', function(){
		opener.document.getElementById("userid").value = 
			document.getElementById("userid").value;
		window.close();
	});
});
</script>
</head>
<body>
<div class="wrapper">
	<h2>[ 아이디 중복확인 ]</h2>
	<form id="form" action="idCheck" method="post">
		<label for="userid">
		<input type="text" name="userid" id="userid" value="${userid}" />
		</label>
		<input type="button" id="duplicate" value="중복확인"/>
	</form>
</div>
<div id="result">
	<c:if test="${not empty message}">
		<p>
			이 아이디는 사용할 수 있습니다.
			<input type="button" id="used" value="사용하기" />
		</p>
	</c:if>
	<c:if test="${empty message }">
		<p>이 아이디는 사용할 수 없습니다.</p>
	</c:if>
</div>
</body>
</html>