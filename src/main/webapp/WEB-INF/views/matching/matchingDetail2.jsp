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

	var map;
	var markers = [];
	var rlat = ${request.req_x};
	var rlng = ${request.req_y};
	var rlocation = {lat: rlat, lng: rlng};
	
	var request_flag = '${request.request_flag}';
	
	var slat = ${request.supp_x};
	var slng = ${request.supp_y};
	var slocation = {lat: slat, lng: slng};
	
	var ricon = '';
	var sicon = '';
	
	$(function(){
		
/* 		console.log(p1);
		console.log(p2); */
			
		map = new google.maps.Map(document.getElementById('map'), {
	    	zoom: 15,
	    	center: rlocation
	  	});
		
		if(request_flag == '일반'){
			ricon = '/resources/images/marker/marker_red.png';
		}else if(request_flag == '처리완료'){
			ricon = '/resources/images/marker/marker_green.png';
		}else{
			ricon = '/resources/images/marker/marker_orange.png';
		}
		
		sicon = '/resources/images/marker/marker_blue.png';
		
		addMarker(rlocation, ricon);
		addMarker(slocation, sicon);
		
		setMapOnAll(map); // 기존 마커 띄우기
		
		//alert(calcDistance(p1, p2));
		
	})
	

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
	
	
    function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
        
        var p1 = new google.maps.LatLng(rlat,rlng);
        var p2 = new google.maps.LatLng(slat,slng);
        
/*         var impactCoordinates = [p1,p2];
        
       	var ImpactPath = new google.maps.Polyline({
            path: impactCoordinates,
            strokeColor: "#FF0000",
            strokeOpacity: 1.0,
            strokeWeight: 2
       	}); */
        
       	//ImpactPath.setMap(map);
    	
    	//console.log(loc1);
    	//console.log(loc2);
    	
    	alert(calcDistance(p1, p2));
    }
	
 	function calcDistance(p1, p2) {
	  return (google.maps.geometry.spherical.computeDistanceBetween(p1, p2) / 1000).toFixed(2);
	}  

</script>
<style>
	/* Always set the map height explicitly to define the size of the div
	 * element that contains the map. */
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
						요청 상태<input type="text" name="request_flag" value="${request.request_flag}" readonly="readonly">
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
		
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOtVk3O8rzFAXRss8SE0LUODSpFy9tiL8&libraries=geometry"></script>
	    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
	    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOtVk3O8rzFAXRss8SE0LUODSpFy9tiL8&callback=initMap"></script>
</body>
</html>