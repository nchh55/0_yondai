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
	$(".content").load("resources/report2.jsp");         		
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
						<div class="box">
							<div class="table-wrapper">							
								<h2>나의 요청 목록</h2>					
							<div class="row gtr-uniform">
							
							
							
								
							<div class="col-2"></div>
							<div class="col-7">
							회원의 아이디 : <input type="text" value="${request.userid}" readonly="readonly" />
							</div>
							<div class="col-3"></div>
							
							<div class="col-2"></div>
							<div class="col-7">
							지원자 아이디 : <input type="text" value="${request.support_id}" readonly="readonly" />
							</div>
							<div class="col-3"></div>
							
							<div class="col-2"></div>
							<div class="col-7">
							요청자 위치 : <input type="text" value="${request.request_location}" readonly="readonly" />
							</div>
							<div class="col-3"></div>
							
							<div class="col-2"></div>
							<div class="col-7">
							지원자 위치 : <input type="text" value="${request.support_location}" readonly="readonly" />
							</div>
							<div class="col-3"></div>
							
							<div class="col-2"></div>
							<div class="col-7">
							요청일시 : <input type="text" value="${request.request_date}" readonly="readonly" />
							</div>
							<div class="col-3"></div>
							
							<div class="col-2"></div>
							<div class="col-7">
							완료일시 : <input type="text" value="${request.completion_date}" readonly="readonly" />
							</div>
							<div class="col-3"></div>
							
							<div class="col-2"></div>
							<div class="col-7">
							장애인 여부 : <input type="text" value="${request.disabled}" readonly="readonly" />
							</div>
							<div class="col-3"></div>
							
							<div class="col-2"></div>
							<div class="col-7">
							임신 여부 : <input type="text" value="${request.pregnancy}" readonly="readonly" />
							</div>
							<div class="col-3"></div>
							
							<div class="col-2"></div>
							<div class="col-7">
							요청 상태 : <input type="text" value="${request.request_flag}" readonly="readonly" />
							</div>
							<div class="col-3"></div>
							
							<div class="col-2"></div>
							<div class="col-7">
							요청 내용 : <textarea name="remark" id="remark" placeholder="${request.request_contents}" readonly="readonly" rows="6"></textarea>
							</div>			
							<div class="col-3"></div>				
							</div>
							<a href="request" id="back" class="button">목록으로</a>								
						</div>
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
		<!-- <script src="assets/js/jquery.min.js"></script> -->
		<script src="assets/js/browser.min.js"></script>
		<script src="assets/js/breakpoints.min.js"></script>
		<script src="assets/js/util.js"></script>
		<script src="assets/js/main.js"></script>
		
</body>
