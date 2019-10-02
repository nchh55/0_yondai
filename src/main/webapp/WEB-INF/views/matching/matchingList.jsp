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
<link rel="stylesheet" href="/resources/assets/css/main2.css" /> 
<script>
	/* 구글 맵용 공용변수 선언*/
	var map;
	var mapOptions;
	var markers = [];
	
	
	$(function(){
		
		initMap(); // 구글맵 로드 2
		matching(); // 요청테이블 리스트 불러오기
		
		$(document).on("change", "#searchFlag", matching);
	
	})
	
	//구글맵 로드 2 
	function initMap(){
		// 맵 바탕 띄울때 옵션 (center:중심좌표 / zoom:배율)
		mapOptions = {
			center: {lat: 37.551818 , lng: 126.990915}
			,zoom: 12
		};
		
		map = new google.maps.Map(document.getElementById('map'), mapOptions);
	}
	
	
	// 배열에 마커 추가하기 
	function addMarker(location, icon, seq) {
	    var marker = new google.maps.Marker({
	    		position: location
	    		,map: map
	    		//,animation: google.maps.Animation.BOUNCE // 마커 통통 튀게하기
	    		,draggable: false
	    		,icon: icon
	    });
	    
     	marker.addListener('click', function() {
    		matchingDetail(seq);
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
	
	//////////////////////////////////////////////
	
	function matching(){
		var request_flag = $("#searchFlag").val();
		
		$.ajax({
			type:'GET'
			,url:'/admin/matchingList'
			,data: {"request_flag": request_flag}
			,success: 
				matchingList
		});
	}
	
	function matchingList(resp){
		deleteMarkers();
		
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
			tag += '<a href="#" onClick="matchingDetail('+item.requestseq+');">'+item.request_contents+'</a>'
			tag += '</td>'
			tag += '<td>'+item.userid+'</td>'
			tag += '<td>'+item.request_flag+'</td>'
			tag += '</tr>'
		
			var location = {lat: Number(item.req_x), lng: Number(item.req_y)};
			var icon = '';
			var request_flag = item.request_flag;
			
			if(request_flag == 'normal'){
				icon = '/resources/images/marker/marker_red.png';
			}else if(request_flag == 'completed'){
				icon = '/resources/images/marker/marker_green.png';
			}else{
				icon = '/resources/images/marker/marker_orange.png';
			}
			
			var seq = item.requestseq;
			addMarker(location, icon, seq);
			
		});
		$("#matchingTable").empty();
		$("#matchingTable").html(tag);
		
		setMapOnAll(map);

	}
	
	
	///////////////////////////////////
    
	function matchingDetail(resp){
		var requestseq = resp;		
		var url  = '/admin/matchingDetail?requestseq='
			url += requestseq;
		
		window.open(url, "매칭 상세정보", "width=600, height=750");
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
					<a href="/admin/matchingMgmt" align="center"><h1>매칭 관리</h1></a>
					<a href="/index"><button type="button">끝내기(메인으로)</button></a>
					</section>
				<!-- 검색 콘솔  -->
					<section>
						<!-- 상태별 조회 -->
						<form>
							<table>
								<tr>
									<td><input type="date" name="pickDate" /></td>
									<td><button type="button" class="button primary small" >조회하기</button>
								<tr></tr>
								<tr>
									<td>
										<select id="searchFlag" name="searchFlag">
											<option value="all" ${request_flag =='all'?'selected' :'' }>전체</option>
											<option value="normal" ${request_flag =='normal'?'selected' :'' }>일반</option>
											<option value="uncompleted" ${request_flag =='uncompleted'?'selected' :'' }>미완료</option>
											<option value="completed"  ${request_flag =='completed'?'selected' :'' }>처리완료</option>
										</select>

									</td>
								</tr>
								<tr>
									<td>
										<input type="text" name="searchWord">
									</td>
									<td>
										<button type="button" class="button icon solid fa-search small" >검색</button>
									</td>
								</tr>
							</table>
						</form>
						<table id="matchingTable">
						</table>
					</section>
               </div>
            </div>
      </div>

   <!-- Scripts -->
        <script src="/resources/assets/js/jquery.min.js"></script>
        <script src="/resources/assets/js/browser.min.js"></script>
        <script src="/resources/assets/js/breakpoints.min.js"></script>
        <script src="/resources/assets/js/util.js"></script>
        <script src="/resources/assets/js/main.js"></script>

	    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
	    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOtVk3O8rzFAXRss8SE0LUODSpFy9tiL8&callback=initMap"></script>
   </body>
</html>