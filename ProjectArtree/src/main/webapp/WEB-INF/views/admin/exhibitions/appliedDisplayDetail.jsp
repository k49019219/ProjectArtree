
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>

<html>
<head>
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

	body {
		font-family: 'Noto Sans Kr', sans-serif;
	}
	
	#detailContainer {	
		margin: 100px 0 100px 0;
	}	
		
	#detailContainer .Title_Area {	
		margin: 8vh auto 0 auto;
		width: 100%;
		display: inline-block;
		text-align: center;
		
	}	
	
	h2 {
		font-weight: bold;
	}
	
	#detailContainer .Title_Area:after {
		content: "";
	  	display: block;
		width : 80%;
		margin : 0 auto;	
		padding-top : 100px;
		border-bottom : solid 2px lightgray;
	}
		
	#detailContainer .Title_Area .st {	
		display: block;
		font-size: 15pt;
		
	}	
		
	#detailContainer .Title_Area .lt {	
		display: block;
		font-size: 35pt;
		font-weight: bold;
	}	
	
	#detailContainer .Title_Area .titleDetail {
		display: block;
		font-size: 11pt;
		padding-top : 15px;
	}
	
	div#detailContents, div#extraInfo {
		width: 80%;
		margin: 0 auto;
		padding-top : 20px;
		padding-bottom: 20px;
		overflow: hidden; /* div밖으로 이미지가 넘칠 때 해결 방법! 기억해둘것! */
	}
	
	input, textarea {
		width: 100%;
		border-radius: 5px;
		border : 1px solid lightgray;
		padding: 4px 10px;
	}
	
	table#detailTable {
		width : 95%;
		margin : 0 auto;
	}
	
	table#detailTable tr td, table#extraInfoTable tr td{
		padding-top : 4px;
		padding-bottom :4px;
		font-size : 12pt;
	}
	
	table#detailTable tr td:first-child {
		width : 100px;
		font-weight: bold;
	}
	
	table#detailTable > tbody > tr {
		height: 4vh;
	}
	
	div#myPoster:before {
		content: "";
	  	display: block;
		width : 80%;		
		border-bottom : solid 2px lightgray;
	}
	
	div#myPoster img, div#bigImage img {
		border-radius: 15px;
		box-shadow: 5px 5px 5px grey;
	}
	
	div#myPoster, div#myImages {
		overflow : hidden;
		font-weight: bold;
	}
	
	div#myImages {
		padding-top : 10px;
	}
	
	div#myImages h2 {
		margin : 0;
		padding-top: 10px;
		padding-bottom: 20px;
	}
	
	div#myPoster:after {
		content: "";
	  	display: block;
		width : 80%;		
		padding-top : 30px;
		border-bottom : solid 2px lightgray;
	}
	
	img.thumbNail {
		border-radius: 15px;
	}
	
	div#myImages div#bigImage {
		padding-top : 20px;
	}

	div#myImages div#bigImage .arrow {
		cursor : pointer;
		font-size:60px; 
		font-weight:bold; 
		color : black;
		text-decoration: none;
	}
	
	div#myImages div#bigImage a {
		vertical-align: middle;
	}
	
	.item > img  {
		width : 400px;
		height : 400px !important;
	}
	
	.item {
		display : inline-block;
	}
	
	#extraInfoTable {
		width : 95%;
		margin : 50px auto;
	}
	
	#extraInfoTable tr td:first-child {
		width : 160px;
		font-weight: bold;
	}
	
	#extraInfoTable > tbody > tr > td:nth-child(2) {
		font-weight: normal;
	}
	
	#extraInfoTable > tbody > tr {
		height: 4vh;
	}
	
	#confirmBtn {
		overflow : hidden;
		cursor : pointer;
	}
	
	#no, #applier, #author {
		background-color: #f1f1f1;
	}
	
</style>


