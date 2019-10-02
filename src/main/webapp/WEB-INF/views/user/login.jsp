<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>TASUKETE - YONDAI</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<link rel="stylesheet" href="resources/assets/css/main.css" />
<script>
		$(function(){
			var sessionExpired = '${sessionExpired}';
			if(sessionExpired != ''){
				alert(sessionExpired);    
			}
			
			var needLogin = '${needLogin}';
			if(needLogin != ''){
				alert(needLogin);    
			}       
			  
		});
		function login() {
			var userid = document.getElementById("userid");
			var userpwd = document.getElementById("userpwd");
			if (userid.value.length == 0 || userpwd.value.length == 0) {
				alert('ID와 비밀번호를 입력하세요.');
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
                           <a href="index" class="logo"><strong>TASUKETE </strong> Help Communication</a>
                           
                           <sec:authorize access="hasRole('ROLE_USER')">
                           <ul class="icons">
                           <li><a href="#" id="report" class="button large">신고하기</a></li>  
                           </ul>
                           </sec:authorize>  
                           
                        </header>
						
							<!-- form --> 
							<br>   
							<c:if test="${sessionScope.loginId == null }"> 
								<h2>로그인</h2>
								
									<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
										<div style="color: red; margin-bottom: 20px">${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</div> 
										<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
									</c:if>   	 					
								<form id="home" method="post" action="login">  
									<div class="row gtr-uniform">
										<div class="col-7">     
											아이디 <input type="text" name="userid" id="userid" value="" placeholder="아이디" /> 
																					  
										</div>   
										 
										<div class="col-7">      
											비밀번호 <input type="password" name="userpwd" id="userpwd" value="" placeholder="비밀번호" />
										</div>   
										  
										<!-- Break -->
										<div class="col-12">
											<ul class="actions">
												<li><input type="button" value="로그인" class="primary" onclick = "login();"/></li> 
												<li><a href="signup" class="button big">회원가입</a></li>										
											</ul>
										</div>
										
									</div>
									<!-- security -->
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								</form> 
							</c:if>													
						
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
                              <a href="/index"><h2>Need Of Help</h2></a> 
                           </header>
							
						   <sec:authorize access="isAnonymous()">                     
                                 <a href="login" class="button fit">로그인</a>  
                           </sec:authorize>
                          
                           <sec:authorize access="isAuthenticated()">
                              <div class="mini-posts">     
                                 <article>                         
                                    <h3><sec:authentication property="principal.user.username"/> 님 환영합니다!!</h3>   
                                 </article>   
                              </div>   
                              <ul class="actions">
                                 <li>  
                                    <form action="/logout" method="POST">
                                    <sec:authorize access="!hasRole('ROLE_ADMIN')">
                                    	<a href="/user/userDetail?userid=<sec:authentication property="principal.user.userid"/>" class="button">회원정보</a>
                                    </sec:authorize>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<button class="button" type="submit">로그아웃</button>
						   			</form>
                                 </li>
                              </ul>
                           </sec:authorize>
                        </section>

                     <!-- Menu -->
                       <nav id="menu">
                              <header class="major">
                                 <h2>메뉴</h2>
                              </header> 
                              <ul>
                                 <sec:authorize access="hasRole('ROLE_ADMIN')">
                                    <li><a href="/noticeList">공지 관리</a></li>
                                    <li>
                                       <span class="opener">회원 관리</span>
                                       <ul>
                                          <li><a href="/admin/userList">회원정보 관리</a></li>
                                          <li><a href="#">블랙리스트 관리</a></li>
                                       </ul>
                                    </li>                              
                                    <li><a href="/admin/matchingMgmt" id="matchingMgmt">매칭 관리</a></li>
                                    <li><a href="#" id="matchingStats">매칭 통계</a></li>
                                    <li><a href="#">예약 관리</a></li>
                                 </sec:authorize>
                                                
                                 <sec:authorize access="permitAll">
                                 <sec:authorize access="!hasRole('ROLE_ADMIN')">   
                                 	<li><a href="/noticeList">공지사항</a></li>
                                 	<sec:authorize access="hasRole('ROLE_USER')">
                                 		<li><a href="/user/request">요청목록</a></li>   
                                 	</sec:authorize>                         
                                 	<li><a href="#">칭찬하기</a></li>
                                 	<li><a href="/suggestionList">건의하기</a></li>
                                 	<li><a href="#">편의시설</a></li>
                                </sec:authorize>
                                </sec:authorize>  
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
         <script src="/resources/assets/js/jquery.min.js"></script>
         <script src="/resources/assets/js/browser.min.js"></script>
         <script src="/resources/assets/js/breakpoints.min.js"></script>
         <script src="/resources/assets/js/util.js"></script>
         <script src="/resources/assets/js/main.js"></script>

	</body>
