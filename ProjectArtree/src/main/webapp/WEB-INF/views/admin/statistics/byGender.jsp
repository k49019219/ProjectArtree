
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

	body {
		font-family: 'Noto Sans Kr', sans-serif;
	}
	
	#statisticsContainer {
		margin: 0 auto;
		width: 80%;
		padding: 0;
	}
	
	img#boardtop {
		position : absolute;
		width : 100vw;
		height : 540px;
	}
	
	div#topText {
		padding-top : 610px;
		width : 200px;
		padding-left : 60px;
	}
	
	div#topText span {
		font-size : 13pt;
		text-align : left;
		margin-left : 8px;
	}
	
	div#topText > h1 {
		font-size: 50px;
	}

	/* == 전시 상태별 선택 부분 == */
	div#eachStatus {
		padding-top : 40px;
		padding-left : 60px;
		font-size: 16pt;
	}

	div#eachStatus .displayStatus {
		margin-right : 20px;
		color : gray;
		padding : 5px;
	}
	
	div#eachStatus .currentStatus {
		color : black !important;
		font-weight: bold !important;
	}
	
	.displayStatus:hover {
		cursor: pointer;
		text-decoration: none;
		box-shadow: 3px 3px 3px 3px grey;
		border-radius: 10px;
	}

	/* == 내용물 부분 == */
	#contentContainer {
		padding-top : 100px;
		width : 60%;
		margin : 0 auto;
	}
	
	div#contentContainer table thead th:first-child, div#contentContainer table tbody th:first-child {
		width : 10%;
		text-align: center;
	}
	div#contentContainer table thead th:nth-child(2), div#contentContainer table tbody th:nth-child(2) {
		width : 50%;
		text-align: center;
	}
	div#contentContainer table thead th:nth-child(3), div#contentContainer table tbody th:nth-child(3) {
		width : 15%;
		text-align: center;
	}
	
	div#contentContainer table thead td:first-child, div#contentContainer table tbody td:first-child {
		width : 10%;
		text-align: center;
	}
	
	div#contentContainer table thead td:nth-child(2), div#contentContainer table tbody td:nth-child(2) {
		width : 50%;
		text-align: center;
	}
	
	div#contentContainer table thead td:nth-child(3), div#contentContainer table tbody td:nth-child(3) {
		width : 15%;
		text-align: center;
	}
	
	div#contentContainer table thead td:nth-child(4), div#contentContainer table tbody td:nth-child(4) {
		width : 20%;
		text-align: center;
	}

	div#contentContainer table tbody td:nth-child(2) {
		cursor : pointer;
	}

	div#contentContainer table thead td {
		padding-top : 10px;
		padding-bottom : 10px; 
	}
	
	/* == 통계 영역 == */
	#statistics-area {
		height: 60vh;
	}
	
	#table-area {
		padding-top: 100px;
		height: 50vh;
	}
	
</style>

<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/kelly.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){ 
		
		getGenderChart();
		
	});
	
