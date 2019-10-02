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
<link rel="stylesheet" href="/resources/assets/css/main.css" /> 
<script>    
         
	$(function(){ 
		var deniedMsg = '${deniedMsg}';
		if(deniedMsg != '') {
			alert(deniedMsg);
		}
		    
		$("#noticeSearchBtn").on("click", noticeSearch);
		
	})

 	function noticeSearch(){
		var form = $("#notice_searchForm");
		form.submit();
	}
	
	
	//신고하기
	$(function(){		 
	$("#report").on("click", report);
	});	
	function report(){
	alert("신고하기"); 
	$(".content").load("/resources/report2.jsp");         		
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
									<a href="index" class="logo"><strong>TASUKETE</strong> Help Communication</a>
									<sec:authorize access="isAuthenticated()">
									<ul class="icons">
									<li><a href="#" id="report" class="button large">신고하기</a></li>  
									</ul>
									</sec:authorize>
								</header>

							<!-- Banner -->
								<section id="banner">
								<div class="content">
									<header class="major">
										<h2>공지사항</h2>
									</header>
									<!-- 검색 : 첫화면 -->
									<div class="col -6">
										<form id="notice_searchForm" action="noticeList" method="GET">
							 			<select name="searchItem">
								 			<option value="notice_title" ${searchItem =='notice_title'?'selected' :'' }>제목</option>
								 			<option value="notice_contents" ${searchItem =='notice_contents'?'selected' :'' }>내용</option>
 										</select>
											<input type="text" name="searchWord">
											<button id="noticeSearchBtn" type="button">검색</button>
										</form>
									</div>
									<div id="user_table">
										<table>
										<tr>
											<th>NO</th>
											<th colspan="3">제목</th>
											<th>작성자</th>
											<th>작성일자</th>
										</tr>
										<!-- 게시글이 없는 경우 -->
										<c:if test="${empty list}">
										<tr>
											<td colspan="6" align="center">데이터가 없습니다.</td>
										</tr>
										</c:if>
										
										<!-- 게시글이 있는 경우 -->
										<c:if test="${not empty list }">
											<c:forEach var="notice" items="${list}" varStatus="stat">
												<tr>
													<td>${stat.count+(currentPage-1)*countPerPage}</td>
													<td colspan="3"><a href="/noticeDetail?noticeseq=${notice.noticeseq}">${notice.notice_title}</a></td>
													<td>${notice.userid}</td>
													<td>${notice.notice_date}</td>
												</tr>
											</c:forEach>
										</c:if>
										</table>
										<!-- Paging 시작 -->
										<div class="text-center">
											<ul class="pagination">
												<li><a href="#">◀</a></li>
												<li><a href="noticeList?currentPage=${currentPage == '1' ? currnetPage : currentPage-1 }&searchItem=${searchItem}&searchWord=${searchWord}">◁</a></li>
												<c:forEach var="page" begin="1" end="${totalPages}">
													<li><a class="page active" href="noticeList?currentPage=${page}&searchItem=${searchItem}&searchWord=${searchWord}">${page}</a></li>
												</c:forEach>
												<li><a href="noticeList?currentPage=${currentPage == totalPages ? currentPage : currentPage+1}&searchItem=${searchItem}&searchWord=${searchWord}">▷</a></li>
												<li><a href="#">▶</a></li>
											</ul>
										</div>
										<!-- Paging 끝 -->
										<div>
											<a href="/admin/noticeWrite" class="button">글쓰기</a>
										</div>
									</div>
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
</html>