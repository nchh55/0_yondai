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

	var map;
	var markers = [];
	
	$(function(){
		
		var rlat = ${request.request_location};
		var rlng = ${request.support_location};
		var rlocation = {lat: rlat, lng: rlng};
		
		map = new google.maps.Map(document.getElementById('map'), {
	    	zoom: 16,
	    	center: rlocation
	  	});
		
		var icon = '';
		
		if(${request.request_flag == '일반'}){
			icon = 'resources/images/marker/marker_green.png';
		}else if(${request.request_flag == '처리중'}){
			icon = 'resources/images/marker/marker_orange.png';
		}else{
			icon = 'resources/images/marker/marker_red.png';
		}
		
		addMarker(rlocation, icon);
	 	//initMap();
	})

	function addMarker(rlocation, icon) {
	    var marker = new google.maps.Marker({
	    		position: rlocation,
	    		map: map,
	    		animation: google.maps.Animation.BOUNCE,
	    		draggable: false,
	    		icon: icon
	    });
	   		
	    	markers.push(marker);
	    	
	    	setMapOnAll(map);
	} 
	
    function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
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
			<form>
				<div class="row gtr-uniform">
					<div class="col-12 xsmall">
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
					<div class="col-3">
						요청자 ID<input type="text" name="userid" value="${request.userid}" readonly="readonly">
					</div>
					<div class="col-2">
						이름<input type="text" name="username" readonly="readonly">
					</div>
					<div class="col-3">
						연락처<input type="text" name="userphone" readonly="readonly">
					</div> 
					<div class="col-4">
						<c:if test="${request.disabled == 'YES'}">
							<input type="checkbox" name="disabled" value="${request.disabled}" checked="checked" readonly="readonly">장애여부
						</c:if>
						<c:if test="${request.disabled != 'YES'}">
							<input type="checkbox" name="disabled" value="${request.disabled}"	readonly="readonly">장애여부					
						</c:if>
						<c:if test="${request.pregnancy == 'YES'}">
							<input type="checkbox" name="pregnany" value="${request.disabled}" checked="checked" readonly="readonly">임신여부
						</c:if>
						<c:if test="${request.pregnancy != 'YES' }">
							<input type="checkbox" name="pregnany" value="${request.disabled}" readonly="readonly">임신여부
						</c:if>
					</div>
					<!--  -->
					<div class="col-3">
						지원자 ID<input type="text" name="support_id" readonly="readonly">
					</div>
					<div class="col-2">
						이름<input type="text" name="supprot_name" readonly="readonly">
					</div>
					<div class="col-3">
						연락처<input type="text" name="support_phone" readonly="readonly">
					</div> 
				</div>			
			</form>
	</div>
	<div id="map"></div>
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