//////////////////////////////////////////////getGenderChart
	function getGenderChart(){
		
		$.ajax({
			url: "<%= ctxPath%>/getGenderChart.at",
			data: {},
			dataType: "JSON",
			success: function(json){
				
				var resultArr = [];
				var html = "";
				
				if(json.length == 0){
					
					html += "<div class='empty' style='font-size:15pt; font-weight: bold;'> 데이터가 존재하지 않습니다. </div><br/><br/>";
					$(".chart_area").html(html);

				}
				else {
					
						html += "<thead>"
						html +=		"<tr>"
						html +=			"<th>성별</th>"
						html +=			"<th>회원수</th>"
						html +=			"<th>성비(%)</th>"
						
						html +=		"</tr>"
						html +=	"</thead>"
								
						html +=	"<tbody>"
						$.each(json, function(index, item){
							var gender = item.GENDER
							html +=		"<tr>"
							html +=			"<td>"+(item.GENDER === "1" ? "남성" : "여성")+"</td>" /* 흠*/
 							html +=			"<td>"+item.CNT+"</td>"
							html +=			"<td>"+item.PCT+"</td>"
							html +=		"</tr>"
									
						});	
						html +=		"<tr>"
						html +=			"<td>전체</td>"
						html +=			"<td>" + ${totalCount} + "</td>"
						html +=			"<td>100</td>"
						html +=		"</tr>"	
						html +=	"</tbody>"
						
						$(".table").html(html);
						
						
					<%-- 차트 영역 --%>
					// 성별 차트
					am4core.ready(function() {
						
						for(var i=0; i<json.length; i++) {
							var obj = {
								name: json[i].GENDER === "1" ? "남성" : "여성",
							    value: json[i].CNT
						    };
							resultArr.push(obj); // 배열속에 객체를 넣기
						}
						
						
						// Themes begin
						am4core.useTheme(am4themes_kelly);
						am4core.useTheme(am4themes_animated);
						// Themes end
		
						var iconPath = "M53.5,476c0,14,6.833,21,20.5,21s20.5-7,20.5-21V287h21v189c0,14,6.834,21,20.5,21 c13.667,0,20.5-7,20.5-21V154h10v116c0,7.334,2.5,12.667,7.5,16s10.167,3.333,15.5,0s8-8.667,8-16V145c0-13.334-4.5-23.667-13.5-31 s-21.5-11-37.5-11h-82c-15.333,0-27.833,3.333-37.5,10s-14.5,17-14.5,31v133c0,6,2.667,10.333,8,13s10.5,2.667,15.5,0s7.5-7,7.5-13 V154h10V476 M61.5,42.5c0,11.667,4.167,21.667,12.5,30S92.333,85,104,85s21.667-4.167,30-12.5S146.5,54,146.5,42 c0-11.335-4.167-21.168-12.5-29.5C125.667,4.167,115.667,0,104,0S82.333,4.167,74,12.5S61.5,30.833,61.5,42.5z"
		
						var chart = am4core.create("genderChart", am4charts.SlicedChart);
						chart.hiddenState.properties.opacity = 0; // this makes initial fade in effect
					
						chart.data = resultArr;
		
						var series = chart.series.push(new am4charts.PictorialStackedSeries());
						series.dataFields.value = "value";
						series.dataFields.category = "name";
						series.alignLabels = true;
		
						series.maskSprite.path = iconPath;
						series.ticks.template.locationX = 1;
						series.ticks.template.locationY = 0.5;
		
						series.labelsContainer.width = 200;
		
						chart.legend = new am4charts.Legend();
						chart.legend.position = "left";
						chart.legend.valign = "bottom";
					});
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
		
	}
	
	function getGenderTable(){
		
		$.ajax({
			url: "<%= ctxPath%>/getGenderChart.at",
			data: {},
			dataType: "JSON",
			success: function(json){
				
				var resultArr = [];
				var html = "";
				
				if(json.length == 0){
					
					html += "<div class='empty' style='font-size:15pt; font-weight: bold;'> 데이터가 존재하지 않습니다. </div><br/><br/>";
					$(".table").html(html);
					

				}
				else {
					
					
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
		
	}

</script>
</head>
<body>

	<div id="imgcontainer">	
  		<img id="boardtop" src="<%= ctxPath %>/resources/images/admin/statistics.jpg" />
	</div>

	<div id="statisticsContainer" class="container">

		<div id="topText">
			<span>ADMIN ONLY</span>
			<h1 style="margin:0;">Statistics</h1>
		</div>
		
		<div id="eachStatus">
			<a class="displayStatus" href="/artree/bySales.at">매출</a>
			<a class="displayStatus" href="/artree/byTicketingRate.at">예매율</a>
			<a class="displayStatus currentStatus" href="/artree/byGender.at">성별 통계</a>
			<a class="displayStatus" href="/artree/byGenre.at">선호 장르</a>
			<a class="displayStatus" href="/artree/byTags.at">선호 태그</a>
		</div>

		<div id="contentContainer">
			
			<div id="statistics-area">
				<div class="chart_area" style="width: 100%; height: 100%;">
		   		  <div id="genderChart" style="width: 100%; height: 100%;"></div>
				</div>
			</div>
			
			<div id="table-area">
				
				<%-- 차트에 대한 데이터 테이블은 이곳에 넣으세요 !! --%>
				
				<table class="table">
					
				</table>
				
			</div>
			
		</div>

	</div>

</body>
>>>>>>> branch 'master' of https://github.com/allexshim/ProjectArtree.git
</html>