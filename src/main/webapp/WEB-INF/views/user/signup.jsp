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
		var flag = false;
		$(function(){
			
			$("#checkid").on('click',function(){
				if (userid.value.length == 0){
					alert("아이디를 입력해 주세요.");
					falg = false;
					return false;
				}   
				$.ajax({
					type : 'get'
					, url : '/idCheck'
					, data : {userid : $("#userid").val()}
					, success : function(result){
						if(result == "success"){
							alert("사용가능한 아이디입니다");
							flag = true;
						}else{
							alert("중복되는 아이디 입니다");
							flag = false;
						}
					}
				}); 
			});
			
		
		});
		
		function sign() {
			var userid = document.getElementById("userid");
			var userpwd = document.getElementById("userpwd");
			var userpwd_chk = document.getElementById("userpwd_chk");
			var username = document.getElementById("username");
			var userphone = document.getElementById("userphone");
			var userbirth = document.getElementById("userbirth");
			var disabled = document.getElementById("demo-priority-low");
			var disabled2 = document.getElementById("demo-priority-normal");
			
			if(userpwd.value != userpwd_chk.value){
				alert("입력하신 비밀번호가 일치하지 않습니다");
				userpwd_chk.select();
				return false;
			}
			    
			if (userid.value == '' || username.value == '' || userphone.value == '' 
					|| userbirth.value == '' || disabled.value == ''|| disabled2.value == ''|| userpwd.value == '') {
				alert('빈칸을 확인하세요');
				return; 
			}
			
			if(flag == true){
				document.getElementById("signup").submit();
			}else{
				alert("아이디 중복검사를 해주세요");
			}
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
										<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
										<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
										<li><a href="#" class="icon brands fa-snapchat-ghost"><span class="label">Snapchat</span></a></li>
										<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
										<li><a href="#" class="icon brands fa-medium-m"><span class="label">Medium</span></a></li>
									</ul>
								</header>
																				
							<!-- Section -->
								<section>   
							<!-- Form --> 
																					
								<h2>회원가입</h2>  
								
								<form id="signup" method="post" action="signup">   
									<div class="row gtr-uniform">
										<div class="col-8">         
											아이디 <input type="text" name="userid" id="userid" value="" placeholder="ID" /> 
											<input type="button" class="button small" id="checkid" value="중복체크" style="margin-top: 5px; font-size: 100%"> 
										</div>        
										<div class="col-8">               
											비밀번호<input type="password" name="userpwd" id="userpwd" value="" placeholder="PASSWORD" style="margin-bottom: 5px;"/>
											비밀번호 확인<input type="password" name="userpwd_chk" id="userpwd_chk" value="" placeholder="CHEKC_PASSWORD"/>
										</div>     										   
										<div class="col-8">                           
											이름<input type="text" name="username" id="username" value="" placeholder="NAME" />        
										</div>
										<div class="col-8">	
											전화번호<input type="text" name="userphone" id="userphone" value="" placeholder="PHONE" /> 
										</div>
										<div class="col-5">      
											생년월일 : &nbsp<input type="date" name="userbirth" id="userbirth" value="" placeholder="BIRTH" />
										</div>									     												
										<div> 
											 장애 유무 :
											<input type="radio" id="demo-priority-low" name="disabled" value="YES" checked>
											<label for="demo-priority-low" style="margin-left: 13px">YES</label>								
											<input type="radio" id="demo-priority-normal" name="disabled" value="NO">
											<label for="demo-priority-normal">No</label> 
										</div> 										
									 
										<!-- Break -->
										<!-- <div class="col-8">
											<textarea name="remark" id="remark" placeholder="기타 특이사항" rows="6"></textarea>
										</div> --> 
										<!-- Break -->
										<div class="col-12">
											<ul class="actions">
												<li><input type="button" value="회원가입" class="primary" onclick="sign();" /></li> 
												<li><a href="login" class="button">취소</a></li> 
											</ul>   
										</div>  
									</div>  
									<!-- Security -->
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								</form>  
								
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
</html>