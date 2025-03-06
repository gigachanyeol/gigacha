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
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="card-body">
								<h3 class="card-title" id="modal-title">일정 추가</h3>
								<!-- General Form Elements -->
								<form>
									<div class="row mb-3">
										<label for="empname" class="col-sm-2 col-form-label">등록자</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="empname"
												value="${loginDto.name}" readonly>
										</div>
									</div>
									<div class="row mb-3">
										<label for="empno" class="col-sm-2 col-form-label">사원번호</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="empno"
												value="${loginDto.empno}" readonly>
										</div>
									</div>
									<div class="row mb-3">
										<label for="sch_title" class="col-sm-2 col-form-label">제목</label>
										<div class="col-sm-10">
											<input type="text" class="form-control is-invalid" id="sch_title">
											<div class="invalid-feedback">제목을 입력하세요.</div>
										</div>
									</div>
									<div class="row mb-3">
										<label for="sch_startdate" class="col-sm-2 col-form-label">시작</label>
										<div class="col-sm-10">
											<input type="datetime-local" class="form-control"
												id="sch_startdate">
										</div>
									</div>
									<div class="row mb-3">
										<label for="sch_enddate" class="col-sm-2 col-form-label">종료</label>
										<div class="col-sm-10">
											<input type="datetime-local" class="form-control"
												id="sch_enddate">
										</div>
									</div>
									<div class="row mb-3">
										<label for="sch_color" class="col-sm-2 col-form-label">색상</label>
										<div class="col-sm-10">
											<input type="color" class="form-control form-control-color"
												id="sch_color" title="일정 배경색 선택">
											<!-- 기본값 설정이 필요하다면 value 속성 추가 (예: value="#ff0000" - 빨간색) -->
										</div>
									</div>
									<div class="row mb-3">
                  						<label for="inputcontent" class="col-sm-2 col-form-label">내용</label>
                  						<div class="col-sm-10">
                    						<textarea class="form-control" id="sch_content" style="height: 100px"></textarea>
                  						</div>
                  					</div>
									<div class="row mb-3">
										<div class="col-sm-10 offset-sm-2">
											<button type="button" class="btn btn-outline-secondary me-2"
												data-bs-dismiss="modal">취소</button>
											<button type="button" class="btn btn-outline-success"
												id="saveChanges">추가</button>
										</div>
									</div>
								</form>
								<!-- End General Form Elements -->
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
      $('#sch_content').val(info.event.extendedProps.sch_content);

      // 기존 삭제 버튼 제거 (여기서는 한 번만 실행되므로 안전)
      $("#deleteEvent").remove();

      // 이벤트 수정 모드로 변경
      $("#saveChanges").hide();

      // 삭제 버튼 추가 (한 번만 추가됨)
      $(".col-sm-10.offset-sm-2").append(`<button type="button" class="btn btn-outline-danger me-2" id="deleteEvent">삭제</button>`);
      $(".col-sm-10.offset-sm-2").append(`<button type="button" class="btn btn-outline-danger me-2" id="deleteEvent">저장</button>`);
      
      // 등록자 , 사원번호, 부서명 출력
//       $(".col-sm-10.offset-sm-2").append(`<button type="button" class="btn btn-outline-danger me-2" id="deleteEvent">삭제</button>`);

      // 모달 표시 전에 입력 필드 클래스 설정 (조회 모드)
    	$('#sch_title').removeClass('is-invalid is-valid').addClass('form-control');
    	//필요하다면 다른 input태그에도 적용
      // 모달 표시
      $('#exampleModal').modal('show');
    
    	// 모달이름 변경
    	$('#modal-title').text('일정 조회');

      // 삭제 버튼 이벤트 핸들러 (한 번만 바인딩됨)
      $("#deleteEvent").off("click").on("click", async function() {  // off/on을 #deleteEvent에 직접
          const result = await Swal.fire({
            title: "정말 삭제하시겠습니까?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "삭제",
            cancelButtonText: "취소"
          });

          if (result.isConfirmed) {
            try {
              info.event.remove(); // FullCalendar에서 먼저 삭제
              $("#exampleModal").modal("hide"); //모달 먼저 닫음

              const response = await fetch('./deleteSchedule.do', {
                method: 'DELETE',
                headers: {
                  'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id: info.event.extendedProps.id })
              });

              if (!response.ok) {
                throw new Error("삭제 실패");
              }

              Swal.fire("삭제 완료!", "일정이 삭제되었습니다.", "success");
            } catch (error) {
              Swal.fire("오류 발생", "삭제하는 중 문제가 발생했습니다.", "error");
              console.error(error);
            }
          }
      });
    },
        
        // 모달이 닫힐 때 모든 입력값과 버튼 상태 초기화
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

        	        const response = await fetch(`/GroupWare/calendar/loadSchedule.do?start=${info.startStr}&end=${info.endStr}`);

        	        // 상태 코드별 처리 (기존 코드 유지)
        	        if (response.status === 401) {
        	          // ... (401 처리) ...
        	          return;
        	        } else if (response.status === 403) {
        	          // ... (403 처리) ...
        	          return;
        	        } else if (response.status === 204) {
        	          console.log('📌 조회된 일정이 없습니다.');
        	          successCallback([]); // 빈 배열 전달
        	          return;
        	        } else if (!response.ok) {
        	          throw new Error(`HTTP error! Status: ${response.status}`);
        	        }
        	          const eventData = await response.json(); // ✅ await 사용, 응답을 받음.
        	          console.log("📢 서버에서 받아온 데이터:", eventData);

