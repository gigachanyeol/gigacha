<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar</title>

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
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- 구글캘린더 -->

<style type="text/css">

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

#calendar {
	min-width: 800px;
	margin: 10px auto;
	height: auto;
	max-width: 1200px;
}
</style>
</head>
<body>
	<%-- <%@ include file="./layout/nav.jsp" %> --%>
	<%@ include file="./layout/newNav.jsp"%>
	<%-- <%@ include file="./layout/sidebar.jsp" %> --%>
	<%@ include file="./layout/newSide.jsp"%>
	<main id="main" class="main">
		<div class="row">
			<div id="content" class="col-6 mt-3">

				<!-- 캘린더 생성 위치 -->
				<div id='calendar-container'>
					<div id='calendar'></div>
				</div>

				<!-- 모달 -->
				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">일정 추가하기</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
									등록자 : <input type="text" id="empname" value="${loginDto.name}"	readonly><br> 
									사원번호 : <input type="text" id="empno"	value="${loginDto.empno}" readonly><br> 
									일정이름 : <input	type="text" id="sch_title" /><br /> 
									시작시간 : <input	type="datetime-local" id="sch_startdate" /><br /> 
									종료시간 : <input	type="datetime-local" id="sch_enddate" /><br /> 
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
								<button type="button" class="btn mb-1 btn-outline-secondary"
									data-bs-dismiss="modal">취소</button>
								<button type="button" class="btn mb-1 btn-outline-success" id="saveChanges">
									추가</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
