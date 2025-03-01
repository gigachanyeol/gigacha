<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>항상 보이는 Datepicker</title>
<%@ include file="./layout/header.jsp"%>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
#content {
	margin-right: 30px;
	margin-left: 230px;
}

.content_title {
	margin-top: 10px;
	padding-bottom: 5px;
	border-bottom: 1px solid #ccc;
}

.btn-container { /* 추가: 부모 요소 클래스 */
	display: flex;
}

.btn_bg {
	align-items: center;
	justify-content: center;
	width: 100px;
	height: 40px;
	border-radius: 10px;
	text-align: center;
	cursor: pointer;
	box-sizing: border-box;
	margin: 10px 20px;
	line-height: 40px; /* 추가: 세로 가운데 정렬 */
}

.nocheck:hover {
	border: 1px solid red;
}

.nocheck {
	background-color: #E9F3FF;
	color: #2D8CFF;
}

.check {
	background-color: #2388FF;
	color: #E4FAFF;
}

/* 캘린더 스타일 조정 */
#datepicker {
	position: absolute;
	top: 90px;
}
</style>
</head>
<body>
	<%@ include file="./layout/nav.jsp"%>
	<%@ include file="./layout/sidebar.jsp"%>
	<div class="container mt-5"></div>
	<!-- 항상 보이는 달력 -->
	<div id="content">

		<h3 class="content_title">예약하기</h3>
		<table>
			<thead>
				<tr>
					<th class="text-center">회의실명</th>
					<th class="text-center">예약상태</th>
					<td rowspan="5" style="position: relative;" width="270">
						<div id="datepicker"></div>
					</td>
				</tr>
			</thead>
			<tbody>
				<%
				for (int j = 1; j <= 4; j++) {
				%>
				<tr>
					<td>회의실<%=j%>
					</td>
					<td class="text-center">
						<div class="btn-container">
							<div style="display: flex; flex-direction: column;">
								<span>08:00-10:00</span>
								<div class="btn_bg nocheck text-center"
									onclick="toggleCheck(this)">1</div>
							</div>
							<div style="display: flex; flex-direction: column;">
								<span>10:00-12:00</span>
								<div class="btn_bg nocheck text-center"
									onclick="toggleCheck(this)">2</div>
							</div>
							<div style="display: flex; flex-direction: column;">
								<span>13:00-15:00</span>
								<div class="btn_bg nocheck text-center"
									onclick="toggleCheck(this)">3</div>
							</div>
							<div style="display: flex; flex-direction: column;">
								<span>15:00-17:00</span>
								<div class="btn_bg nocheck text-center"
									onclick="toggleCheck(this)">4</div>
							</div>
						</div>

					</td>

				</tr>
				<%
				}
				%>
			</tbody>
		</table>

	</div>

	<script>
		$(document).ready(function() {
			$("#datepicker").datepicker({
				inline : true, // 항상 보이도록 설정
				dateFormat : "yy-mm-dd", // 날짜 형식 설정
				changeYear : true, // 연도 변경 가능
				changeMonth : true, // 월 변경 가능
				showOtherMonths : true, // 이전/다음 달 날짜도 표시
				selectOtherMonths : true, // 다른 달 날짜도 선택 가능
				onSelect : function(dateText) {
					alert("선택한 날짜: " + dateText);
				}
			});
		});

		function toggleCheck(element) {
			$(element).toggleClass("check nocheck");
		}
	</script>


</body>
</html>
