<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
<title>TASUKETE - YONDAI</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/assets/css/main.css" />
<script>

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
                     </header>
                                                         
                  <!-- Section -->
                  <section>   
                  <!-- Form --> 
                  <div class="box">                                     
                     <h2>공지사항</h2>  
                     	<form method="POST" action="noticeWrite">
                        	<div class="row gtr-uniform">
                        	    <div class="col-1"></div>  
                        	    <div class="col-10">   
                             		제목<input type="text" name="notice_title" id="notice_title" />
                           		</div>
                           		<div class="col-1"></div>
                           		<!--  -->
                        		<div class="col-1"></div>
                        	    <div class="col-3">    
                              		작성자(ID)<input type="text" name="userid" id="userid" value="admin" readonly="readonly" /> 
                          		</div>
                       	    	<div class="col-3">      
                             		작성일자<input type="text" name="notice_date" id="notice_date" value="<fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/>" readonly="readonly" />
                           		</div>
                          		<div class="col-5"></div>
                        	    <!--  -->

                           		<div class="col-1"></div>
                           		<div class="col-10">   
                              		내용<textarea name="notice_contents" id="notice_contents" rows="10"></textarea>
                          		</div>
                          		<div class="col-1"></div>
                          		<!--  -->
                          		<div class="col-7"></div>
                           		<div class="col-3">
                              		<ul class="actions">
                                 		<li><input type="submit" value="등록하기" class="primary" /></li>
                                 		<li><a href="noticeList" class="button">목록으로</a></li>
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
                            <a href="index2"><h2>Need Of Help</h2></a> 
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
                                       <li><a href="#">블랙리스트 관리</a></li>
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
                              <li><a href="suggestion">건의하기</a></li>
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
</html>