<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar</title>

<%@ include file="./layout/header.jsp"%>
<!-- fullCalendar -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.15/locales/ko.global.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar"></script>
<!-- jQuery UI CSS -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery 및 jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- 구글캘린더 -->

<style type="text/css">
#content {
	margin-right: 30px;
	margin-left: 230px;
}

.content_title {
	margin-top: 50px;
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

.fc-toolbar-title {
	display: inline-block;
}

.ko_event {
	background-color: lightblue !important; /* 한국 기념일 일정 스타일 */
}

.personal-events {
	background-color: lightgreen !important; /* 개인 일정 스타일 */
}

#calendar {
	min-width: 800px;
	margin: 10px auto;
	margin-top: 100px;
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
  <!-- Modal -->
    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">일정 추가하기</h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
          	등록자 : <input type="text" id="empname" value="${loginDto.name}" readonly><br>
			사원번호 : <input type="text" id="empno"  value="${loginDto.empno}" readonly><br>
            일정이름 : <input type="text" id="sch_title" /><br />
            시작시간 : <input type="datetime-local" id="sch_startdate" /><br />
            종료시간 : <input type="datetime-local" id="sch_enddate" /><br />
			배경색상 : <select id="sch_color">
				<option value="red">빨강색🔴</option>
				<option value="orange">주황색🟠</option>
				<option value="yellow">노랑색🟡</option>
				<option value="green">초록색🟢</option>
				<option value="blue">파랑색🔵</option>
				<option value="purple">보라색🟣</option>
				<option value="black">검은색⚫️</option>
			</select>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              취소
            </button>
            <button type="button" class="btn btn-primary" id="saveChanges">
              추가
            </button>
          </div>
        </div>
      </div>
    </div>
    
	</div>
</body>
  <script>
  (function(){
    $(function(){
      // calendar element 취득
      var calendarEl = $('#calendar')[0];
      // full-calendar 생성하기
      var calendar = new FullCalendar.Calendar(calendarEl, {
    	  googleCalendarApiKey: 'AIzaSyCRs4PJQrTEOivYLaBKVB9lZVCbG64D7KE',
        height: '700px', // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
        customButtons:{
        	addSchedule:{
            text:"일정 추가하기",
            click : function(){
                  //부트스트랩 모달 열기
                  $("#exampleModal").modal("show");              
            }
          },
          mySaveButton : {
        		    text: "저장하기",
        		    click: async function (event) {
        		        if (confirm("저장하시겠습니까?")) {
        		        	var allEvents = calendar.getEvents()
        		        	.map(event => event.toPlainObject())  // 이벤트를 JSON 형태로 변환
        		        	.filter(event => (event.extendedProps?.description || "") !== "공휴일"); // 안전한 필터링
//         		            var allEvent = calendar.getEvents().map(event => ({
//         		                title: event.title,
//         		                start: event.startStr,
//         		                end: event.endStr,
//         		                allDay: event.allDay,
//         		                extendedProps: event.extendedProps // 추가적인 속성 포함
//         		            }));

        		            console.log("저장할 이벤트:", allEvents);

        		            fetch('./saveSchedule.do', {
        			            method: 'POST',
        			            headers: { 'Content-Type': 'application/json' },
        			            body: JSON.stringify({ events: allEvents })
        			        })
        		            .then(res => res.text())
        		            .then(data => console.log("저장 완료!", data))
        		            .catch(err => console.log("에러 발생:", err));
        		        }
        		    }
        		},
//           mySaveButton:{
//             text:"저장하기",
//             click: async function () {
//               if (confirm("저장하시겠습니까?")) {
//                 //지금까지 생성된 모든 이벤트 저장하기
//                 var allEvent = calendar.getEvents();
//                 console.log("모든 이벤트들", allEvent);
//                 //이벤트 저장하기
               
// //                 const saveEvent = await axios({
// //                   method: "POST",
// //                   url: "/saveSchedule.do",
// // //                   data: allEvent,
// //                   headers: { "Content-Type": "application/json" },
// //                   data: JSON.stringify({ events: allEvent })
// //                 });
                
//                 fetch('./saveSchedule.do', {
//     	            method: 'POST',
//     	            headers: { 'Content-Type': 'application/json' },
//     	            body: JSON.stringify({ events: userEvents })
//     	        })
//     	        .then(res => res.text())
//     	        .then(data => console.log("저장 완료!", data))
//     	        .catch(err => console.log("에러 발생:", err));
//               }

//             },
//           } //mySaveButton 끝
        },
        // 해더에 표시할 툴바
        headerToolbar: {
			start : "dayGridMonth,dayGridWeek,dayGridDay,mySaveButton",
			center : "prevYear,prev,title,next,nextYear",
			end : "addSchedule"
        },
        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
        // initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
//     	select: function(info) {	// 달력 셀을 클릭할 때 모달 열기
//             $('#exampleModal').modal('show'); 
//         },
eventClick : function(info) {  
    $('#sch_title').val(info.event.title);

    let startDate = info.event.start ? info.event.start.toISOString().slice(0, 16) : '';  
    let endDate = info.event.end ? info.event.end.toISOString().slice(0, 16) : '';  

    $('#sch_startdate').val(startDate);
    $('#sch_enddate').val(endDate);

    $('#sch_color').val(info.event.backgroundColor);
    $('#exampleModal').modal('show'); 
},
        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
          console.log(obj);
        },
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
          console.log(obj);
        },
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
          console.log(obj);
        },
        
        select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
          var title = prompt('Event Title:');
          if (title) {
            calendar.addEvent({
              title: title,
              start: arg.start,
              end: arg.end,
              allDay: arg.allDay
            })
          }
          calendar.unselect()
        },
        //데이터 가져오는 이벤트
        eventSources:[
          {

        	  events: async function (info, successCallback, failureCallback) {
        		  try {
//         			    const response = await fetch("./loadSchedule.do");
						const response = await fetch("${pageContext.request.contextPath}/calendar/loadSchedule.do");

        			    if (!response.ok) {
        			        throw new Error(`HTTP error! Status: ${response.status}`);
        			    }

        			    const eventData = await response.json();
        			    console.log("📢 서버에서 받아온 데이터:", eventData); // 🔍 데이터 구조 확인

        			    if (!Array.isArray(eventData)) {
        			        console.error("⚠️ 서버 응답이 배열이 아닙니다:", eventData);
        			        throw new Error("⚠️ 서버 응답이 배열이 아닙니다.");
        			    }

        			    const eventArray = eventData.map((res) => ({
        		            title: res.SCH_TITLE,  // ✅ 일정 제목
        		            start: new Date(res.SCH_STARTDATE).toISOString(), // ✅ 밀리초 → ISO 형식
        		            end: new Date(res.SCH_ENDDATE).toISOString(), // ✅ 밀리초 → ISO 형식
        		            backgroundColor: res.SCH_COLOR || "#3788d8",  // ✅ 색상 지정 (기본값)
        		        }));
        			    
        			    
        			    console.log("📌 변환된 이벤트 데이터:", eventArray);
        			    
        			    //이벤트 추가
        			    successCallback(eventArray);
        			} catch (error) {
        			    console.error("❌ 일정 불러오기 실패:", error);
        			    failureCallback(error);
        			}

        	  },


          },
            {
              googleCalendarId : 'ko.south_korea.official#holiday@group.v.calendar.google.com',
              backgroundColor: 'red',
            }
        ]
      });

      //모달창 이벤트
      $("#saveChanges").on("click", function () {
            var eventData = {
              title: $("#sch_title").val(),
              start: $("#sch_startdate").val(),
              end: $("#sch_enddate").val(),
              color: $("#sch_color").val(),
            };
            //빈값입력시 오류
            if (
              eventData.title == "" ||
              eventData.start == "" ||
              eventData.end == ""
            ) {
              alert("입력하지 않은 값이 있습니다.");

              //끝나는 날짜가 시작하는 날짜보다 값이 크면 안됨
            } else if ($("#start").val() > $("#end").val()) {
              alert("시간을 잘못입력 하셨습니다.");
            } else {
              // 이벤트 추가
              calendar.addEvent(eventData);
              $("#exampleModal").modal("hide");
              $("#sch_title").val("");
              $("#sch_startdate").val("");
              $("#sch_enddate").val("");
              $("#sch_color").val("");
            }
          });
      // 캘린더 랜더링
      calendar.render();
    });
  })();
</script>
</html>