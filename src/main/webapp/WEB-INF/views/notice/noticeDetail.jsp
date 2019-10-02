<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE HTML>
<html>
<head>
<title>TASUKETE - YONDAI</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/assets/css/main.css" />
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

   <!-- Wrapper -->
      <div id="wrapper">

         <!-- Main -->
            <div id="main">
               <div class="inner">

                  <!-- Header -->
                     <header id="header">
                        <a href="index" class="logo"><strong>TASUKETE</strong> Help Communication</a>
                       
						<ul class="icons">
						<li><a href="#" id="report" class="button large">신고하기</a></li>  
						</ul>
						
                     </header>
                                                         
                  <!-- Section -->
                  <section>   
                  <!-- Form --> 
                  <div class="box">                                     
                     <h2>공지사항</h2>  
                     	<form id="noticeDetailForm" method="GET" action="/admin/noticeUpdate">
                        	<div class="row gtr-uniform">
                        		<div class="col-1">
                        			<input type="hidden" name="noticeseq" id="noticeseq" value="${noticeseq}">
                        		</div>
                        	    <div class="col-3">    
                              		작성자(ID)<input type="text" name="userid" id="userid" value="${userid}" readonly="readonly" /> 
                          		</div>
                       	    	<div class="col-3">      
                             		작성일시<input type="text" name="notice_date" id="notice_date" value="${notice_date}" readonly="readonly" />
                           		</div>
                          		<div class="col-5"></div>
                        	    <!--  -->
                        	    <div class="col-1"></div>  
                        	    <div class="col-10">   
                             		제목<input type="text" name="notice_title" id="notice_title" value="${notice_title}" readonly="readonly"/>
                           		</div>
                           		<div class="col-1"></div>
                           		<!--  -->
                           		<div class="col-1"></div>
                           		<div class="col-10">   
                              		내용<textarea name="notice_contents" id="notice_contents" rows="10" readonly="readonly" style="resize: none;">${notice_contents}</textarea>
                          		</div>
                          		<div class="col-1"></div>
                          		<!--  -->
                          		<div class="col-7"></div>
                           		<div class="col-3">    
                              		<ul class="actions">
                                 		<li><a href="/admin/noticeUpdate?noticeseq=${noticeseq}" class="button primary">수정하기</a></li>
                                 		<li><a href="/noticeList" class="button big">목록으로</a></li>
                              		</ul>
                           		</div>
                           		<div class="col-1"></div>
                        	</div>  
                     	</form>
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
                                 <a href="/login?chk=1" class="button fit">로그인</a>  
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
                                    <li><a href="/suggestionList">건의 관리</a></li>
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
