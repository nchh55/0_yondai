<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE HTML>
<html>
<head>
<title>TASUKETE - YONDAI</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="resources/assets/css/main.css" /> 
<script>


</script>
<style>
	/* Always set the map height explicitly to define the size of the div
	 * element that contains the map. */
	#map {
	  height: 100%;
	}
	/* Optional: Makes the sample page fill the window. */
	html, body {
	  height: 100%;
	  margin: 0;
	  padding: 0;
	}
</style>
</head>
<body class="is-preload">

   <!-- Wrapper -->
      <div id="wrapper">

         <!-- Main -->
            <div id="main">
               <div id="map" class="inner"></div>
            </div>

         <!-- Sidebar -->
            <div id="sidebar">
               <div class="inner">

                  <!-- Section -->
                     <section>
                        <header class="major">
                           <a href="index"><h2>Need Of Help</h2></a> 
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
                                 <li><a href="matchingList" id="matchingMgmt">매칭 관리</a></li>
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
                     
                  <!-- Section -->

                  <!-- Footer -->
                  
               </div>
            </div>
      </div>

   <!-- Scripts -->
         <script src="assets/js/jquery.min.js"></script>
         <script src="assets/js/browser.min.js"></script>
         <script src="assets/js/breakpoints.min.js"></script>
         <script src="assets/js/util.js"></script>
         <script src="assets/js/main.js"></script>
		 <script>
		      function initMap() {
		
		        var map = new google.maps.Map(document.getElementById('map'), {
		          zoom: 3,
		          center: {lat: -28.024, lng: 140.887}
		        });
		
		        // Create an array of alphabetical characters used to label the markers.
		        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		
		        // Add some markers to the map.
		        // Note: The code uses the JavaScript Array.prototype.map() method to
		        // create an array of markers based on a given "locations" array.
		        // The map() method here has nothing to do with the Google Maps API.
		        var markers = locations.map(function(location, i) {
		          return new google.maps.Marker({
		            position: location,
		            label: labels[i % labels.length]
		          });
		        });
		
		        // Add a marker clusterer to manage the markers.
		        var markerCluster = new MarkerClusterer(map, markers,
		            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
		      }
		      var locations = [
		        {lat: -31.563910, lng: 147.154312},
		        {lat: -33.718234, lng: 150.363181},
		        {lat: -33.727111, lng: 150.371124},
		        {lat: -33.848588, lng: 151.209834},
		        {lat: -33.851702, lng: 151.216968},
		        {lat: -34.671264, lng: 150.863657},
		        {lat: -35.304724, lng: 148.662905},
		        {lat: -36.817685, lng: 175.699196},
		        {lat: -36.828611, lng: 175.790222},
		        {lat: -37.750000, lng: 145.116667},
		        {lat: -37.759859, lng: 145.128708},
		        {lat: -37.765015, lng: 145.133858},
		        {lat: -37.770104, lng: 145.143299},
		        {lat: -37.773700, lng: 145.145187},
		        {lat: -37.774785, lng: 145.137978},
		        {lat: -37.819616, lng: 144.968119},
		        {lat: -38.330766, lng: 144.695692},
		        {lat: -39.927193, lng: 175.053218},
		        {lat: -41.330162, lng: 174.865694},
		        {lat: -42.734358, lng: 147.439506},
		        {lat: -42.734358, lng: 147.501315},
		        {lat: -42.735258, lng: 147.438000},
		        {lat: -43.999792, lng: 170.463352}
		      ]
		    </script>
		    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
		    </script>
		    <script async defer
		    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOtVk3O8rzFAXRss8SE0LUODSpFy9tiL8&callback=initMap">
		    </script>
   </body>
</html>