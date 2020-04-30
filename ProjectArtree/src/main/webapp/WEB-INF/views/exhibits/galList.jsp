<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">

	@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	
	#container_gal_list {
		font-family: 'Noto Sans Kr', sans-serif;
		margin: 0 auto;
		width: 70%;
	}
	
	#container_gal_list .main_title {
		display: inline-block;
		width: 100%;
		text-align: center;
		font-weight: bold;
		font-size: 25pt;
		margin: 0px 0 60px 0;
	}
	
	#container_gal_list .main_top {
		display: inline-block;
		width: 100%;
		margin: 0 0 50px 0;
		height: 500px;
	}
	
	<%-- slider start --%>
	#container_gal_list .mainGalImg { 
		vertical-align: middle; 
		width: 50%;
		float: left;
		height: 100%;
		padding-bottom: 40px;
	}
	
	#container_gal_list .contents {
		width: 50%;
		float: right;
		text-align: left;
		padding: 20px 0 20px 40px;
		height: 100%;
	}
	
	#container_gal_list .contents .recom_title {
		font-size: 20pt;
		font-weight: bold;
		width: 100%;
		display: inline-block;
	}
	
	#container_gal_list .contents .recom_info { margin: 10px 0 50px 0; }
	 
	#container_gal_list .contents .recom_info span {
		width: 100%;
		display: inline-block;
		font-size: 12pt;
		line-height: 150%;
	}
	
	#container_gal_list .contents .thisCurExh span {
		font-size: 13pt;
		font-weight: bold;
		margin-bottom: 15px;
		width: 100%;
		display: inline-block;
	}
	
	#container_gal_list .searchArea {
		display: inline-block;
		width: 100%;
		margin: 100px 0 150px 0;
	}
	
	#container_gal_list .searchArea select {
		width: 20%;
		display: inline-block;
		margin-right: 5%;
		font-size: 15pt;
		border: none;
		height: 50px;
		border-bottom: solid 2px #444;
	}
	
	#container_gal_list .searchArea input {
		display: inline-block;
		height: 45px;
		border: none;
		width: 95%;
		font-size: 15pt;
		padding-left: 10px;
		background-color: white;
	}
	
	#container_gal_list .searchArea img {
		display: inline-block;
		width: 5%;
		float: right;
		cursor: pointer;
		height: 100%;
	}
	
	#container_gal_list .inputText {
		border-bottom: solid 2px #444;
		display: inline-block;
		width: 70%;
	}
	
	#container_gal_list .galArea {
		display: inline-block;
		width: 100%;
		padding-left: 2%;
	}
	
	#container_gal_list .galArea .gal_one {
		display: inline-block;
		width: 28%;
		margin: 0 7% 80px 0;
		text-align: left;
		text-decoration: none;
		height: 350px;
		position: relative; 
		cursor: pointer;
	}
 
	#container_gal_list .galArea .gal_one img {
		width: 100%;
		height: 200px;
		margin-bottom: 15px;
	}
	
	#container_gal_list .galArea .gal_one span {
		width: 100%;
		display: block;
		color: #000;
	}
	
	#container_gal_list .galArea .gal_one .galAddr { 
		font-size: 9pt; 
		margin-bottom: 5px;
	}
	
	#container_gal_list .galArea .gal_one .galInfo { 
		display: table-cell; 
		font-weight: 500; 
	}
	
	#container_gal_list .galArea .gal_one .galTitle { 
		font-size: 15pt; 
		font-weight: bold; 
		margin: 15px 0 5px 0;
		position: relative;
	}

	#container_gal_list .Title_Area {
		width: 100%;
		display: inline-block; 
		text-align: center;
		margin: 200px 0 200px 0;
	}
	
	#container_gal_list .Title_Area .lt {
		display: block;
		font-size: 35pt;
		font-weight: bold;
		color: #000;
	}
	
	#container_gal_list .carousel-inner {
		position: relative;
		height: 500px;
	}
	
	#container_gal_list .carousel-inner .item {
		height: 100%;
	}
	
	#container_gal_list .carousel-control {
		background-image: none;
	}
	
	#container_gal_list .carousel-indicators {
	  display: block;
	  bottom: -30px;
	  color: #bbb;
	}
	
	#container_gal_list .carousel-indicators li {    
	  background-color: #cbcbcb;
	  margin-right: 5px;
	  margin-left: 5px;
	}
	
	#container_gal_list .carousel-indicators .active {
	  background-color: #737373;
	}

	#container_gal_list .contents .thisCurExh img {
		display: inline-block;
		width: 130px;
		margin: 0 12px 0 12px;
		height: 200px; 
	}

	#container_gal_list #myBtn {
	  display: none;
	  position: fixed;
	  bottom: 30px;
	  right: 30px;
	  z-index: 99; 
	  width: 80px;
	  border: none;
	  outline: none;
	  color: white;
	  cursor: pointer;
	  padding: 10px;
	  border-radius: 4px;
	}
	
	#container_gal_list .emptyNoti {
		text-align: center;
		font-size: 20pt;
		font-weight: bold;
		width: 100%;
	    display: block;
	    border: 1px solid #e6e6e6;
	    padding: 100px;
	}
	
	
	#container_gal_list .home {
	  position:relative;
	  height:200px;
	  width:420px; 
	  overflow:hidden;
	}
	
	#container_gal_list .ani{ 
		position: relative;
	}  

    #container_gal_list .exhStatus {
		font-size: 12pt;
		border: none;
		padding: 4px 9px;
		color: white;
		border-radius: 5px; 
		display: inline-block;
		width: 100px !important;
		margin-bottom: 20px;
	} 
 
