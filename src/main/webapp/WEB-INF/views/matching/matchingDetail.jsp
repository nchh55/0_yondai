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
<link rel="stylesheet" href="/resources/assets/css/main.css" />
<script>
	/* 구글 맵용 공용변수 선언*/
	var map;
	var mapOptions;
	var markers = [];
	
	var rlat = ${request.req_x};
	var rlng = ${request.req_y};
	var rlocation = {lat: rlat, lng: rlng};
	
	var slat = ${request.supp_x};
	var slng = ${request.supp_y};
	var slocation = {lat: slat, lng: slng};
	
 	var request_flag = '${request.request_flag}';
	
	var ricon = '';
	var sicon = '/resources/images/marker/marker_blue.png';
	
	if(request_flag == 'normal'){
		ricon = '/resources/images/marker/marker_red.png';
	}else if(request_flag == 'completed'){
		ricon = '/resources/images/marker/marker_green.png';
	}else{
		ricon = '/resources/images/marker/marker_orange.png';
	}
	//////////////////////////////////////////////////////////
	
	
	$(function(){
		
		//initialize();
		initMap();
	
	})
	
	
 	//구글맵 로드
	function initMap(){
		// 맵 바탕 띄울때 옵션 (center:중심좌표 / zoom:배율)
		mapOptions = {
			center: rlocation
			,zoom: 15
		};
		map = new google.maps.Map(document.getElementById('map'), mapOptions);
		
		addMarker(rlocation, ricon);
		addMarker(slocation, sicon);
		
		setMapOnAll(map);
	} 
	
	// 배열에 마커 추가하기 
	function addMarker(location, icon) {
	    var marker = new google.maps.Marker({
	    		position: location
	    		,map: map
	    		,animation: google.maps.Animation.BOUNCE
	    		,draggable: false
	    		,icon: icon
	    });
	    markers.push(marker);
	} 
	
	// 배열에 있는 모든 마커 지도에 표시하기
    function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
    }
	
 	// 배열에 있는 모든 마커 삭제하기
	function deleteMarkers() {
		setMapOnAll(null);
	    markers = [];
	}
	
 	
 	// 두 지점간의 거리 측정하기
 	function calcDistance(p1, p2) {
	  return (google.maps.geometry.spherical.computeDistanceBetween(p1, p2));
	}
 	
</script>
<style>
	#map {
	  width: 100%;
	  height: 350px;
	}
	/* Optional: Makes the sample page fill the window. */
	html, body {
	  height: 100%;
	  margin: 0;
	  padding: 0;
	}    
</style> 
</head>
<body>
	<div class="box">
		<h2>매칭 정보(상세)</h2>
		<a href="/admin/matchingUpdate?requestseq=${request.requestseq}" class="button">매칭 수정</a>
			<form>    
				<div class="row gtr-uniform">
					<div class="col-12">
						요청 내용<input type="text" name="request_contents" value="${request.request_contents}" readonly="readonly">
					</div>
					<!--  -->
					<div class="col-4">
						요청일시<input type="text" name="request_date" value="${request.request_date}" readonly="readonly">
					</div>
					<div class="col-4">
						완료일시<input type="text" name="completion_date" value="${request.completion_date}" readonly="readonly">
					</div>
					<div class="col-4">
						요청상태<input type="text" name="request_flag" value="${request.request_flag}" readonly="readonly">
					</div>
					<!--  -->
					<div class="col-3" >
						요청자 ID<input type="text" name="userid" value="${request.userid}" readonly="readonly">
					</div>
					<div class="col-3">   
						이름<input type="text" name="username" value="${request.username}" readonly="readonly">
					</div>
					<div class="col-3">
						연락처<input type="text" name="userphone" value="${request.userphone}" readonly="readonly">
					</div>
					<div class="col-3">
						<input type="checkbox" id="dis_check" name="disabled" ${request.disabled =='YES' ?'checked' :'' } disabled="disabled">
						<label for="dis_check">장애여부</label>
					</div>
					<!--  -->
					<div class="col-3">
						지원자 ID<input type="text" name="support_id" value="${support.support_id}" readonly="readonly">
					</div>
					<div class="col-3">
						이름<input type="text" name="supprot_name" value="${support.username}" readonly="readonly">
					</div>
					<div class="col-3">
						연락처<input type="text" name="support_phone" value="${support.userphone}" readonly="readonly">
					</div>
					<div class="col-3">
						<input type="checkbox" id="dis_check" name="disabled" ${support.disabled =='YES' ?'checked' :'' } disabled="disabled">
						<label for="dis_check">장애여부</label>
					</div>
				</div>			
			</form>
	</div> 
	<div id="map"></div>
   <!-- Scripts -->
        <script src="/resources/assets/js/jquery.min.js"></script>
        <script src="/resources/assets/js/browser.min.js"></script>
        <script src="/resources/assets/js/breakpoints.min.js"></script>
        <script src="/resources/assets/js/util.js"></script>
        <script src="/resources/assets/js/main.js"></script>
		
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOtVk3O8rzFAXRss8SE0LUODSpFy9tiL8&libraries=geometry&sensor=false"></script>
	    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
	    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOtVk3O8rzFAXRss8SE0LUODSpFy9tiL8&callback=initMap"></script>
</body>
</html>