<script>
  (function() {
    $(function() {
      // calendar element 취득
      var calendarEl = $('#calendar')[0];
      // full-calendar 생성하기
      var calendar = new FullCalendar.Calendar(calendarEl, {
        // ... (다른 설정들) ...
        googleCalendarApiKey: 'AIzaSyCRs4PJQrTEOivYLaBKVB9lZVCbG64D7KE',
        height: '700px', // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
        customButtons: {
          addSchedule: {
            text: "일정 추가하기",
            click: function() {
              //부트스트랩 모달 열기
              $("#exampleModal").modal("show");
            }
          },
        },
        headerToolbar: {
          start: "dayGridMonth,dayGridWeek,dayGridDay",
          center: "prevYear,prev,title,next,nextYear",
          end: "addSchedule"
        },
        initialView: 'dayGridMonth',
        navLinks: true,
        editable: true,
        selectable: true,
        nowIndicator: true,
        dayMaxEvents: true,
        locale: 'ko',
        // select 콜백은 주석처리하거나, eventClick과 충돌하지 않도록 수정.
        // select: function(info) {
        //   $('#exampleModal').modal('show');
        // },
        
        eventClick: function(info) {
          console.log(info);

          $('#empname').val(info.event.extendedProps.empname);
          $('#empno').val(info.event.extendedProps.empno);

          $('#sch_title').val(info.event.title);

          let startDate = info.event.start ? info.event.start.toISOString().slice(0, 16) : '';
          let endDate = info.event.end ? info.event.end.toISOString().slice(0, 16) : '';

          $('#sch_startdate').val(startDate);
          $('#sch_enddate').val(endDate);
          $('#sch_color').val(info.event.backgroundColor);

          
          $("#saveChanges").hide(); 
          if ($("#deleteEvent").length == 0) { 
              $(".modal-footer").append(`<button type="button" class="btn mb-1 btn-outline-danger" id="deleteEvent">삭제</button>`);
          }

          $('#exampleModal').modal('show');
          $("#deleteEvent").on("click", async function() { // async 추가
        	    const result = await Swal.fire({ // await 추가
        	        title: "정말 삭제하시겠습니까?",
        	        icon: "warning",
        	        showCancelButton: true,
        	        confirmButtonColor: "#d33",
        	        cancelButtonColor: "#3085d6",
        	        confirmButtonText: "삭제",
        	        cancelButtonText: "취소"
        	    });

        	    if (result.isConfirmed) {
        	        try { //try catch로 감쌈
        	            info.event.remove(); // FullCalendar에서 먼저 삭제
        	            $("#exampleModal").modal("hide"); //모달 먼저 닫음

        	            const response = await fetch('./deleteSchedule.do', { //await 추가, DELETE메소드로, body에 데이터
        	                method: 'DELETE',
        	                headers:{
        	                    'Content-Type': 'application/json'
        	                },
        	                body: JSON.stringify({id : info.event.extendedProps.id})
        	            });

        	            if (!response.ok) {
        	                throw new Error("삭제 실패"); // HTTP 오류 처리
        	            }

        	            Swal.fire("삭제 완료!", "일정이 삭제되었습니다.", "success"); //성공시
        	            $("#saveChanges").show(),
        	        	 $("#deleteEvent").remove()
        	        } catch (error) {
        	            Swal.fire("오류 발생", "삭제하는 중 문제가 발생했습니다.", "error"); //오류시
        	            console.error(error);
        	        }
        	    }
        	});
//           $("#deleteEvent").on("click", function() {
//               Swal.fire({
//                   title: "정말 삭제하시겠습니까?",
//                   icon: "warning",
//                   showCancelButton: true,
//                   confirmButtonColor: "#d33",
//                   cancelButtonColor: "#3085d6",
//                   confirmButtonText: "삭제",
//                   cancelButtonText: "취소"
//               });
// //               .then((result) => {
// //                   if (result.isConfirmed) {
// //                 	    console.log("Event ID:", info.event.extendedProps.id); // 디버깅용 로그 추가
// //                       info.event.remove(); // FullCalendar에서 삭제
// //                       $("#exampleModal").modal("hide");
                      
// //                       // 서버에서 삭제
// //                       fetch(`./deleteSchedule.do?id=${info.event.extendeProps.id}`, { method: "POST" })
// //                           .then(response => {
// //                               if (!response.ok) throw new Error("삭제 실패");
// //                               Swal.fire("삭제 완료!", "일정이 삭제되었습니다.", "success");
// //                               $("#saveChanges").show(),
// //                               $("#deleteEvent").remove()
// //                           })
// //                           .catch(err => Swal.fire("오류 발생", "삭제하는 중 문제가 발생했습니다.", "error"));
//                   }
//               });
//           });
         
        },
        
//         $('#exampleModal').on('hidden.bs.modal', function() {
//             $("#saveChanges").show(); //추가 버튼 표시
//         });
        
        eventAdd: function(obj) {
          console.log(obj);
        },
        eventChange: function(obj) {
          console.log(obj);
        },
        eventRemove: function(obj) {
          console.log(obj);
        },

        // eventSources를 사용하여 서버에서 데이터 가져오기
        eventSources: [
          {
            events: async function(info, successCallback, failureCallback) {
              try {
                console.log("📢 요청할 날짜 범위:", info.startStr, " ~ ", info.endStr);

                // ✅ FullCalendar가 요청하는 기간을 서버에 전달
                const response = await fetch(`/GroupWare/calendar/loadSchedule.do?start=${info.startStr}&end=${info.endStr}`);

                // 상태 코드별 처리
                if (response.status === 401) {
                  // 미인증 사용자
                  Swal.fire({
 				  icon: "error",
  				  title: "로그인 필요",
  				  text: "사용자 로그인이 필요합니다.",
  				  footer: '<a href="./login.do">사용자 로그인</a>'
				  });
                  failureCallback(new Error('로그인 필요'));
                  return;
                } else if (response.status === 403) {
                  // 접근 권한 없음
                  Swal.fire({
 				  icon: "error",
  				  title: "권한 없음",
  				  text: "조회할 권한이 없습니다."
				  });
                  
                  failureCallback(new Error('로그인 필요'));
                  failureCallback(new Error('접근 권한 없음'));
                  return;
                } else if (response.status === 204) {
                  // 데이터 없음
                  console.log('📌 조회된 일정이 없습니다.');
                  successCallback([]); // 빈 배열 전달
                  return;
                } else if (!response.ok) {
                  // 기타 오류
                  throw new Error(`HTTP error! Status: ${response.status}`);
                }

                const eventData = await response.json(); // ✅ await 사용
                console.log("📢 서버에서 받아온 데이터:", eventData);


                if (!Array.isArray(eventData)) {
                   console.error("⚠️ 서버 응답이 배열이 아닙니다:", eventData);
                   throw new Error("⚠️ 서버 응답이 배열이 아닙니다.");
                }

               const eventArray = eventData.map((res) => ({
      title: res.SCH_TITLE,
      start: res.SCH_STARTDATE,
      end: res.SCH_ENDDATE,
      backgroundColor: res.SCH_COLOR || "#3788d8",
      extendedProps: { // 모달에는 보여주지 않고 추가로 세팅할것
        empno: res.EMPNO,     
        empname: res.NAME,   
        id:res.SCH_ID,
      },
    }));

                console.log("📌 변환된 이벤트 데이터:", eventArray);

                // ✅ 변환된 데이터를 successCallback에 전달
                successCallback(eventArray);

              } catch (error) {
                console.error("❌ 일정 불러오기 실패:", error);
                Swal.fire({
                	  icon: "error",
                	  title: "Oops...",
                	  text: "일정을 불러오는 중 오류가 발생했습니다.",
                	});
                failureCallback(error);
              }
            },
          },
          {
             googleCalendarId: 'ko.south_korea.official#holiday@group.v.calendar.google.com',
             backgroundColor: 'red', // 필요에 따라 스타일 조정
          }

        ],
      });
        //모달창 이벤트
        $("#saveChanges").on("click", function() {
          var eventData = {
            empno: ${loginDto.empno},
            title: $("#sch_title").val(),
            start: $("#sch_startdate").val(),
            end: $("#sch_enddate").val(),
            color: $("#sch_color").val()
          };
          //빈값입력시 오류
//           if (
//             eventData.title == "" ||
//             eventData.start == "" ||
//             eventData.end == ""
//           ) {
//         	  Swal.fire("입력하지 않은 값이 있습니다.");
//             //끝나는 날짜가 시작하는 날짜보다 값이 크면 안됨
//           } else if ($("#start").val() > $("#end").val()) {
//         	  Swal.fire("시간을 잘못입력 하셨습니다.");
//           } else {
            // 이벤트 추가
            calendar.addEvent(eventData);
            $("#exampleModal").modal("hide");
            $("#sch_title").val("");
            $("#sch_title").val("");
            $("#sch_startdate").val("");
            $("#sch_enddate").val("");
            $("#sch_color").val("");


            console.log("저장할 이벤트:", eventData);

            fetch('./saveSchedule.do', {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                  events: Array.isArray(eventData) ? eventData : [eventData]
                })
              })
              .then(response => {
                if (!response.ok) {
                  throw new Error('Network response was not ok');
                }
                return response.text();
              })
              .then(data => {
                console.log("저장 완료!", data);
              })
              .catch(err => {
                console.error("에러 발생:", err);
              });
//           }
        });
        // 캘린더 랜더링
        calendar.render();
      });
  })();
</script>
</html>