<script type="text/javascript">
	$(document).ready(function(){ 
		
		 $("#myCarousel").carousel({interval: false});
		
		 // Enable Carousel Controls
		  $(".left").click(function(){
		    $("#myCarousel").carousel("prev");
		  });
		  $(".right").click(function(){
		    $("#myCarousel").carousel("next");
		  });
		 
		$("#exhibitioninfo").text("");
		$("#authorinfo").text("");
		$("#exhibitioninfo").text("${ exhibitionInfo.exhibitioninfo }");
		$("#authorinfo").text("${ exhibitionInfo.authorinfo }");
		
		$("#confirmBtn").click(function() {
			
			if(confirm("정말로 전시예정 상태로 바꾸시겠습니까?")) {
				let exhibitionno = "${ no }"; // 상세 페이지로 넘어올때 해당 전시회의 전시회 코드를 함께 넘긴다.
				
				let frm = document.detailFrm;
				frm.method = "POST";
				frm.action = "/artree/displayExhibition.at?exhibitionno=" + exhibitionno;
				frm.submit();
			}
			
		});
		
	}); // --------------------------------------------------------------
</script>

</head>
<body>
	<div id="detailContainer">
		<div class="Title_Area">
			<span class="st">ADMIN ONLY</span>
			<span class="lt">APPLICATION</span>
			<span class="titleDetail">Artree 에 지원된 전시회입니다.</span>
		</div>
		<form name="detailFrm">
			<div id="detailContents">
				<table id="detailTable">
					<tbody>
					<c:if test="${ not empty exhibitionInfo }">
						<tr>
							<td>no.</td><td><input type="text" name="no" id="no" value="${ no }" readonly /></td>
						</tr>
						<tr>
							<td>지원자명</td><td ><input type="text" name="applier" id="applier" value="${ exhibitionInfo.applier }" readonly /></td>
						</tr>
						<tr>
							<td>작가명</td><td><input type="text" name="author" id="author" value="${ exhibitionInfo.author }" readonly /></td>
						</tr>
						<tr>
							<td>작가정보</td><td><textarea id="authorinfo" name="authorinfo" style="resize:none; border:solid 1px lightgray; padding:10px;" rows="5">
							${ exhibitionInfo.authorinfo }
							</textarea></td>
						</tr>
						<tr>
							<td>전시회명</td><td><input type="text" name="exhibitionname" id="exhibitionname" value="${ exhibitionInfo.exhibitionname }" /></td>
						</tr>
						<tr>
							<td>전시회 정보</td><td><textarea id="exhibitioninfo"name="exhibitioninfo"  style="resize:none; border:solid 1px lightgray; padding:10px;" rows="5">
							${ exhibitionInfo.exhibitioninfo }
							</textarea></td>
						</tr>
						<tr>
							<td>전시관</td><td><input type="text" name="gallery" id="gallery" value="${ exhibitionInfo.galleryname }" autocomplete="off" />
							<input type="hidden" name="galleryno" id="galleryno" value="${ exhibitionInfo.galleryno }"/></td>
						</tr>
						<tr>
							<td>일정</td><td><input style="width:130px;" class="pickDate" type="text" name="startdate" id="startDate" autocomplete="off" value="${ exhibitionInfo.startdate }" />
							- 
							<input style="width:130px;" class="pickDate" type="text" name="enddate" id="endDate" autocomplete="off" value="${ exhibitionInfo.enddate }" /></td>
						</tr>
						<tr>
							<td>운영시간</td><td><input type="text" name="openclosetime" id="openclosetime" value="${ exhibitionInfo.openclosetime }" /></td>
						</tr>
						<tr>
							<td>이메일</td><td><input type="text" name="email" id="email" autocomplete="off" value="${ exhibitionInfo.email }" /></td>
						</tr>
						<tr>
							<td>연락처</td><td><input type="text" name="tel" id="tel" autocomplete="off" value="${ exhibitionInfo.tel }" /></td>
						</tr>
						<tr>
							<td>입장료</td><td>
								<input style="width:80px; text-align: right;" type="text" value="${ exhibitionInfo.price }" name="price"> 원
							</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			
			<div id="myPoster" align="center">
				<h2>포스터</h2>
				<div id="poster-wrap">
				<c:if test="${ not empty getImageList }">
					<c:forEach var="img" items="${ getImageList }" varStatus="status">
						<c:if test="${ status.index == 0 }">
						<img id="poster" src="<%= request.getContextPath() %>/resources/files/${ img.mainposter }" name="mainposter" />
						<input type="hidden" name="mainposter" value="${ img.mainposter }">
						</c:if>
					</c:forEach>
				</c:if>
				</div>
			</div>
			
			<div id="myImages" align="center">
				<h2>작품전경</h2> <!--  썸네일 아직 안배워서 일단 이렇게 처리 -->
				<div>
					<c:forEach var="img" items="${ getImageList }" >
						<c:if test="${ img.thumbnailfilename != '없음' }">
						<img class="thumbNail" width="200px" height="200px" src="<%= request.getContextPath() %>/resources/files/${ img.thumbnailfilename }" />   
						<input type="hidden" name="thumbnailfilename" value="${ img.thumbnailfilename }">
						</c:if>
					</c:forEach>
				</div>
				
				<c:if test="${ getImageList != null }">
				<div id="myCarousel" class="carousel slide"  style="display:inline-block; overflow:hidden;">
					<div id="bigImage" align="center" style="display:inline-block; vertical-align: middle;">
					<a class="left" style="display:inline-block;">
						<i class='fa fa-angle-left arrow'></i>
					</a>
					<div class="carousel-inner" role="listbox" style="display:inline-block; width: 500px; min-height: 505px; overflow:hidden; vertical-align: middle;">
						<c:forEach var="img" items="${ getImageList }" varStatus="i">
						<c:if test="${ img.imagefilename != '없음' }">
							<c:if test="${ i.index == 0 }">
						    <div class="item active">
						      <img src="<%= request.getContextPath() %>/resources/files/${ img.imagefilename }" name="imagefilename" alt="" width="400px" height="400px">
						      <input type="hidden" name="image1" value="${ img.imagefilename }">
						    </div>
						    </c:if>
						    
						    <c:if test="${ i.index == 1 }">
						    <div class="item">
						      <img src="<%= request.getContextPath() %>/resources/files/${ img.imagefilename }" name="imagefilename" alt="" width="400px" height="400px">
						      <input type="hidden" name="image2" value="${ img.imagefilename }">
						    </div>
						    </c:if>
						    
						    <c:if test="${ i.index == 2 }">
						    <div class="item">
						      <img src="<%= request.getContextPath() %>/resources/files/${ img.imagefilename }" name="imagefilename" alt="" width="400px" height="400px">
						      <input type="hidden" name="image3" value="${ img.imagefilename }">
						    </div>
						    </c:if>
					    </c:if>
					    </c:forEach>
					</div>
						
						<a class="right" style="display:inline-block;">
							<i class='fa fa-angle-right arrow'></i>
						</a>
					</div>
				</div>
				</c:if>
			
				<div id="extraInfo">
					<table id="extraInfoTable">
						<c:if test="${ not empty getImageList }">
							<c:forEach var="img" items="${ getImageList }" varStatus="status" >
							<tr>
								<td>이미지 ${ status.count } 설명</td>
								<td>
									<input type="text" name="imageinfo" value="${ img.imageinfo }" />
									<input type="hidden" name="image${ status.count }info" value="${ img.imageinfo }" />
								</td>
							</tr>
							</c:forEach>
						</c:if>
						
						<c:if test="${ not empty exhibitionInfo }">
						<tr>
							<td>식음료 반입 가능 여부</td><td><input type="text" class="extraInfo" name="foodordrink" id="foodorDrink" value="${ exhibitionInfo.foodordrink }" /></td>
						</tr>
						<tr>
							<td>촬영 가능 여부</td><td><input type="text" class="extraInfo" name="photo" id="photo" value="${ exhibitionInfo.photo }" /></td>
						</tr>
						<tr>
							<td>기타 관람 제한 사항</td><td><input type="text" class="extraInfo" name="extrarestriction" id="extraRestriction" value="${ exhibitionInfo.extrarestriction }" /></td>
						</tr>
						<tr>
							<td>장르</td><td><input type="text" class="extraInfo" name="genre" id="genre" value="${ exhibitionInfo.genre }" /></td>
						</tr>
						<tr>
							<td>태그</td><td><input type="text" id="tag" name="tag" class="tag" style="width:100%" autocomplete="off" value="${ exhibitionInfo.tag }" /></td>
						</tr>
						</c:if>
					</table>
					<div align="center">
						<img id="confirmBtn" style="height: 60px; width: 170px" src="<%= ctxPath %>/resources/images/exhibition/confirmBtn.png" />
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>