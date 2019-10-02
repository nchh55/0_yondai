<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>유저화면</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="assets/css/main.css" />
        
<script>
	//신고하기
	$(function(){		 
	$("#report").on("click", report);
	});	
	function report(){
	alert("신고하기"); 
	$(".content").load("resources.report2.jsp");         	
}

</script>
</head>
<body class="is-preload">
	<div id="wrapper">
		<!-- Main -->
			<div id="main">
				<div class="inner">

					<!-- Header -->
						<header id="header">
							<a href="index.html" class="logo"><strong>Editorial</strong> by HTML5 UP</a>
							<ul class="icons">
								<li><a href="#" id="report" class="button large">신고하기</a></li>  
							</ul>
						</header>

					<!-- Banner -->
						<section id="banner">
							<div class="table-wrapper">
							<h2>건의 글 자세히 보기</h2>
								<table>
									<tr>
										<th>제목</th>
										<td> ${suggestion.suggestion_title}</td>
									</tr>
									<tr>
										<th>회원아이디</th>
										<td>${suggestion.userid}</td>
									</tr>
									<tr>
										<th>접수일시</th>
										<td>${suggestion.reception_date }</td>
									</tr>
									<tr>
										<th>건의내용</th>
										<td>
										<pre>${suggestion.suggestion_contents }
										</pre>
										</td>
									</tr>
									<tr>
										<th>처리일시</th>
										<td>${suggestion.completion_date }</td>
									</tr>
									<tr>
										<th>진행상태</th>
										<td>${suggestion.progress_flag }</td>
									</tr>
									<tr>
										<th>건의결과</th>
										<td>
										<pre>
										${suggestion.suggestion_result }
										</pre></td>
									</tr> 
									<tr> 
										<th>
											<a href="suggestionList" id="back" class="button small">목록으로</a>
											<a href="suggestionDelete?suggestionseq=${suggestion.suggestionseq}" class="button small">삭제</a> 
											<a href="suggestionUpdate?suggestionseq=${suggestion.suggestionseq}" class="button small">수정</a> 
										</th>
									</tr>
								</table>
							</div>		 						
						</section>

					<!-- Section -->
						<section>
							<div class="features">
								
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
					<div class="mini-posts">
						<article> 
							<h3>${sessionScope.loginName} 님 환영합니다!!</h3>   
						</article>   
					</div>
					<ul class="actions">
						<li>
							<a href="#" class="button">회원정보</a>
							<a href="logout" class="button">로그아웃</a>
						</li>
					</ul>
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
	                              <li><a href="compliment">칭찬하기</a></li>
	                              <li><a href="suggestionList">건의하기</a></li>
	                              <li><a href="notice">편의시설</a></li>
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
		<!-- <script src="assets/js/jquery.min.js"></script> -->
		<script src="assets/js/browser.min.js"></script>
		<script src="assets/js/breakpoints.min.js"></script>
		<script src="assets/js/util.js"></script>
		<script src="assets/js/main.js"></script>
		
</body>
