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
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar"></script>
<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- 구글캘린더 -->

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

.fc-toolbar-title {
	display: inline-block;
}
.ko_event {
    background-color: lightblue !important; /* 한국 기념일 일정 스타일 */
}

.personal-events {
    background-color: lightgreen !important; /* 개인 일정 스타일 */
}
#calendar{
	min-width: 800px;
	margin: 10px auto;
	height: auto;
	width: 1200px;
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
						일정이름 : <input type="text" id="title" /><br />
						<!-- TODO 나중에 시간 넘겨서 받기  -->
						시작시간 : <input type="datetime-local" id="start"
							value="${StartDate}" /><br /> ${StartDate}<br /> ${EndDate}<br />
						종료시간 : <input type="datetime-local" id="end" value="${EndDate}" /><br />
						배경색상 : <select id="color">
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
	var calendar;

	document.addEventListener('DOMContentLoaded', function() {
		const calendarEl = document.getElementById('calendar');
		calendar = new FullCalendar.Calendar(calendarEl, {
// 			 plugins: ['dayGrid', 'googleCalendar'],
			 googleCalendarApiKey: 'AIzaSyCRs4PJQrTEOivYLaBKVB9lZVCbG64D7KE',
			
			 eventSources: [
// 		            {
// 		                googleCalendarId: 'gigachanyeol@gmail.com',
// 		                className: 'personal-events' // 클래스 추가 가능
// 		            },
		            {
		                googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
		                className: 'ko_event' // 한국 공휴일 스타일 적용
		            }
		        ],
			initialView : 'dayGridMonth',
			height : '900px', //캘린더 높이 
			expandRows : true, // 화면에 맞게 높이 재설정
			slotMinTime : '08:00', //DAY 캘린더에서 시작시간
			slotMaxTime : '20:00', //DAY 캘린더에서 종료 시간
			// 임시 보이는 이벤트
			//클릭 이벤트 확인
			eventClick : function(event) {
				//if()
				console.log('클릭!', event.event.title);
				console.log(event.event);
			},
			//일정 생성
			customButtons : {
				addSchedule : {
					text : "일정 등록",
					click : function() {
						// 						alert("일정 등록 하세요!");
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

	//저장
	$("#saveChanges").on(
			"click",
			function() {
				var eventData = {
					title : $("#title").val(),
					start : $("#start").val(),
					end : $("#end").val(),
					color : $("#color").val(),
				};
				//빈값입력시 오류
				if (eventData.title == "" || eventData.start == ""
						|| eventData.end == "") {
					alert("입력하지 않은 값이 있습니다.");

					//끝나는 날짜가 시작하는 날짜보다 값이 크면 안됨
				} else if ($("#start").val() > $("#end").val()) {
					alert("시간을 잘못입력 하셨습니다.");
				} else {
					// 달력 화면에 이벤트 추가 (DB 저장 XXX)
					calendar.addEvent(eventData);
					console.log("일정 추가 : ",eventData)
					$("#exampleModal").modal("hide");
					$("#title").val("");
					$("#start").val("");
					$("#end").val("");
					$("#color").val("");
					
					
					//DB 저장하기
					var allevent = calendar.getEvents(); // 해당 월의 일정들을 모두 가져옴
					fetch('./saveSchedule.do', {
					    method: 'POST',
					    headers: {
					        'Content-Type': 'application/json'
					    },
					    body: JSON.stringify({ events: allevent }) // JSON 데이터로 변환 후 전송
					})
			    		.then(res => res.text())
			    		.then(data => console.log("저장 완료!",data))
			    		.catch(err => console.log(err));

					
					//----------------------------
				}
			});
	
	
	//공휴일 체크
	function isHolidayDate(date){
		
		//공휴일 이벤트 배열 가져오기
		var holidayEvents = calendar.getEvents();
		
		//선택한 날짜와 공휴일 이벤트의 날짜를 비교하여 공휴일 여부 확인
		for(var i = 0; i<holidayEvents.length; i++){
			var holidayDate = new Date(holidayEvents[i].start);
			if(date.getDate() === holidayDate.getDate() &&
					date.getMonth() === holidayDate.getMonth() &&
					date.getFullYear() === holidayDate.getFullYear()){
				return true;//공휴일이면 true 반환
			}
			return false; // 공휴일이 아니면 false 반환
				
				
		}
	}
</script>
</html>
