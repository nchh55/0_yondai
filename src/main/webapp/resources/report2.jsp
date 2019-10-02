<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<script>
//건의하기
$(function(){	
	
	$("#confirm").on("click", confirm);
});	
function confirm(){
	alert("신고완료!");  
		
} 	
</script>
</head>
<body>
<h2>신고하기</h2>
<form method="post" action="report">
	<div class="row gtr-uniform">
		<div class="col-12">	
			<input type="text" name="userid" id="userid"  value="${sessionScope.loginId}" readonly="readonly" />
		</div>
		<div class="col-12">	
			<input type="text" name="report_title" id="report_title" value="" placeholder="제목" /> 
		</div>
		<div class="col-12">	 
			신고일시 : <input type="date" name="report_date" id="report_date" value="" placeholder="date" />
		</div>     
		<!-- Break --> 
		<div class="col-12">
			<textarea name="report_contents" id="report_contents" placeholder="신고내용" rows="6"></textarea>
		</div>
		<!-- Break -->
		<div class="col-12">
			<ul class="actions">
				<li><a href="#" id="confirm"><input type="submit" value="신고접수" class="primary" /></a></li>
				<li><input type="reset" value="취소" /></li>
			</ul>
		</div>
	</div>  
</form> 
</body>
</html>