<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE HTML>
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
                     <a href="index" class="logo"><strong>TASUKETE</strong> Help Communication</a>
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
									<pre>${suggestion.suggestion_contents }</pre>
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
									<pre>${suggestion.suggestion_result }</pre>
								</td>
							</tr> 
							<tr>
								<th>
									<sec:authorize access="hasRole('ROLE_USER')">
										<a href="suggestionList" id="back" class="button small">목록으로</a>
										<a href="suggestionDelete?suggestionseq=${suggestion.suggestionseq}" class="button small">삭제</a> 
										<a href="suggestionUpdate?suggestionseq=${suggestion.suggestionseq}" class="button small">수정</a>
									</sec:authorize>
									<sec:authorize access="hasRole('ROLE_ADMIN')">
										<a href="suggestionList" id="back" class="button small">목록으로</a>
										<a href="suggestionDelete?suggestionseq=${suggestion.suggestionseq}" class="button small">삭제</a> 
										<a href="suggestionUpdate?suggestionseq=${suggestion.suggestionseq}" class="button small">수정</a>
									</sec:authorize>
                           		</th>
                           	</tr>
                        </table>
                     </div>                     
                  </section>
               <!-- 댓글 칸 -->
                  <form method="post" action="suggreply">
                     <div class="row gtr-uniform">
                     
                     <div class="col-2"><input type="text" name="userid" id="userid" value="${suggestion.userid}" readonly="readonly" /></div>
                     <div class="col-8">
                     <textarea name="suggreply_contents" id="suggreply_contents" placeholder="개인정보를 공유 및 요청하거나, 명예 회손, 무단 광고, 불법 정보 유포시 모니터링 후 삭제될 수 있으며, 이에 대한 민형사상 책임은 게시자에게 있습니다." rows="3"></textarea>
                     <!-- <input type="text" name="suggreply_date" id="suggreply_date"  /> -->
                     <input type="hidden" name="suggestionseq" id="suggestionseq" value="${suggestion.suggestionseq}"/>
                     </div> 
                     <div class="col-2"></div>    
                     
                     <div class="col-9"></div>
                     <div class="col-1">
                     <input type="submit" value="입력" class="small primary button" />   
                     </div>
                     <div class="col-2"></div>
                     
                     </div>   
                     <!-- security -->
					 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                  </form>      
               <!-- 댓글 목록    -->   
                     <div class="row gtr-uniform">
                     <div class="col-10" id ="${reply.replyseq}">
                     <c:if test="${not empty suggreply }">
                     <c:forEach var="suggreply" items="${suggreply}">
                     <ul class="alt" >  
                       
                     <li><h4>${suggreply.userid}</h4>   
                     <div><a>${suggreply.suggreply_contents}</a></div> 
                     <div><sub>${suggreply.suggreply_date}  
                                          
                     
               <!-- 댓글삭제 -->
                  <div style="float:right;"> 
               <c:if test="${suggreply.userid==sessionScope.loginId}">                      
                        <form action="deleteSuggreply" method="post">
                           <input type="hidden" value="${suggestion.suggestionseq}" name="suggestionseq" />
                           <input type="hidden" value="${suggreply.suggreplyseq}" name="suggreplyseq"  />                   
                           <input type="submit" class="small button" value="x" />
                        </form>                          
                     </c:if>                        
                  </div>
                  
                     </sub></div>       
                     </li>                         
                     <li>
                     
                     
                     <ul><%-- <c:forEach var="sugrereply" items="${sugrereply}"> --%>
                     <li>
                      
                     <form method="post" action="sugrereply">
                     <input type="text" name="userid" id="userid" value="${suggreply.userid}" readonly="readonly" />
                     <textarea name="sugreplyre_contents" id="sugreplyre_contents" ></textarea>
                     <input type="hidden" name="suggreplyseq" id="suggreplyseq" value="${suggreply.suggreplyseq}"/>
                     </form>
                          
                     </li><%-- </c:forEach> --%>
                     </ul>      
                     </li>                         
                     <li></li>         
                     
                     
                     </ul>                  
                     </c:forEach>  
                      </c:if>
                     </div> 
                      
                     <div class="col-2">                     
                     </div>                       
                     </div>   
                     
                     <div class="row gtr-uniform">
                     <div class="col-2"></div>
                     <div class="col-10"></div>
                     
                     </div>
                     
                     
                  <c:if test="${empty suggreply}">      
                     <ul>
                     <li>댓글이 없습니다.</li> 
                     </ul>   
                  </c:if>                                  
                                    
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
      <!-- <script src="assets/js/jquery.min.js"></script> -->
      <script src="assets/js/browser.min.js"></script>
      <script src="assets/js/breakpoints.min.js"></script>
      <script src="assets/js/util.js"></script>
      <script src="assets/js/main.js"></script>
      
</body>