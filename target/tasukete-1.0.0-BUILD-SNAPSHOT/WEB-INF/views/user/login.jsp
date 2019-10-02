<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Editorial by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="resources/assets/css/main.css" />
<script>
		function login() {
			var userid = document.getElementById("userid");
			var userphone = document.getElementById("userphone");
			if (userid.value == '' || userphone.value.length == 0) {
				alert('ID와 핸드폰번호를 입력하세요.');
				userid.focus();
				return; 
			}
			document.getElementById("home").submit();
		
		}
</script>   
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							<!-- Header -->
								<header id="header">
									<a href="index.html" class="logo"><strong>Editorial</strong> by HTML5 UP</a>
									<c:if test="${sessionScope.loginId != null }">
									<ul class="icons">
									<li><a href="#" id="report" class="button large">신고하기</a></li>  
									</ul>
									</c:if>
								</header>
						
							<!-- form --> 
							<br>   
							<c:if test="${sessionScope.loginId == null }"> 
								<h2>로그인</h2><div style="color:red;">${message}</div>  		 					
								<form id="home" method="post" action="login">
									<div class="row gtr-uniform">
										<div class="col-7">     
											<input type="text" name="userid" id="userid" value="" placeholder="아이디" /> 
																					  
										</div>   
										 
										<div class="col-7">      
										<input type="password" name="userphone" id="userphone" value="" placeholder="핸드폰번호" />
										</div>
										
										<!-- Break -->
										<div class="col-12">
											<ul class="actions">
												<li><input type="button" value="로그인" class="primary" onclick = "login();"/></li> 
												<li><a href="signup" class="button big">회원가입</a></li>										
											</ul>
										</div>
									</div>
								</form> 
							</c:if>													
							<c:if test="${sessionScope.loginId != null }"> 
							<section id="banner">
									<div class="content">
										<header>
											<h1>We want help you.<br />
											by YONDAI Company.</h1>
										</header>
										<p>웹과 앱을 연동하여 어디에서든지 간편하게 도움을 요청하고 도움을 제공할 수 있는 커뮤니티입니다. <br>자신이 현재까지 요청한 목록을 볼 수 있으며 불편한 점이 있다면 24시간 언제든지 민원을 넣어서 개선시킬수 있습니다.<br>도움을 받은분들에게 평점을 주어서 실시간으로 좋은 요청자를 선별할 수 있고 가고싶은 지역의 주변 편의시설을 지도를 통해 간편하게 확인할 수 있습니다.</p>
										<ul class="actions">
											<li><a href="#" class="button big">Learn More</a></li>
										</ul>
									</div>
									<span class="image object"> 
										<img src="images/2.png" alt="" /> 
									</span>
								</section> 
							</c:if> 
								 
						<!-- 		<section id="banner">
  									
								</section> -->

							
							<!-- Section -->
								<section>   
									<div class="posts">  
									</div>									
								</section>
						</div>
					</div>
					

				<!-- Sidebar -->
					<div id="sidebar">
						<div class="inner">

							<!-- Section -->
								<section>
									<header class="major">
										<a href="index"><h2>Need Of Help</h2></a> 
									</header>
									<c:if test="${sessionScope.loginId == null }">								
											<a href="login" class="button fit">로그인</a>  
									</c:if>
									<c:if test="${sessionScope.loginId != null }">
										<div class="mini-posts">
											<article> 
												<h3>${sessionScope.loginName} 님 환영합니다!!</h3>   
											</article>   
										</div>
										<ul class="actions">
											<li>
												<a href="userDetail?userid=${sessionScope.loginId}" class="button">회원정보</a>
												<a href="logout" class="button">로그아웃</a>
											</li>
										</ul>
									</c:if>	
								</section>

							<!-- Menu -->
								<nav id="menu">
	                           <header class="major">
	                              <h2>메뉴</h2>
	                           </header> 
	                           <ul>
	                              <c:if test="${sessionScope.loginId == 'admin'}">
	                                 <li><a href="noticeList">공지 관리</a></li>
	                                 <li>
	                                    <span class="opener">회원 관리</span>
	                                    <ul>
	                                       <li><a href="userList">회원정보 관리</a></li>
	                                       <li><a href="blackList">블랙리스트 관리</a></li>
	                                    </ul>
	                                 </li>                              
	                                 <li><a href="#" id="matchingMgmt">매칭 관리</a></li>
	                                 <li><a href="#" id="matchingStats">매칭 통계</a></li>
	                                 <li><a href="#">예약 관리</a></li>
	                              </c:if>
	                              <c:if test="${sessionScope.loginId != 'admin'}">
	                              <li><a href="noticeList">공지사항</a></li>
	                              <c:if test="${sessionScope.loginId != null}">
	                              <li><a href="request">요청목록</a></li>   
	                              </c:if>                           
	                              <li><a href="#">칭찬하기</a></li>
	                              <li><a href="suggestionList">건의하기</a></li>
	                              <li><a href="#">편의시설</a></li>
	                              </c:if>     
	                           </ul>
	                        </nav>
							
							<!-- Search -->       
								<section id="search" class="alt">
									<form method="post" action="#">
										<input type="text" name="query" id="query" placeholder="Search" />
									</form>
								</section>								
								
							<!-- Section -->
								<section>
									<header class="major">
										<h2>Get in touch</h2>
									</header>
									<p>Sed varius enim lorem ullamcorper dolore aliquam aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin sed aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
									<ul class="contact">
										<li class="icon solid fa-envelope"><a href="#">information@untitled.tld</a></li>
										<li class="icon solid fa-phone">(000) 000-0000</li>
										<li class="icon solid fa-home">1234 Somewhere Road #8254<br />
										Nashville, TN 00000-0000</li>
									</ul>
								</section>

							<!-- Footer -->
								<footer id="footer">
									<p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
								</footer>
						</div>
					</div>
			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
