<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>


<style type="text/css">
	@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	
	#container_exhibition {
		font-family: 'Noto Sans Kr', sans-serif;
		margin: 200px auto;
		width: 70%;
	}
	
	#container_exhibition .Title_Area {
		width: 100%;
		display: inline-block; 
		text-align: center;
	}
	
	#container_exhibition .Title_Area .st {
		display: block;
		font-size: 15pt;
		color: #000;
	}
	
	#container_exhibition .Title_Area .lt {
		display: block;
		font-size: 35pt;
		font-weight: bold;
		color: #000;
	}
	
	#container_exhibition .ExhCategory_Area {
		display: inline-block;
		width: 100%;
		margin: 150px 0 50px 0;
		text-align: center;
	}
	
	#container_exhibition .ExhCategory_Area a {
		text-decoration: none;
		color: #bfbfbf;
		margin-left: 20px;
		font-weight: bold;
	}
	
	#container_exhibition .ExhCategory_Area a:hover {
		color: #0d0d0d;
		font-weight: bold;
	}
	
	#container_exhibition .ExhCategory_Area .cate_exh {
		display: inline-block;
		padding-bottom: 15px;
		border-bottom: solid 1px #e6e6e6;
		width: 70%;
		font-size: 15pt;
	}
	
	#container_exhibition .ExhCategory_Area .cate_map { 
		font-size: 13.5pt;
		padding-top: 15px;
	}

	#container_exhibition .ExhList_Area {
		width: 100%;
		margin-top: 100px;
	}
	
	#container_exhibition .ExhList_Area a {
		text-decoration: none;
		color: #0d0d0d;
		cursor: pointer;
		display: inline-block;
		width: 22%;
		height: 600px;
		margin-right: 3.7%;
		margin-top: 40px;
		border: solid 1px #e6e6e6;
		position: relative;
	}
	
	#container_exhibition .ExhList_Area a img {
		width: 100%;
		height: 350px;
		margin-bottom: 20px;
	}
	
	#container_exhibition .ExhList_Area .artInfoArea {
		padding: 0px 10px 0 10px;
		width: 100%;
		height: 250px;
		display: table-cell;
	}
	
	#container_exhibition .ExhList_Area a .art_mainTitle {
		display: inline-block;
		font-size: 16pt;
		font-weight: bold;
		margin: 3px 0 3px 0;
	}
	
	#container_exhibition .ExhList_Area a .InfoWhereWhen {
		display: block;
		font-size: 10pt;
	} 
	
	#container_exhibition .ExhList_Area a .forMoving {
		position: relative;
	}
	
	#container_exhibition .categoryList .on {
		color: #0d0d0d;
		font-weight: bold;
	}
	
	#container_exhibition #myBtn {
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
	
	#container_exhibition .emptyNoti {
		text-align: center;
		font-size: 20pt;
		font-weight: bold;
		width: 100%;
	    display: block;
	    border: 1px solid #e6e6e6;
	    padding: 100px;
	}
	
</style>

