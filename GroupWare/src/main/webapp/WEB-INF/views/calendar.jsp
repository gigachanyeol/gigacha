<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="./layout/header.jsp"%>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.15/locales/ko.global.js"></script>

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
	.fc-day-thu .fc-daygrid-day-number, .fc-day-fri .fc-daygrid-day-number {
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
	</div>
</body>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		const calendarEl = document.getElementById('calendar');
		const calendar = new FullCalendar.Calendar(calendarEl, {
			initialView: 'dayGridMonth',
			events: [
				{
					title: '팀 미팅',
					start: '2025-02-25T10:00:00',
					end: '2025-02-25T11:00:00'
				},
				{
					title: '클라이언트 미팅',
					start: '2025-03-13T14:00:00',
					end: '2025-03-15T15:30:00'
				}
			],
			eventClick: function(info) {
				console.log('클릭!', info.event.title);
				console.log(info.event);
			},
			headerToolbar: {
				start: "dayGridMonth,timeGridWeek,listWeek,dayGridWeek,multiMonth",
				center: "title",
				end: "prevYear,prev,next,nextYear",
			},
			locale: "ko"
		});
		

		
		calendar.render();
	});
</script>
</html>
