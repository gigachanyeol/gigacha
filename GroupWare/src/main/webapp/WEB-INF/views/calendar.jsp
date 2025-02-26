<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="./layout/header.jsp"%>
<!-- fullCalendar -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script
	src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.15/locales/ko.global.js"></script>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
#content {
	margin-right: 30px;
	margin-left: 230px;
}

.content_title {
	margin-top: 10px;
	padding-bottom: 5px;
	border-bottom: 1px solid #ccc;
}

.fc-col-header-cell-cushion, .fc-daygrid-day-number {
	text-decoration: none;
}

.fc-scrollgrid-sync-inner>.fc-col-header-cell-cushion, .fc-day-mon .fc-daygrid-day-number,
	.fc-day-tue .fc-daygrid-day-number, .fc-day-wed .fc-daygrid-day-number,
	.fc-day-thu .fc-daygrid-day-number, .fc-day-fri .fc-daygrid-day-number
	{
	color: black;
}

.fc-day-sun .fc-col-header-cell-cushion, .fc-day-sun a {
	color: red;
}

.fc-day-sat .fc-col-header-cell-cushion, .fc-day-sat a {
	color: blue;
}
</style>
</head>
<body>
	<%@ include file="./layout/nav.jsp"%>
	<%@ include file="./layout/sidebar.jsp"%>
	<div id="content">
		<!-- 캘린더 생성 위치 -->
		<div id='calendar-container'>
			<div id='calendar'></div>
		</div>

		<!-- 모달 -->
		<div class="modal fade" id="AddScheduleModal" tabindex="-1"
			aria-labelledby="AddScheduleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="AddScheduleModalLabel">일정 추가하기</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						일정이름 : <input type="text" id="title" /><br /> 시작시간 : <input
							type="datetime-local" id="start" /><br /> 종료시간 : <input
							type="datetime-local" id="end" /><br /> 배경색상 : <select
							id="color">
							<option value="red">빨강색</option>
							<option value="orange">주황색</option>
							<option value="yellow">노랑색</option>
							<option value="green">초록색</option>
							<option value="blue">파랑색</option>
							<option value="indigo">남색</option>
							<option value="purple">보라색</option>
						</select>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" id="saveChanges">
							추가</button>
					</div>
				</div>
			</div>
		</div>


	</div>
</body>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		const calendarEl = document.getElementById('calendar');
		const calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth',
			height:'900px', //캘린더 높이 
			expandRows : true, // 화면에 맞게 높이 재설정
			slotMinTime : '08:00', //DAY 캘린더에서 시작시간
			slotMaxTime : '20:00', //DAY 캘린더에서 종료 시간
			// 임시 보이는 이벤트
			events : [ {
				title : '팀 미팅',
				start : '2025-02-25T10:00:00',
				end : '2025-02-25T11:00:00'
			}, {
				title : '클라이언트 미팅',
				start : '2025-03-13T14:00:00',
				end : '2025-03-15T15:30:00'
			} ],
			//클릭 이벤트 확인
			eventClick : function(info) {
				console.log('클릭!', info.event.title);
				console.log(info.event);
			},
			//일정 생성
			customButtons : {
				addSchedule : {
					text : "일정 등록",
					click : function() {
						// 						alert("일정 등록 하세요!");
						console.log('일정추가');
						$("#AddScheduleModal").modal("show");
						// 						 let myModal = new bootstrap.Modal(document.getElementById('AddScheduleModal'));
						// 				            myModal.show();
					}
				}
			},
			headerToolbar : {
				start : "dayGridMonth,dayGridWeek,dayGridDay",
				center : "prevYear,prev,title,next,nextYear",
				end : "addSchedule"
			},
			views : {
				dayGridMonth : {
					titleFormat : {
						year : 'numeric',
						month : 'long'
					}
				// 예: 2025년 2월
				}
			},
			buttonIcons : {
				prev : 'chevron-left',
				next : 'chevron-right',
				prevYear : 'chevrons-left',
				nextYear : 'chevrons-right'
			},
			locale : "ko"
		});

		calendar.render();
	});
</script>
</html>