<%-- EXHIBITION LIST SCRIPT START --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		window.onbeforeunload = function() {
			sessionStorage.removeItem("type");
			sessionStorage.removeItem("loca");
		};
		
		$("#count").hide();
		$("#tc").hide();
		
		/////////////// 스크롤 페이징
		var page = 1;
		getExhList(page, sessionStorage.getItem("type"), sessionStorage.getItem("loca"));
	    ///////////////
	    
	    // 스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
		$(window).scroll(function(){
		    if($(window).scrollTop() >= $(document).height() - $(window).height()){
		    	if( $("#count").text() != $("#tc").text() ){
			    	 page++; 
			    	 getExhList(page, sessionStorage.getItem("type"), sessionStorage.getItem("loca"));
		    	 }
			}
		});
	    
	    $(".cate_map .exh_cate_option").click(function(event){
	    	$(".cate_map").find(".on").removeClass("on");
	    	$(event.target).addClass("on");
	    });
	    
	    $(".cate_exh .exh_cate_option").click(function(event){	
	    	$(".cate_exh").find(".on").removeClass("on");
	    	$(event.target).addClass("on");
	    });

		$(document).on("mouseover", ".exh_one", function(){
			$(this).find(".forMoving").stop().animate({top:'10px'}, 180);
		});
		
		$(document).on("mouseout", ".exh_one", function(){
			$(this).find(".forMoving").stop().animate({top:'0px'}, 180);
		});
		
		$("#myBtn").hover(function() {
			$(this).stop().animate({bottom:'40px'}, 150);
		}, function() {
			$(this).stop().animate({bottom:'30px'}, 150);
		});
		
		// When the user scrolls down 20px from the top of the document, show the button
		window.onscroll = function() { scrollFunction() };
		
	}); // end of document ready -------------------------
	
	var len = 16;
	
	////////////////// 전시회 목록 불러오기 /////////////////////
	function getExhList(page, type, loca){
		
		if(type != null){ sessionStorage.setItem("type", type); }
		if(loca != null){ sessionStorage.setItem("loca", loca); }
		
		$.ajax({
			url: "<%=ctxPath%>/exhList.at",
			data: {"page":page, "len":len, "type":type, "loca":loca},
			type: "POST",
			dataType: "JSON",			
			success:function(json){
				
				if( (type != null || loca != null) && page == 1 ){ $(".ExhList_Area").html(""); $("#count").text("0"); }
				
				var html = "";
				
				if(json.length == 0){
					
					html += "<span class='emptyNoti'>전시회가 존재하지 않습니다. :></span>";
					
					$(".ExhList_Area").html(html);

				}
				else {

					$.each(json, function(index, item){
						
						if( (index+1)%4 != 0){				
							
							html += "<a class='exh_one' onclick='exhDetail("+item.EXHIBITIONNO+")'>";
							
								if(item.MAINPOSTER.substr(0, 4) != 'http'){
									html += "<img class='exh_poster' src='<%= ctxPath%>/resources/files/"+item.MAINPOSTER+"'/>";
								}
								else {
									html += "<img class='exh_poster' src='"+item.MAINPOSTER+"'/>";
								}
							
							html += "<div class='artInfoArea'>"
								 + "<span class='art_info_aboutLoca InfoWhereWhen'>"+item.GALLERYNAME+" | "+item.LOCATION+"</span>"
								 + "<span class='art_mainTitle'>"+item.EXHIBITIONNAME+"</span>";
							
								if(item.PRICE == 0){
									html += "<span class='forMoving InfoWhereWhen'>"+item.SCHEDULE+" | FREE</span>";
								}
								else {
									html += "<span class='forMoving InfoWhereWhen'>"+item.SCHEDULE+" | BOOK</span>";
								}
							
							html += "</div></a>";    
							
						}
						else {
							
							html += "<a class='exh_one' style='margin-right:0px;' onclick='exhDetail("+item.EXHIBITIONNO+")'>";
							 	 
								if(item.MAINPOSTER.substr(0, 4) != 'http'){
									html += "<img class='exh_poster' src='<%= ctxPath%>/resources/files/"+item.MAINPOSTER+"'/>";
								}
								else {
									html += "<img class='exh_poster' src='"+item.MAINPOSTER+"'/>";
								}
							
							html += "<div class='artInfoArea'>"
							  	 + "<span class='art_info_aboutLoca InfoWhereWhen'>"+item.GALLERYNAME+" | "+item.LOCATION+"</span>"
							 	 + "<span class='art_mainTitle'>"+item.EXHIBITIONNAME+"</span>";
							 	 
								if(item.PRICE == 0){
									html += "<span class='forMoving InfoWhereWhen'>"+item.SCHEDULE+" | FREE</span>";
								}
								else {
									html += "<span class='forMoving InfoWhereWhen'>"+item.SCHEDULE+" | BOOK</span>";
								}
						
							html += "</div></a><br/>";
							
						}
						
						$("#tc").text(item.totCount);
						
					});

					$(".ExhList_Area").append(html);

					//countHIT 에 지금까지 출력된 상품의 갯수를 누적해서 기록한다.
					$("#count").text( parseInt($("#count").text())+json.length ); // 초기치 0

				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	} // end of exhList ---------------------------------	
		
	function exhDetail(eno){
		location.href="<%= ctxPath%>/exhDetail.at?eno="+eno;
	} // end of exhDetail ---------------------------------
	
	function scrollFunction() {
	  if ($(window).scrollTop() > 20 || $(document).scrollTop()  > 20) {
		  $("#myBtn").css("display","block");
	  } else {
		  $("#myBtn").css("display","none");
	  }
	}

	// When the user clicks on the button, scroll to the top of the document
	function topFunction() {
		$('html, body').animate( { scrollTop : 0 }, 400 );
        return false;
	}

</script>
<%-- EXHIBITION LIST SCRIPT END --%>


<div id="container_exhibition">
	<div class="Title_Area">
		<span class="st">WHAT'S ON</span>
		<span class="lt">EXHIBITIONS</span>
	</div>
	
	<div class="ExhCategory_Area">
		<div class="cate_exh categoryList">
			<a href="javaScript:void(0)" onclick="getExhList(1, 0, sessionStorage.getItem('loca'));" class="exh_cate_option on">전체</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, 'ing', sessionStorage.getItem('loca'));" class="exh_cate_option">진행중인 전시회</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, 'com', sessionStorage.getItem('loca'));" class="exh_cate_option">예정전시</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, 'end', sessionStorage.getItem('loca'));" class="exh_cate_option">지난전시</a>
		</div>
		
		<div class="cate_map categoryList">
			<a href="javaScript:void(0)" onclick="getExhList(1, sessionStorage.getItem('type'), 0);" class="exh_cate_option on">지역 전체</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, sessionStorage.getItem('type'), 1);" class="exh_cate_option">서울</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, sessionStorage.getItem('type'), 2);" class="exh_cate_option">경기 인천</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, sessionStorage.getItem('type'), 3);" class="exh_cate_option">부산 울산 경남</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, sessionStorage.getItem('type'), 4);" class="exh_cate_option">대구 경북</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, sessionStorage.getItem('type'), 5);" class="exh_cate_option">광주 전라</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, sessionStorage.getItem('type'), 6);" class="exh_cate_option">대전 충청 세종</a>
			<a href="javaScript:void(0)" onclick="getExhList(1, sessionStorage.getItem('type'), 7);" class="exh_cate_option">제주 강원</a>
		</div>
	</div>
	
	<span id="count">0</span>
	<span id="tc"></span>
	
	<div class="ExhList_Area">
	</div>
	
	<div style="position: relative;">
		<img onclick="topFunction()" id="myBtn" title="Go to top" src="<%= ctxPath%>/resources/images/exhibition/ico/dropup.png">
	</div>
</div>
