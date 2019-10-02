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
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
	.content {
		text-align: center;   
	}
	.wrraper-wrong{
		display: inline-flex;      
		margin: 0 auto;
	}
	.wrong-contents{
		font-family: 'Noto Sans KR', sans-serif;
		margin-left: 50px; 
		font-weight: 100;
		font-size: 4em;   
	}
	.wrong-content1{
		display: flex; 
		text-align: center; 
		margin-left: 54px;       
	}
	.point{ 
		color: #5c9adc;
	}    
	.wrong-explanation, .gohome{
		margin-top: 20px;
	}
	.button:hover {     
	    border-bottom-color: #595a5c;
	    color: #5c9adc !important;     
	}
</style> 
<script> 
   //신고하기      

$(function(){
   $("#report").on("click", report);
   });   
   function report(){
   alert("신고하기"); 
   $(".content").load("resources/report2.jsp");         
   } 

   </head> 
   </script>   
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

                     <!-- Content --> 
                        <section id="banner">
                           <div class="content">   
                              <header>
                              <div class="wrraper-wrong">   
	                              <div>
		                           <span class="image object">    
		                              <img src="images/ban.png" alt="ban.png" style="width: 175px;height: 175px;"/> 
		                           </span> 
		                          </div>          
	                              <div class="wrong-contents"> 
										<div class="wrong-content1"> 
											<div class="point">페이지 경로</div>
											<div>가</div>   
										</div>
							            <div>올바르지 않습니다.</div>   
	                              </div>         
                              </div>
                              </header>
                              <div class="wrong-explanation"> 
	                              <div>주소가 잘못 입력되었거나 변경 또는 삭제되어 요청하신 페이지를 찾을 수 없습니다.</div>
								  <div>입력하신 주소를 다시 한 번 확인해 주시기 바랍니다.</div>
							  </div>
							  <a href="/index" class="button gohome">홈으로 이동</a>
                           </div> 
                        </section> 
                           <hr class="major" />    
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