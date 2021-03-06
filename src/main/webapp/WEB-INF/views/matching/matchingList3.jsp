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
	var map;
	var markers = [];

	$(function(){
		
		map = new google.maps.Map(document.getElementById('map'), {
	    	zoom: 12,
	    	center: {lat: 37.551818 , lng: 126.990915}
	  	});

	 	matching();		
	 	
	 	$(document).on("change", "#mflag", matching);
	})
	
	
	
	function matching(){
		//alert("매칭 메소드 작동!");
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
		//alert("matchingList 메소드 작동");
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
			tag += '<td><input type="checkbox"></td>'
			tag += '</tr>'
		});
			
		$("#matchingTable").html(tag);
		
		deleteMarkers();
		var icon = '';
		
		
		$.each(resp, function(index, item){
			if(item.request_flag == 'normal'){
				icon = '/resources/images/marker/marker_red.png';
			}else if(item.request_flag == 'completed'){
				icon = '/resources/images/marker/marker_green.png';
			}else{
				icon = '/resources/images/marker/marker_orange.png';
			}
			
			var location = {lat: Number(item.req_x), lng: Number(item.req_y)};
			var seq = item.requestseq;
			//alert(seq);
			addMarker(location, seq, icon);
		});
		
		initMap();
		
	}
	
	//구글맵 지도 + 마커 띄우기
    function initMap() {
		//alert("initMap 메소드 작동");
		
        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        setMapOnAll(map);
/*
	    var markerCluster = new MarkerClusterer(map, markers,
	            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
*/
	}
       
	
    function addMarker(location, seq, icon) {
        var marker = new google.maps.Marker({
        		position: location,
        		map: map,
        		//animation: google.maps.Animation.toggleBounce,
        		//draggable: false,
        		icon: icon
        });
        /*
         	marker.addListener('click', function(){
					marker.setAnimation(google.maps.Animation.BOUNCE);
					matchingDetail(seq);
                }
        	}); 
       	*/
         	marker.addListener('dblclick', function() {
        		matchingDetail(seq);
       		}); 
       	
	     	marker.addListener('click', function() {
	            if (marker.getAnimation() !== null) {
	                marker.setAnimation(null);
	                map.setZoom(12);
	            }else{
	                marker.setAnimation(google.maps.Animation.BOUNCE);
	                map.setZoom(14);
	            }
	   		}); 
       		
        	markers.push(marker);
    }
    
    
    //배열에 있는 마커 띄우기 
    function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
    }
    
    function setMapSupport(map) {
    	
    	
    }
    
/*     //마커 이벤트(바운스)
    function toggleBounce() {
        if (marker.getAnimation() !== null) {
          marker.setAnimation(null);
        } else {
          marker.setAnimation(google.maps.Animation.BOUNCE);
        }
    } 
*/

/* 	function test(){
	    if (marker.getAnimation() !== null) {
	        marker.setAnimation(null);
	      } else {
	        marker.setAnimation(google.maps.Animation.BOUNCE);
	      	
	        $.ajax({
	        	
	        	
	        });
	      
	      }
	} */
    
    //마커 지우기
	function deleteMarkers() {
		setMapOnAll(null);
	    markers = [];
	}
    
	///////////////////////////////////
    
	
	
	function matchingDetail(resp){
		var requestseq = resp;		
		var url  = 'matchingDetail?requestseq='
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
						<form id="searchList" action="/admin/matchingList" method="GET">  
							<table>
								<tr>
									<th>조회일자</th>
									<td colspan="2">
										<input type="date" id="searchDate" name="searchDate">
									</td>
								</tr>
								<tr>
									<th>검색조건</th>
									<td>
										<select id="searchItem" name="searchItem">
											<option value="content">요청내용</option>
											<option	value="id">아이디</option>
										</select>
									</td>
									<td>
										<input type="text" id="searchWord" name="searchWord">
									</td>
								<tr>
									<th>매칭상태</th>
									<td>
										<select id="searchflag" name="searchFlag">
											<option value="all" ${request_flag =='all'?'selected' :'' }>전체</option>
											<option value="normal" ${request_flag =='normal'?'selected' :'' }>일반</option>
											<option value="uncompleted" ${request_flag =='uncompleted'?'selected' :'' }>미완료</option>
											<option value="completed"  ${request_flag =='completed'?'selected' :'' }>처리완료</option>
										</select>
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