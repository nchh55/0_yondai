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
	
	var locations = [];

	$(function(){
	 	matching();		
	 	$(document).on("change", "#mflag", matching);
		
	})
	
	function matching(){
		var request_flag = $("#mflag").val();
		
		$.ajax({
			type:'GET'
			,url:'matchingList'
			,data: {"request_flag": request_flag}
			,success: 
				matchingList
		});
	}
	
	function matchingList(resp){
		//alert("테스트 두번째!!");
		var tag  = '<tr>'
			tag += '<th>요청일시</th>'
			tag += '<th>요청내용</th>'
			tag += '<th>ID</th>'
			tag += '<th>상태</th>'
			tag += '<th></th>'
			tag += '</tr>'
			
		$.each(resp, function(index, item){
			tag += '<tr>'
			tag += '<td>'+item.request_date+'</td>'
			tag += '<td>'
			tag += '<a href="#" onClick="matchingInfo('+item.requestseq+');">'+item.request_contents+'</a>'
			tag += '</td>'
			tag += '<td>'+item.userid+'</td>'
			tag += '<td>'+item.request_flag+'</td>'
			tag += '<td><input type="checkbox"></td>'
			tag += '</tr>'
		});
			
		$("#matchingTable").html(tag);
		
		locations = [];
		
		$.each(resp, function(index, item){
			locations.push({lat: Number(item.request_location), lng: Number(item.support_location)});
			
		});
		
		initMap();
		
	}
	
	function matchingInfo(resp){
		var requestseq = resp;		
		$.ajax({
			type: 'GET'
			,url: 'matchingDetail'
			,data: {"requestseq": requestseq}
			,success:
				matchingDetail				
		})
	}
	
	function matchingDetail(resp){
		window.open("matching/matchingDetail.jsp", "매칭 상세정보", "width=500px, height=400px")
		
	}
	
	
	//구글맵 지도 + 마커 띄우기
    function initMap() {
		
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 12,
          center: {lat: 37.551818 , lng: 126.990915}
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
				<!-- Title -->
					<section align="center">
					<a href="matchingMgmt" align="center"><h1>매칭 관리</h1></a>
					<a href="index"><button type="button">끝내기(메인으로)</button></a>
					</section>
				<!--  -->
					<section>
						<!-- 상태별 조회 -->
						<div class="row gtr-uniform">
							<div class="col-12">
								<select id="mflag" name="request_flag">
									<option value="전체" ${request_flag =='전체'?'selected' :'' }>전체</option>
									<option value="일반" ${request_flag =='일반'?'selected' :'' }>일반</option>
									<option value="처리중" ${request_flag =='처리중'?'selected' :'' }>처리중</option>
									<option value="처리완료"  ${request_flag =='처리완료'?'selected' :'' }>처리완료</option>
								</select>
							</div>
							<div class="col-8">
								<select id="searchItem" name="searchItem">
									<option value="0">자동해제</option>
									<option value="1">1분마다</option>
									<option value="5">5분마다</option>
									<option value="10">10분마다</option>
									<option value="15">15분마다</option>
								</select>
							</div>
							<div class="col-4">	
								<button type=button class="button primary small">갱신하기</button>
							</div>
						</div>
						<table id="matchingTable">
						</table>
					</section>
               </div>
            </div>
      </div>

   <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/browser.min.js"></script>
        <script src="assets/js/breakpoints.min.js"></script>
        <script src="assets/js/util.js"></script>
        <script src="assets/js/main.js"></script>

	    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
	    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOtVk3O8rzFAXRss8SE0LUODSpFy9tiL8&callback=initMap"></script>
   </body>
</html>