</style>  

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		/////////////// 스크롤 페이징
		var page = 1;
		getGalList(page);
		
	    /////////////// 실시간 추천 공간
	    getGalRecomList();

		$(document).on("mouseover", ".gal_one", function(){
			$(this).find(".galTitle").stop().animate({bottom:'5px'}, 180);
		});
		
		$(document).on("mouseout", ".gal_one", function(){
			$(this).find(".galTitle").stop().animate({bottom:'0px'}, 180);
		});		
		
		$("#searchText").keydown(function(event){
			if(event.keyCode == 13){ goSearch(1); }
		});
		
		$("select[name=searchWhere]").change(function(){
			goSearch(1);
		});
		
		$("#count").hide();
		$("#tc").hide();
		
		$("#myBtn").hover(function() {
			$(this).stop().animate({bottom:'40px'}, 150);
		}, function() {
			$(this).stop().animate({bottom:'30px'}, 150);
		});

	    // 스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
		$(window).scroll(function(){   
			if($(window).scrollTop() >= $(document).height() - $(window).height()){
		    	if( $("#count").text() != $("#tc").text() ){
		    	 	page++; 
		    	 	getGalList(page);
		    	}
		    } 
		});
	    
		// When the user scrolls down 20px from the top of the document, show the button
		window.onscroll = function() { scrollFunction() };
	    
	}); // end of document ready ---------------
	
	/////////////////// 실시간 추천 공간 불러오기 //////////////////
	function getGalRecomList(){
		
		$.ajax({
			url: "<%=ctxPath%>/galRecomList.at",
			dataType: "JSON",
			success:function(json){
				
				var html = "";
				
				if(json.length == 0){
					html += "<span style='text-align:center;'>준비중입니다 :></span>";
					$(".carousel-inner").html(html);
				}
				else {
					
					$.each(json, function(index, item){
						
						if(index == 0){
							// item active
							html += '<div class="item active">'
						    	 + '<a href="<%= ctxPath%>/galDetail.at?gno='+item.GALLERYNO+'"><img class="mainGalImg" src="'+item.MAINPICTURE+'"></a>'  
						         + '<div class="contents">'
						         + '<span class="recom_title">'+item.GALLERYNAME+' | '+item.LOCATION+'</span>'
						         + '<div class="recom_info">'
								 + '<div class="statusArea">';
								    
							$.ajax({
						    	url: "<%=ctxPath%>/getExhStatus.at",
						    	data: {"gno":item.GALLERYNO},
						    	dataType: "JSON",
						    	success: function(json3){
						    		
						    		var html3 = '';
						    		
						    		if(json3.exhStat == 0){
						    			html3 += '<span class="exhStatus" style="background-color: #808080;">전시 준비중</span>';
						    		}
						    		else {
						    			html3 += '<span class="exhStatus" style="background-color: #ff6666;">현재 전시중</span>';
						    		}
						    		$(".statusArea").html(html3);
						    	}
						         
						    })
								         
						    html += '</div>' 
						    	 + '<span>휴관일 '+item.HOLIDAY+'</span>'
						         + '<span>운영시간 '+item.OPENINGHOUR+'</span>'
						         + '</div>'
						         + '<div class="thisCurExh">'
						         + '<span>진행중 전시회</span>'
						         + '<div class="slideHome'+index+' home">'
						         + '<div class="exhSlide'+index+' ani">'
						         
						    $.ajax({
						    	url: "<%= ctxPath%>/getRecomExhList.at",
						    	data: {"gno":item.GALLERYNO},
						    	dataType: "JSON",
						    	success: function(json2){
						    		
						    		var html2 = '';
						    		
						    		if(json2.length == 0){
						    			alert("실패");
						    		}
						    		else {
						    			
						    			$.each(json2, function(index2, item2){
						    				html2 += '<a href="<%= ctxPath%>/exhDetail.at?eno='+item2.EXHIBITIONNO+'">';
						    				
						    				if(item2.MAINPOSTER.substr(0, 4) != 'http'){
												html2 += "<img src='<%= ctxPath%>/resources/files/"+item2.MAINPOSTER+"'/></a>";
											}
											else {
												html2 += "<img src='"+item2.MAINPOSTER+"'/></a>";
											}						    				
							    		});
						    		
						    			$(".exhSlide"+index).append(html2);
						    			
						    			if(json2.length > 3){
											 
						     				///////////////////////////////////////////////////////////////////
											$(".exhSlide"+index).css({"width":"calc(154 * "+json2.length+"px)"});
											
							     			var width = $(".exhSlide"+index).width();
							     			var showWidth = width-(154*2)-100;
							     			
							     	    	var $wrapper = $(".exhSlide"+index);
											
							     			var animator =	function(imgblock){
							     				
							     				$wrapper.animate({'left':-showWidth}, 1000*json2.length).animate({ left:"10px" }, 1000*json2.length);
							     	
			     								animator(imgblock);
			     			                }	
	
							     			animator($wrapper); // 함수호출
							     	
						     			} // end of if ------ 
						    		
						    		}
						    	}
						    });     
						    
						    html += '</div></div></div></div></div>';
						}
						else {
							// item
							html += '<div class="item">'
								 + '<a href="<%= ctxPath%>/galDetail.at?gno='+item.GALLERYNO+'"><img class="mainGalImg" src="'+item.MAINPICTURE+'"></a>'  
						         + '<div class="contents">'
						         + '<span class="recom_title">'+item.GALLERYNAME+' | '+item.LOCATION+'</span>'
						         + '<div class="recom_info">'
								 + '<div class="statusArea">';
						    
							$.ajax({
						    	url: "<%=ctxPath%>/getExhStatus.at",
						    	data: {"gno":item.GALLERYNO},
						    	dataType: "JSON",
						    	success: function(json3){
						    		
						    		var html3 = '';
						    		
						    		if(json3.exhStat == 0){
						    			html3 += '<span class="exhStatus" style="background-color: #808080;">전시 준비중</span>';
						    		}
						    		else {
						    			html3 += '<span class="exhStatus" style="background-color: #ff6666;">현재 전시중</span>';
						    		}
						    		$(".statusArea").html(html3);
						    	}
						         
						    })
						         
						    html += '</div>' 
						    	 + '<span>휴관일 '+item.HOLIDAY+'</span>'
						         + '<span>운영시간 '+item.OPENINGHOUR+'</span>'
						         + '</div>'
						         + '<div class="thisCurExh">'
						         + '<span>진행중 전시회</span>'
						         + '<div class="slideHome'+index+' home">'
						         + '<div class="exhSlide'+index+' ani">'
									
				         $.ajax({
						    	url: "<%= ctxPath%>/getRecomExhList.at",
						    	data: {"gno":item.GALLERYNO},
						    	dataType: "JSON",
						    	success: function(json2){
						    		
						    		var html2 = '';
						    		
						    		if(json2.length == 0){
						    			alert("실패");
						    		}
						    		else {
						    			$.each(json2, function(index2, item2){
						    				html2 += '<a href="<%= ctxPath%>/exhDetail.at?eno='+item2.EXHIBITIONNO+'">';
						    				
						    				if(item2.MAINPOSTER.substr(0, 4) != 'http'){
												html2 += "<img src='<%= ctxPath%>/resources/files/"+item2.MAINPOSTER+"'/></a>";
											}
											else {
												html2 += "<img src='"+item2.MAINPOSTER+"'/></a>";
											}						    				
							    		});
						    			
						    			$(".exhSlide"+index).append(html2);
			
						    			if(json2.length > 3){
							     			
						     				$(".exhSlide"+index).css({"width":"calc(154 * "+json2.length+"px)"});
											
							     			var width = $(".exhSlide"+index).width();
							     			var showWidth = width-(154*2)-100;
							     			
							     	    	var $wrapper = $(".exhSlide"+index);
											
							     			var animator =	function(imgblock){
							     				
							     				$wrapper.animate({'left':-showWidth}, 1000*json2.length).animate({ left:"10px" }, 1000*json2.length);
			     								
							     				animator(imgblock);
			     			                }	
	
							     			animator($wrapper); // 함수호출
							     	
						     			} // end of if ------ 
						    		}
						    	}
						    });     
						         
						    html += '</div></div></div></div></div>';
						}
						
					});
					
					$(".carousel-inner").append(html);
					
				} // end of if ~ else ----------------
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})
		
	} // end of function getGalRecomList() ----------------------
	

	var len = 9;
	////////////////// 갤러리 목록 불러오기 /////////////////////
	function getGalList(page){
		
		var searchWhere = $("#searchWhere").val();
		var searchText = $("#searchText").val().trim();
	
		$.ajax({
			url: "<%=ctxPath%>/galList.at",
			data: {"page":page, "len":len, "searchWhere":searchWhere, "searchText":searchText},
			dataType: "JSON",
			success:function(json){
				
				if( (searchWhere != null || searchText != null) && page == 1){ $(".galArea").html(""); $("#count").text("0"); }
				
				var html = "";
				
				if(json.length == 0){
					html += "<span class='emptyNoti'>갤러리가 존재하지 않습니다. :></span>";
					$(".galArea").html(html);
				}
				else {

					$.each(json, function(index, item){
					
						if( (index+1)%3 != 0){
							
							html += "<a class='gal_one' onclick='galDetail("+item.GALLERYNO+")'>"
								 + "<img class='mainImg' src='"+item.MAINPICTURE+"'/>"
								 + "<span class='galTitle'>"+item.GALLERYNAME+" | "+item.LOCATION+"</span>"
								 + "<span class='galAddr'>"+item.DETAILADDRESS+"</span>";
							
						  if(item.INTRODUCTION != null){
							html += "<span class='galInfo'>"+item.INTRODUCTION+"</span>";
						  }
							html += "</a>";
							
						}
						else {
							
							html += "<a class='gal_one' onclick='galDetail("+item.GALLERYNO+")' style='margin-right: 0;'>"
							 + "<img class='mainImg' src='"+item.MAINPICTURE+"'/>"
							 + "<span class='galTitle'>"+item.GALLERYNAME+" | "+item.LOCATION+"</span>"
							 + "<span class='galAddr'>"+item.DETAILADDRESS+"</span>";
							
						  if(item.INTRODUCTION != null){
							html += "<span class='galInfo'>"+item.INTRODUCTION+"</span>";
						  }
							html += "</a><br/>";							
						}
						
						$("#tc").text(item.totCount);
						
					});
					
					$(".galArea").append(html);

					$("#count").text( parseInt($("#count").text())+json.length ); // 초기치 0

				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	}
	
	function goSearch(page){

		if (searchWhere == '' && searchText == ''){
			alert("검색어를 입력 후 다시 시도해주세요.");
			return;
		}
		
		getGalList(page);
		
	}// end of goSearch(page) ---------
	
	function galDetail(gno){
		location.href="<%=ctxPath%>/galDetail.at?gno="+gno;
	}// end of galDetail ---------------------
	
	function scrollFunction() {
	  if ($(window).scrollTop() > 20 || $(document).scrollTop()  > 20) {
		  $("#myBtn").css("display","block");
	  } else {
		  $("#myBtn").css("display","none");
	  }
	}// end of scrollFunction ---------------------

	function topFunction() {
		$('html, body').animate( { scrollTop : 0 }, 400 );
        return false;
	}// end of topFunction ---------------------

</script>

<div id="container_gal_list" align="center">

	<div class="Title_Area">
		<span class="lt">GALLERY</span>
	</div>

	<span class="main_title">실시간 추천 공간</span>

	
	<div class="main_top">
	  <div id="myCarousel" class="carousel slide" data-ride="carousel">
	    <!-- Indicators -->
	    <ol class="carousel-indicators">
	      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	      <li data-target="#myCarousel" data-slide-to="1"></li>
	      <li data-target="#myCarousel" data-slide-to="2"></li>
	    </ol>
	
	    <!-- Wrapper for slides -->
	    <div class="carousel-inner">
	    </div>
	  </div>
	</div>
		

	<div class="searchArea">
		<select name="searchWhere" id="searchWhere">
			<option value="">지역전체</option>
			<option value="1">서울</option>
			<option value="2">경기 인천</option>
			<option value="3">부산 울산 경남</option>
			<option value="4">대구 경북</option>
			<option value="5">광주 전라</option>
			<option value="6">대전 충청 세종</option>
			<option value="7">제주 강원</option>
		</select>
		<div class="inputText">
			<input type="text" name="searchText" id="searchText" placeholder="갤러리명으로 검색하기"/>
			<img class="icoForSearch" onclick="goSearch(1);" src="<%= ctxPath%>/resources/images/exhibition/ico/ico_search.png">
		</div>
	</div>
	
	<span id="count">0</span>
	<span id="tc"></span>
	
	<div class="galArea" style="text-align: left;">
	</div>
	
	<div style="position: relative;">
		<img onclick="topFunction()" id="myBtn" title="Go to top" src="<%= ctxPath%>/resources/images/exhibition/ico/dropup.png">
	</div>
	
</div>