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
	var inter_distance;
	var support_id = '${support.support_id}';
	
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
		waitSearch();
		
		$(document).on("change", "#support_id", supp_change);
	
	    var p1 = new google.maps.LatLng(rlat,rlng);
	    var p2 = new google.maps.LatLng(slat,slng);
	    
	    inter_distance = String(calcDistance(p1, p2));
 	    var support_now_info = support_id +"("+inter_distance+"m)";
	    $("#support_now").html(support_now_info); 	
		
	})
	
	
	//구글맵 로드
	function initMap() {
		// 맵 바탕 띄울때 옵션 (center:중심좌표 / zoom:배율)
		mapOptions = {
			center: rlocation
			,zoom: 15
		};
		
		map = new google.maps.Map(document.getElementById('map'), mapOptions); // 지도 띄우기
		
		addMarker(rlocation, ricon);
		addMarker(slocation, sicon);
		
	    var impactCoordinates = [
	        new google.maps.LatLng(rlat,rlng),
	        new google.maps.LatLng(slat,slng),
	    ];
	    
	    var ImpactPath = new google.maps.Polyline({
			path: impactCoordinates
			,strokeColor: "#FF0000"
			,strokeOpacity: 1.0
			,strokeWeight: 5
	   	});
	    
	    setMapOnAll(map)
	    ImpactPath.setMap(map);
	    
	}	
	
	
	// 배열에 마커 추가하기 
	function addMarker(location, icon) {
	    var marker = new google.maps.Marker({
	    		position: location
	    		,map: map
	    		//,animation: google.maps.Animation.BOUNCE // 마커 통통 튀게하기
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
	
	
 	/* 매칭 내용 수정관련 */
	function supp_change(){
 		var id = $("#support_id").val();
		
		$.ajax({
			type: 'GET'
			,url: '/admin/userSearch'
			,data: {"userid": id}
			,success: 
				matching_update
		}) 
		
	}
	
 	function matching_update(resp){
		$("#support_name").val(resp.username);
		$("#support_phone").val(resp.userphone);
		$("#support_disabled").val(resp.disabled);
		$("#supp_x").val(resp.user_x);
		$("#supp_y").val(resp.user_y);
		
 		var mulat = resp.user_x;
		var mulng = resp.user_y;
		
		var mulocation = {lat: mulat, lng: mulng};
		
		deleteMarkers();
		addMarker(rlocation, ricon);
		addMarker(mulocation, sicon);
		
		setMapOnAll(map); //변경된 마커 띄우기 
	} 

	
	//요청자 위치 기준 반경 약 ?km안에 있는 대기중인 지원자들 리스트를 불러오기
	function waitSearch(){
		var lat = rlat;
		var lng = rlng;
		
		$.ajax({ 
			type:'GET'
			,url:'/admin/waitSearch'
			,data: {"user_x": lat, "user_y": lng}
			,success:
				waitList
		});
		
	}
	
	function waitList(resp){
		var tag  = '';
		
		$.each(resp, function(index, item){
			tag += '<option value=';
			tag += '"'+item.userid+'">';
			tag += item.userid + '(' + item.inter_distance + 'm)'; 
			tag += '</option>';
		});
		
		$("#support_id").append(tag);
		
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
		<h2>매칭 정보(수정)</h2>
			<form action="/admin/matchingUpdate" method="POST" >
				<input type="submit" value="수정하기">
				<a href="/admin/matchingDetail?requestseq=${request.requestseq}" class="button">수정 취소</a> 
				<div class="row gtr-uniform">
					<div class="col-12">
						요청 내용<input type="text" name="request_contents" value="${request.request_contents}" readonly="readonly">
					</div>
					<!--  -->
					<div class="col-4">
						요청일시<input type="text" name="request_date" value="${request.request_date}" readonly="readonly">
					</div>
					<div class="col-4">
						<c:if test="${request.completion_date == null}">
							완료일시<input type="text" name="completion_date" readonly="readonly">
						</c:if>
						<c:if test="${request.completion_date != null}">
							완료일시<input type="text" name="completion_date" value="${request.completion_date}" readonly="readonly">
						 </c:if>
					</div>
					<div class="col-4">
						요청상태<select name="request_flag">
							<option value="normal" ${request.request_flag == 'normal' ?'selected' :'' }>일반</option>
							<option value="uncompleted" ${request.request_flag == 'uncompleted' ?'selected' :'' }>미완료</option>
							<%-- <option value="처리완료" ${request.request_flag == '처리완료' ?'selected' :'' }>처리완료</option> --%>
						</select>
					</div>
					<!--  -->
					<div class="col-3" >
						요청자 ID<input type="text" name="userid" value="${request.userid}" readonly="readonly">
					</div>
					<div class="col-3">   
						이름<input type="text" value="${request.username}" readonly="readonly">
					</div>
					<div class="col-3">
						연락처<input type="text" value="${request.userphone}" readonly="readonly">
					</div>
					<div class="col-3">
						<input type="checkbox" id="user_disabled" name="disabled" ${request.disabled =='YES' ?'checked' :'' } disabled="disabled">
						<label for="user_disabled">장애여부</label>
					</div>
					<!--  -->
					<div class="col-3">
						지원자 ID<select id="support_id" name="support_id">
							<option id="support_now" value="${support.support_id}"></option>
						</select>
					</div>
					<div class="col-3">
						이름<input type="text" id="support_name" value="${support.username}" readonly="readonly">
					</div>
					<div class="col-3">
						연락처<input type="text" id="support_phone" value="${support.userphone}" readonly="readonly">
					</div>
					<div class="col-3">
						<input type="checkbox" id="support_disabled" ${support.disabled =='YES' ?'checked' :'' } disabled="disabled">
						<label for="support_disabled">장애여부</label>
					</div>
				</div>
				<input type="hidden" name="requestseq" value="${request.requestseq}">
				<input type="hidden" name="req_x" value="${request.req_x}">
				<input type="hidden" name="req_y" value="${request.req_y}">
				<input type="hidden" id="supp_x" name="supp_x" value="${request.supp_x}">
				<input type="hidden" id="supp_y" name="supp_y" value="${request.supp_y}">
				<input type="hidden" id="ex_support_id" name="ex_support_id" value="${request.support_id}">
				<!-- Security -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
	</div> 
	<div id="map"></div>
   <!-- Scripts -->
        <script src="/resources/assets/js/jquery.min.js"></script>
        <script src="/resources/assets/js/browser.min.js"></script>
        <script src="/resources/assets/js/breakpoints.min.js"></script>
        <script src="/resources/assets/js/util.js"></script>
        <script src="/resources/assets/js/main.js"></script>
        
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&libraries=geometry&sensor=false"></script>
	    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
	    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOtVk3O8rzFAXRss8SE0LUODSpFy9tiL8&callback=initMap"></script>
</body>
</html>