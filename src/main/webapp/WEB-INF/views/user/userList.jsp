<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>TASUKETE - YONDAI</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="assets/css/main.css" />
<script>

	$(function(){
		$("#userSearchBtn").on("click", userSearch);
		
	})

 	function userSearch(){
		var form = $("#user_searchForm");
		form.submit();
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
								</header>

							<!-- Banner -->
								<section id="banner">
								<div class="content">
									<header class="major">
										<h2>회원정보(전체)</h2>
									</header>
									<!-- 검색 : 첫화면 -->
									<div class="col -6">
										<form id="user_searchForm" action="userList" method="GET">
							 			<select name="searchItem">
								 			<option value="username" ${searchItem =='username'?'selected' :'' }>이름</option>
								 			<option value="userphone" ${searchItem =='userphone'?'selected' :'' }>연락처</option>
 										</select>
											<input type="text" name="searchWord">'
											<button id="userSearchBtn" type="button">검색</button>'
										</form>
									</div>
									<div id="user_table">
										<table>
										<tr>
											<th></th>
											<th>이름</th>
											<th>ID</th>
											<th>생년월일</th>
											<th>연락처</th>
											<th>장애여부</th>
											<th></th>
										</tr>
										<!-- 게시글이 없는 경우 -->
										<c:if test="${empty list}">
										<tr>
											<td colspan="7" align="center">데이터가 없습니다.</td>
										</tr>
										</c:if>
										
										<!-- 게시글이 있는 경우 -->
										<c:if test="${not empty list }">
											<c:forEach var="user" items="${list}" varStatus="stat">
												<tr>
													<td>${stat.count+(currentPage-1)*countPerPage}</td>
													<td>${user.username}</td>
													<td>${user.userid}</td>
													<td>${user.userbirth}</td>
													<td>${user.userphone}</td>
													<td>${user.disabled}</td>
													<td>
														<a href="userDetail?userid=${user.userid}" class="button">상세조회</a>
													</td>
												</tr>
											</c:forEach>
										</c:if>
										</table>
										<!-- Paging 시작 -->
										<div class="text-center">
											<ul class="pagination">
												<li><a href="#">◀</a></li>
												<li><a href="userList?currentPage=${currentPage == '1' ? currnetPage : currentPage-1 }&searchItem=${searchItem}&searchWord=${searchWord}">◁</a></li>
												<c:forEach var="page" begin="1" end="${totalPages}">
												<li><a class="page active" href="userList?currentPage=${page}&searchItem=${searchItem}&searchWord=${searchWord}">${page}</a></li>
												</c:forEach>
												<li><a href="userList?currentPage=${currentPage == totalPages ? currentPage : currentPage+1}&searchItem=${searchItem}&searchWord=${searchWord}">▷</a></li>
												<li><a href="#">▶</a></li>
											</ul>
										</div>
										<!-- Paging 끝 -->
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
</html>