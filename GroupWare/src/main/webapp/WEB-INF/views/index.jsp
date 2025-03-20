<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<%@ include file="./layout/header.jsp"%>
<style type="text/css">
/* 예약 관련 섹션 */
.reservation-section {
	width: 80%;
	background-color: #003366;
	color: white;
	padding: 20px;
	border-radius: 10px;
	text-align: center;
	margin-top: 20px;
}

.reservation-title {
	font-size: 24px;
	font-weight: bold;
}

</style>
</head> 
<body>
<%@ include file="./layout/newNav.jsp" %>
<%@ include file="./layout/newSide.jsp" %>
<main id="main" class="main">
	<div class="row">
		<div id="content" class="col-10">
		 <div class="main-container">
        <!-- 예약 관련 섹션 -->
        <div class="reservation-section">
            <div class="reservation-title">나의 예약현황</div>
            <p>현재 예약된 일정이 없습니다.</p>
            <button class="btn reservation-btn">예약하기</button>
        </div>
    </div>
<!-- 			<h3 class="content_title">제목trestest</h3> -->
<!-- 			<table class="table table-hover"> -->
<!-- 				<thead> -->
<!-- 					<tr> -->
<!-- 						<th>라이브러리</th> -->
<!-- 					</tr> -->
<!-- 				</thead> -->
		<div id="content" class="col">
		${sessionScope.loginDto}
			<h3 class="content_title">제목trestest</h3>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>라이브러리</th>
					</tr>
				</thead>
				
<!-- 				<tbody> -->
<!-- 					<tr> -->
<!-- 						<td><a href="./approval/index.do">jsTree / Editor / signaturepad</a></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td><a href="./grid.do">그리드페이지</a></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td><a href="./droppable.do">드래그앤드롭</a></td> -->
<!-- 					</tr> -->
<%-- 						<td><a href="${pageContext.request.contextPath}/calendar/calendar.do">캘린더</a></td> --%>
<!-- 	      			</tr> -->
<!-- 	      			<tr> -->
<!-- 						<td><a href="./rooms/reservation.do">예약</a></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td><a href="./rooms/roomList.do">회의실 리스트(등록,수정)[관리자]</a></td> -->
<!-- 					</tr> -->
<!-- 				</tbody> -->
<!-- 			</table> -->
			<a href="./login.do" class="btn btn-info">로그인</a><br>
			<a href="./logout.do" class="btn btn-danger">로그아웃</a>
		</div>
	</div>
</main>
	
</body>
</html>