//         	        loaddate(eventData); // loaddate함수 호출 위치 변경
										const eventArray = eventData.map((res) => ({
        id: res.SCH_ID,
        title: res.SCH_TITLE,
        start: res.SCH_STARTDATE,
        end: res.SCH_ENDDATE,
        backgroundColor: res.SCH_COLOR,
        extendedProps: { 
          empno: res.EMPNO,     
          empname: res.NAME,   
          sch_content: res.SCH_CONTENT,
        },
      }));

      console.log("📌 변환된 이벤트 데이터:", eventArray);
      successCallback(eventArray);



        	      } catch (error) { // catch 블록 시작 위치 변경
        	          console.error("❌ 데이터 처리 중 오류 발생:", error); // 에러 메시지 수정
        	          Swal.fire({  //SweetAlert (오류)
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
      
      // 모달이 닫힐 때 모든 입력값과 버튼 상태 초기화
      $('#exampleModal').on('hidden.bs.modal', function() {
        // 입력 필드 초기화 (로그인 사용자 정보 제외)
        $("#empname").val("${loginDto.name}");
        $("#empno").val("${loginDto.empno}");
        $("#sch_title").val("");
        $("#sch_startdate").val("");
        $("#sch_enddate").val("");
        $("#sch_color").val("");
        $("#sch_content").val("");
        
        // 버튼 상태 초기화
        $("#saveChanges").show();
        $("#deleteEvent").remove();
        
    	$('#sch_title').removeClass('form-control').addClass('form-control is-invalid');
    	
    	$('#modal-title').text('일정 추가');
      });
      
      //모달창 이벤트
      $("#saveChanges").on("click", function() {
    	  
//     	// loginDto가 null인지 확인
//     	    if (!loginDto || loginDto.empno == null) {
//     	        Swal.fire({
//     	            icon: "error",
//     	            title: "로그인 필요",
//     	            text: "사용자 로그인이 필요합니다.",
//     	            footer: '<a href="./login.do">사용자 로그인</a>',
//     	            willClose: () => {
//     	                // 로그인 페이지로 이동
//     	                window.location.href = './login.do';
//     	            }
//     	        });
//     	        failureCallback(new Error('로그인 필요'));
//     	        return;
//     	    }
    	  
    	  
        var eventData = {
          empno: ${loginDto.empno},
          sch_title: $("#sch_title").val(),
          start: $("#sch_startdate").val(),
          end: $("#sch_enddate").val(),
          color: $("#sch_color").val(),
          sch_content:$("#sch_content").val()
        };
        
        // 유효성 검사 추가
        if (eventData.sch_title === "" ) {
          Swal.fire("제목을 입력해주세요.");
          return;
        }else if (eventData.start === "" ) {
          Swal.fire("시작 시간을 입력해주세요.");
          return;
        }else if (eventData.end === "") {
          Swal.fire("종료 시간을 입력해주세요.");
          return;
        }
        
        if (eventData.start > eventData.end) {
          Swal.fire("시작 시간이 종료 시간보다 늦을 수 없습니다.");
          return;
        }
        
//         $("#exampleModal").modal("hide");

			calendar.addEvent(eventData);
            $("#exampleModal").modal("hide");
//             $("#sch_title").val("");
//             $("#sch_title").val("");
//             $("#sch_startdate").val("");
//             $("#sch_enddate").val("");
//             $("#sch_color").val("");
//             $("#sch_content").val("");

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
            Swal.fire("저장 완료!", "일정이 추가되었습니다.", "success");
            
  
          })
          .catch(err => {
            console.error("에러 발생:", err);
            Swal.fire("오류 발생", "일정을 저장하는 중 문제가 발생했습니다.", "error");
          });
      });
      
      // 캘린더 랜더링
      calendar.render();
    });
  })();
  
  document.addEventListener('DOMContentLoaded', function() {
	  const schTitleInput = document.getElementById('sch_title');

	  schTitleInput.addEventListener('input', function() {
	    if (this.value.trim() !== '') {
	      this.classList.remove('is-invalid');
	      this.classList.add('is-valid');
	    } else {
	      this.classList.remove('is-valid');
	      this.classList.add('is-invalid');
	    }
	  });
	    schTitleInput.addEventListener('blur', function() { //focusout도 가능
	    if (this.value.trim() === '') {
	      this.classList.add('is-invalid'); // 빈문자열일때 다시 invalid
	    }
	  });
	});
  
  
//📌 loaddate() 함수에서 받은 데이터 활용
 //📌 loaddate() 함수에서 받은 데이터 활용
  async function loaddate(eventData) {
    try {
      if (!Array.isArray(eventData)) {
        console.error("⚠️ 서버 응답이 배열이 아닙니다:", eventData);
        throw new Error("⚠️ 서버 응답이 배열이 아닙니다.");
      }

      const eventArray = eventData.map((res) => ({
        id: res.SCH_ID,
        title: res.SCH_TITLE,
        start: res.SCH_STARTDATE,
        end: res.SCH_ENDDATE,
        backgroundColor: res.SCH_COLOR || "#3788d8",
        extendedProps: { 
          empno: res.EMPNO,     
          empname: res.NAME,   
          sch_content: res.SCH_CONTENT,
        },
      }));

      console.log("📌 변환된 이벤트 데이터:", eventArray);

      // 🔹 FullCalendar에 이벤트 데이터 추가
      calendar.removeAllEvents(); // 기존 이벤트 삭제
      calendar.addEventSource(eventArray); // 새 데이터 추가
      //calendar.render(); // 캘린더 새로고침  삭제

    } catch (error) {
      console.error("❌ 일정 불러오기 실패:", error);
      Swal.fire({
        icon: "error",
        title: "Oops...",
        text: "일정을 불러오는 중 오류가 발생했습니다.",
      });
    }
  }

</script>
</html>