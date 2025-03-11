document.addEventListener('DOMContentLoaded', function() {
	// 요소들
	const timeDisplay = document.querySelector('.time-display');
	const checkInButton = document.querySelector('.btn-check-in');
	const checkOutButton = document.querySelector('.btn-check-out');
	const noticeText = document.querySelector('.notice');

	// 출근 상태를 추적하는 변수들
	let isCheckedIn = false;
	let checkInTime = null;
	let workTimer = null;
	let totalWorkedSeconds = 0;

	// 시간을 HH:MM:SS 형식으로 포맷하는 함수
	function formatTime(seconds) {
		const hours = Math.floor(seconds / 3600);
		const minutes = Math.floor((seconds % 3600) / 60);
		const secs = seconds % 60;

		return [
			hours.toString().padStart(2, '0'),
			minutes.toString().padStart(2, '0'),
			secs.toString().padStart(2, '0')
		].join(':');
	}

	// 내비게이션 바에 현재 날짜와 시간 업데이트
	function updateCurrentDateTime() {
		const navTimeElement = document.querySelector('.navigation .nav-link:first-child');
		const now = new Date();

		const hours = now.getHours();
		const minutes = now.getMinutes();
		const seconds = now.getSeconds();
		const ampm = hours >= 12 ? 'PM' : 'AM';
		const hour12 = hours % 12 || 12;

		const month = now.getMonth() + 1;
		const date = now.getDate();
		const day = ['일', '월', '화', '수', '목', '금', '토'][now.getDay()];

		const timeString = `${hour12}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')} ${ampm} ${month}/${date}(${day})`;
		navTimeElement.innerHTML = `<i class="bi bi-chevron-left"></i> ${timeString}`;

		setTimeout(updateCurrentDateTime, 1000);
	}

	// 근무 타이머 시작
	function startWorkTimer() {
		workTimer = setInterval(() => {
			totalWorkedSeconds++;
			timeDisplay.textContent = formatTime(totalWorkedSeconds);
		}, 1000);
	}

	// 출근 함수
	function checkIn() {
		if (isCheckedIn) return;

		isCheckedIn = true;
		checkInTime = new Date();

		// UI 업데이트
		checkInButton.style.backgroundColor = '#cccccc';
		checkInButton.disabled = true;
		checkOutButton.style.backgroundColor = '#ff6b6b';
		checkOutButton.style.color = 'white';
		checkOutButton.disabled = false;

		noticeText.textContent = '출근 등록이 완료되었습니다. 퇴근하시려면 퇴근 버튼을 눌러주세요.';

		// 타이머 시작
		startWorkTimer();

		// 옵션: 로컬 스토리지나 서버에 출근 기록 저장
		saveAttendanceRecord('check-in', checkInTime);
	}

	// 퇴근 함수
	function checkOut() {
		if (!isCheckedIn) return;

		isCheckedIn = false;
		const checkOutTime = new Date();

		// 타이머 멈추기
		clearInterval(workTimer);

		// UI 업데이트
		checkInButton.style.backgroundColor = '#26c6da';
		checkInButton.disabled = false;
		checkOutButton.style.backgroundColor = 'white';
		checkOutButton.style.color = '#333';
		checkOutButton.disabled = true;

		noticeText.textContent = '퇴근 등록이 완료되었습니다. 오늘 하루도 수고하셨습니다.';

		// 총 근무 시간 계산
		const workDuration = Math.floor((checkOutTime - checkInTime) / 1000);
		timeDisplay.textContent = formatTime(workDuration);

		// 최종 근무 기록 저장
		saveAttendanceRecord('check-out', checkOutTime, workDuration);
	}

	// 출근 기록 저장 (모의 함수 - 실제 구현으로 대체)
	function saveAttendanceRecord(type, time, duration = null) {
		console.log('출근 기록 저장:', {
			type,
			time: time.toISOString(),
			duration
		});

		// 실제 애플리케이션에서는 이 데이터를 서버로 전송
		// 예시:
		/*
		fetch('/api/attendance', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				type,
				time: time.toISOString(),
				duration
			})
		})
		.then(response => response.json())
		.then(data => console.log('성공:', data))
		.catch(error => console.error('오류:', error));
		*/
	}

	// 이전 출근 상태 확인 (예: 로컬 스토리지나 세션에서)
	function checkPreviousState() {
		// 실제 애플리케이션에서는 로컬 스토리지나 서버 세션을 확인
		const storedState = localStorage.getItem('attendanceState');
		if (storedState) {
			const state = JSON.parse(storedState);
			if (state.isCheckedIn) {
				isCheckedIn = true;
				checkInTime = new Date(state.checkInTime);
				totalWorkedSeconds = Math.floor((new Date() - checkInTime) / 1000);
				timeDisplay.textContent = formatTime(totalWorkedSeconds);
				startWorkTimer();

				// UI 업데이트
				checkInButton.style.backgroundColor = '#cccccc';
				checkInButton.disabled = true;
				checkOutButton.style.backgroundColor = '#ff6b6b';
				checkOutButton.style.color = 'white';
				noticeText.textContent = '출근 중입니다. 퇴근하시려면 퇴근 버튼을 눌러주세요.';
			}
		}
	}

	// 현재 월의 데이터를 기반으로 출석 테이블 초기화
	function initAttendanceTable() {
		// 실제로는 서버에서 데이터를 불러오는 작업
		// 예시: fetchAttendanceRecords(year, month);
		
		
	}

	// 이벤트 리스너 설정
	checkInButton.addEventListener('click', checkIn);
	checkOutButton.addEventListener('click', checkOut);

	// 초기화
	updateCurrentDateTime();
	checkPreviousState();
	initAttendanceTable();

	// 선택사항: 출근 중일 때 페이지를 떠날 경우 확인 메시지
	window.addEventListener('beforeunload', function(e) {
		if (isCheckedIn) {
			const message = '출근 상태입니다. 페이지를 나가시겠습니까?';
			e.returnValue = message;
			return message;
		}
	});

	// 입사일
	// 입사일 설정 (예: 2020년 3월 입사)

	var hireDateText = document.getElementById('hiredate').textContent;

	var year = hireDateText.slice(1, 5);
	var month = hireDateText.slice(6, 8);
	var date = hireDateText.slice(9, 12);

	const hireDate = new Date(year, month, date); // 월은 0부터 시작하므로 3월은 2입니다

	// 현재 날짜
	const currentDate = new Date();

	// 년도 셀렉트 박스 채우기
	const yearSelect = document.getElementsByName('yearSelect');
	var selectyear = [];

	// 년도 옵션 생성
	for (let year = hireDate.getFullYear(); year <= currentDate.getFullYear(); year++) {
		const option = document.createElement('option');
		option.value = year;
		option.textContent = year + '년';
		selectyear.push(option);
	}

	// 모든 yearSelect 요소에 옵션을 추가
	for (var i = 0; i < yearSelect.length; i++) {
		for (var j = 0; j < selectyear.length; j++) {
			yearSelect[i].appendChild(selectyear[j].cloneNode(true));
		}

		// 현재 년도 기본 선택
		yearSelect[i].value = currentDate.getFullYear();  // 현재 년도로 선택
	}

	// 로그로 선택된 년도 확인
	//	console.log(yearSelect);

	// 월 셀렉트 박스 채우기
	function populateMonths(startMonth = 0) {
		// 기존 옵션 삭제
		monthSelect.innerHTML = '';

		const endMonth = (getCurrentYearValue() == currentDate.getFullYear())
			? currentDate.getMonth()
			: 11;

		for (let month = startMonth; month <= endMonth; month++) {
			const option = document.createElement('option');
			option.value = month + 1; // 월은 1부터 시작
			option.textContent = (month + 1) + '월';

			// 현재 월을 기본 선택
			if (month == currentDate.getMonth() &&
				getCurrentYearValue() == currentDate.getFullYear()) {
				option.selected = true;
			}

			monthSelect.appendChild(option);
		}
	}

	// yearSelect에서 현재 선택된 값을 가져오는 함수
	function getCurrentYearValue() {
		for (var i = 0; i < yearSelect.length; i++) {
			if (yearSelect[i].selectedIndex != -1) {
				return parseInt(yearSelect[i].options[yearSelect[i].selectedIndex].value);
			}
		}
		return currentDate.getFullYear(); // 기본값으로 현재 년도 반환
	}

	// 모든 yearSelect 요소에 change 이벤트 리스너 추가
	for (var i = 0; i < yearSelect.length; i++) {
		yearSelect[i].addEventListener('change', function() {
			const selectedYear = parseInt(this.value);

			if (selectedYear == hireDate.getFullYear()) {
				// 입사 년도면 입사 월부터 시작
				populateMonths(hireDate.getMonth());
			} else {
				// 다른 년도면 1월부터 시작
				populateMonths();
			}

			// 테이블 업데이트
			const selectedMonth = parseInt(monthSelect.value) - 1;
			populateDates(selectedYear, selectedMonth);
		});
	}

	// 초기 월 옵션 설정
	if (getCurrentYearValue() == hireDate.getFullYear()) {
		populateMonths(hireDate.getMonth());
	} else {
		populateMonths();
	}

	// 근무일수 계산하기
	// 경과 시간 계산
	var yearDiff = currentDate.getFullYear() - hireDate.getFullYear();
	var monthDiff = currentDate.getMonth() - hireDate.getMonth();

	// 월 차이가 음수인 경우 년도에서 1을 빼고 월에 12를 더함
	if (monthDiff < 0) {
		yearDiff--;
		monthDiff += 12;
	}

	// 일자 비교 - 현재 일자가 입사 일자보다 작으면 월에서 1을 뺌
	if (currentDate.getDate() < hireDate.getDate()) {
		monthDiff--;
		if (monthDiff < 0) {
			yearDiff--;
			monthDiff += 12;
		}
	}

	// 결과 생성
	var tenureText = yearDiff + "년 " + monthDiff + "개월";

	// 콘솔에도 표시 (디버깅용)
	console.log("근무 기간: " + tenureText);
	document.getElementById('hiredate').innerHTML = year + "-" + month + "-" + date;
	document.getElementById('hiredateText').innerHTML = "(" + tenureText + ")";

	// 표 미리 만들어두기
	const tbody = document.getElementById('attendanceTable').querySelector('tbody');

	/// 월에 맞는 일자를 채우는 함수
	function populateDates(year, month) {
		tbody.innerHTML = ''; // 기존의 테이블 데이터 삭제

		const daysInMonth = new Date(year, month + 1, 0).getDate(); // month + 1로 해당 월의 마지막 날짜를 구함
		const today = new Date();
		const todayYear = today.getFullYear();
		const todayMonth = today.getMonth();
		const todayDate = today.getDate();

		// 요일 배열 (일, 월, 화, 수, 목, 금, 토)
		const weekdays = ['일', '월', '화', '수', '목', '금', '토'];

		for (let day = 1; day <= daysInMonth; day++) {
			const row = document.createElement('tr');

			// 일자 셀 생성
			const dateCell = document.createElement('td');
			// 날짜 값을 YYYYMMDD 형식으로 변환
			const formattedDate = `${year}${String(month + 1).padStart(2, '0')}${String(day).padStart(2, '0')}`;

			// 고유한 id를 날짜 형식에 '-5'를 추가하여 설정
			dateCell.id = `${formattedDate}`;

			//			console.log(dateCell.id);

			// 날짜와 요일 표시
			const date = new Date(year, month, day);
			const dayOfWeek = date.getDay(); // 0: 일요일, 6: 토요일
			dateCell.textContent = `${month + 1}월 ${day}일 (${weekdays[dayOfWeek]})`; // 예: 3월 1일(화)

			// 오늘 날짜일 경우 색상 추가
			if (year === todayYear && month === todayMonth && day === todayDate) {
				dateCell.style.fontWeight = 'bold';  // 글자 굵게 만들기
				row.classList.add('table-warning', 'text-white'); // 오늘 날짜에 배경색 추가
			}

			// 주말 체크 (토요일=6, 일요일=0)
			if (dayOfWeek === 6) {
				dateCell.style.color = 'blue'; // 토요일은 파란색
			} else if (dayOfWeek === 0) {
				dateCell.style.color = 'red'; // 일요일은 빨간색
			}

			row.appendChild(dateCell);
			// 출근, 퇴근, 연장, 야간, 합계, 상태 셀을 추가 (빈 셀로)
			for (let i = 0; i < 6; i++) {
				const emptyCell = document.createElement('td');
				//각 td마다 id 지정~!

				emptyCell.id = `${formattedDate}-${i}`;
				row.appendChild(emptyCell);

			}

			// 생성된 행을 tbody에 추가
			tbody.appendChild(row);
		}
		
			fetchLeaveData();
	}

	// 모든 yearSelect 요소에 변경 이벤트 추가(이미 위에서 추가했음)

	// 월 셀렉트 박스 변경 시 테이블 업데이트
	monthSelect.addEventListener('change', function() {
		const selectedYear = getCurrentYearValue();
		const selectedMonth = parseInt(this.value) - 1;
		populateDates(selectedYear, selectedMonth);
		
	});

	// 기본 값으로 현재 월에 맞는 일자 채우기
	const currentYear = new Date().getFullYear();
	const currentMonth = new Date().getMonth();
	populateDates(currentYear, currentMonth);

	//클릭한 행 가져오기 
	tbody.addEventListener('click', function(event) {
		// 클릭된 요소가 'tr'인 경우에만 처리
		if (event.target.closest('tr')) {
			const clickedRow = event.target.closest('tr'); // 클릭한 행 (tr 요소)

			// 클릭된 행에 대한 처리 (예: 행 색상 변경, 데이터 출력 등)
			console.log('클릭한 행:', clickedRow.children[0].textContent, clickedRow);

			// 원하는 처리 추가 (예: 스타일 변경, 데이터 가져오기 등)
			//clickedRow.classList.toggle('highlight'); // 예: 클릭한 행에 하이라이트 클래스 추가
		}
	});

	function formatDate(timestamp) {
		const date = new Date(timestamp);
		return date.toISOString().split("T")[0]; // YYYY-MM-DD 형식 변환
	}

	function fetchLeaveData(){
		fetch(`${pageContext}/attendance/loadleave.do`)
			.then(response => response.json()) // 응답을 JSON 형식으로 파싱
			.then(data => {
				console.log("📌 서버에서 받은 데이터를 출력:", data);

				data.forEach(item => {
					const START_DATE = formatDate(item.START_DATE);
					const END_DATE = formatDate(item.END_DATE);

					//				console.log("📌 START_DATE:", START_DATE);
					//            console.log("📌 END_DATE:", END_DATE);

					// 날짜에 해당하는 요소 ID를 생성
					var searchtd = `${START_DATE.replace(/-/g, '')}-5`;
					//				console.log("📌 searchtd:", searchtd);
					// 해당 날짜의 셀에 '연차' 추가
					const targetElement = document.getElementById(searchtd);
					console.log("📌 targetElement:", targetElement);

					if (targetElement) {
						targetElement.innerHTML += `연차`;
					}
				});
			})
			.catch(error => console.error("📌 데이터 로드 중 오류 발생:", error));
	}

});